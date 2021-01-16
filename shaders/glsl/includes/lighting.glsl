#include "../uniformShaderConstants.h"

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