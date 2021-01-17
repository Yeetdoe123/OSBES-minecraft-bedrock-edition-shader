#include "../uniformPerFrameConstants.h"
#include "../uniformShaderConstants"
#include "helpers.glsl"

float calculateCloudsBase(vec2 position, float speed,float scale, int detail){
    highp float time = TIME;

	highp vec2 cldCoord = position * scale;
	cldCoord += vec2(time * speed);
	
	float resultDevider = 128.0;
	float clouds = rand_bilinear(cldCoord) * 128.0;
	
	float scaleMult = 2.0;
	float additionMult = 64.0;
	for(int i = 0; i < detail; i++){
	    clouds += rand_bilinear(position * scale * scaleMult) * additionMult;
	    scaleMult *= 2.0;
	    resultDevider += additionMult;
	    additionMult /= 2.0;
	}

	return clouds / resultDevider;
}


vec3 colorizeClouds(float cloudsBase, float cloudsCutout, float isRain, vec3 skyColor){
	float cloudsShadow = pow(clamp(cloudsBase * 1.5, 0.0, 1.0), 0.75);
	
	vec3 cloudsColor = vec3(1.5) * pow(length(FOG_COLOR.gb), 2.0);
	vec3 clearSkyCloudsShadowColor = (skyColor * (0.5 + pow(length(FOG_COLOR.gb), 2.0) * 0.5)) * 0.75;
	vec3 rainSkyCloudsShadowColor = cloudsColor;
	vec3 cloudsShadowColor = mix(clearSkyCloudsShadowColor, rainSkyCloudsShadowColor, isRain);
	
	cloudsShadowColor = mix(cloudsShadowColor, vec3(length(cloudsShadowColor)), 0.125); //desaturate

	return mix(cloudsColor, cloudsShadowColor, cloudsShadow);
}