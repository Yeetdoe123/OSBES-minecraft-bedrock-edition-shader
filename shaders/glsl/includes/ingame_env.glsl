#include "../uniformShaderConstants.h"
	
	// Bottom left pixel becomes bluish at night. So we can get exact day time by calulating how much bigger b is than g
	float detectDay(in sampler2D lightingGradient){
	    vec3 dayTimeDetectionPixel = texture2D(lightingGradient, vec2(0.0, 1.0)).rgb;
	    float dayTime = dayTimeDetectionPixel.g / dayTimeDetectionPixel.b;
	    return pow(dayTime, 5.0);
	}
	
	float detectSunrize(vec3 inGameFogColor){
        float isSunrize = dot(normalize(inGameFogColor), vec3(1.0, 0.0, 0.0));
	    return pow(isSunrize, 4.0);
	}

    float detectHell(in sampler2D lightingGradient){
	// Top left pixel is darker in overworld and brighter in the Nether
        float hellDetectionPixel = texture2D(lightingGradient, vec2(0.0)).r;
        float isHell = 0.0;
	    if (hellDetectionPixel > 0.15){
	    	isHell = 1.0;
	    }
	    
	    return isHell;
    }
    
    
    float detectRain(float fogControlR){
        float isRain = 0.5 - fogControlR;
        return clamp(isRain * 5.0, 0.0, 1.0);
    }
    
    float detectUnderWater(vec3 fogColor){
        
        // Get the shade (not related to brightness) of fog_color
    	vec3 fogColorNormalized = normalize(fogColor);
    	if(fogColorNormalized.r < 0.22 
    	&& fogColorNormalized.b < 0.90 && fogColorNormalized.b > 0.77
    	&& fogColorNormalized.g < 0.61 && fogColorNormalized.g > 0.44){
    		return 1.0;
    	}
    	
    	return 0.0;
    }
    
    
    
    // deprecated
    float detectRain(vec3 fogColor, float fogControlG){
        // Get the shade (not related to brightness) of fog_color
        float isRain = 1.0 - length(normalize(vec3(1.0)) - normalize(fogColor));// Calculate how complimentary fog color with gray color
	    isRain = pow(isRain, 16.0);
	    if(fogControlG > 0.95){
	    	isRain = 0.0;
    	}
        return isRain;
    }
    
