#include "../uniformShaderConstants.h"
#include "../uniformPerFrameConstants.h"

float lightDotSimple(vec3 lightDirrection, vec3 normalDirrection){
  return max(dot(lightDirrection, normalDirrection), 0.0);
}

float lightDotAdvanced(vec3 lightDirrection, vec3 normalDirrection, float lightWrapping){
    return max((dot(lightDirrection, normalDirrection) + lightWrapping)/(1.0 + lightWrapping),0.0);
}

vec3 calculatePointLights(float uvX){
    	// Torches, lamps and lava lights
	float srcPointLights = uvX;
	float nearPointLightsBrightness = pow(srcPointLights * 1.15, 32.0);
	float overalPointLightsBrightness = pow(srcPointLights, 2.0) * 0.5 + nearPointLightsBrightness;
	overalPointLightsBrightness *= 2.0;
	overalPointLightsBrightness = clamp(overalPointLightsBrightness, 0.0, 2.0);
	vec3 pointLightsTint = vec3(1.0, 0.66, 0.33);
	return vec3(overalPointLightsBrightness) * pointLightsTint;
//  return vec3(0.5);
}

vec4 calculateCaustics(sampler2D texture0, vec3 position){
    	highp float time = TIME;
		highp float causticsSpeed = 0.05;
		float causticsScale = 0.1;
		
		highp vec2 cauLayerCoord_0 = (position.xz + vec2(position.y / 8.0)) * causticsScale + vec2(time * causticsSpeed);
		highp vec2 cauLayerCoord_1 = (-position.xz - vec2(position.y / 8.0)) * causticsScale*0.876 + vec2(time * causticsSpeed);


		vec2 noiseTexOffset = vec2(5.0/64.0, 1.0/64.0); 
		float caustics = texture2D(texture0, fract(cauLayerCoord_0)*0.015625 + noiseTexOffset).r;
		caustics += texture2D(texture0, fract(cauLayerCoord_1)*0.015625 + noiseTexOffset).r;
		
		
		caustics = clamp(caustics, 0.0, 2.0);
		if(caustics > 1.0){
			caustics = 2.0 - caustics;
		}
		float cauHardness = 2.0;
		float cauStrength = 0.8;
// 		caustics = pow(caustics * cauStrength * (0.2 + length(FOG_COLOR.rgb)) , cauHardness);

		return vec4(caustics);
        // return vec4(0.0);
}