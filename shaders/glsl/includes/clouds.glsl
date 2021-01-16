#include "../uniformPerFrameConstants.h"
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