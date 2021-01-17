#include "../uniformPerFrameConstants"

vec3 calculatePuddles(sampler2D texture0, vec2 position, float isRain, float darkness){
	float puddlesSharpness = 2.0;
	float puddlesCovering = 1.5;
	float puddlesScale = 32.0;
	float minRainWettneess = 0.25;

	vec2 noiseTextureOffset = vec2(1.0/32.0, 0.0); 
	float puddles = texture(texture0, fract(position  / puddlesScale)/32.0 + noiseTextureOffset).r;
	puddles = pow(puddles * isRain * puddlesCovering, puddlesSharpness);
	puddles = clamp(puddles, minRainWettneess, 1.0);

	return vec3(puddles * pow(darkness, 2.0));// No puddles in dark places like caves
    // return vec3(0.5);
}

vec3 calculateWaterNormal(sampler2D texture0, vec2 position){
		highp float t = TIME * 0.1;
		float wnScale = 1.0;
		vec2 waterNormalOffset = vec2(4.0/32.0, 0.0);

		// TODO resolve interpolation issues on edges using a more correct way (currently it is wierd)
		vec3 normalMap = texture2D(texture0, fract(position*1.0*wnScale + t*wnScale * 2.0)/33.0 + waterNormalOffset).rgb;
		normalMap += texture2D(texture0, fract(position*0.5*wnScale - t*wnScale * 1.5)/33.0 + waterNormalOffset).rgb;
		normalMap += texture2D(texture0, fract(position*0.25*wnScale + t*wnScale * 1.15)/33.0 + waterNormalOffset).rgb;
		normalMap += texture2D(texture0, fract(position*0.125*wnScale - t*wnScale*0.9)/33.0 + waterNormalOffset).rgb;
		
		// normalMap *= 0.5;
		// normalMap *= 0.33;
		return normalMap * 0.25;
}

vec3 rotateNormalMap(vec3 normalMap, vec3 normalColor){
    
    // Fake TBN transformations for normalmapps
    // TODO: Weird thing and takes alot of performance because of branching
    // TODO: Needs refactoring
    if(length(normalMap.rgb) > 0.9){
        
        float normalMapStrength = 2.0;

        if(normalColor.g > 0.9){
            normalMap.gb = normalMap.bg;
            normalMap.rgb = normalMap.rgb * 2.0 - 1.0;
            normalMap.rb *= normalMapStrength;
            normalColor.rgb = normalize(normalMap.rgb);
        }else{
            if(normalColor.g < -0.9){
                normalMap.b = -normalMap.b;
                normalMap.gb = normalMap.bg;
                normalMap.rgb = normalMap.rgb * 2.0 - 1.0;
                normalMap.rb *= normalMapStrength;
                normalColor.rgb = normalize(normalMap.rgb);
            }else{
                if (normalColor.b > 0.9){
                    normalMap.g = 1.0 - normalMap.g;// OpenGl needs G to be flipped
                    normalMap.rgb = normalMap.rgb * 2.0 - 1.0;
                    normalMap.rg *= normalMapStrength;
                    normalColor.rgb = normalize(normalMap.rgb);
    
                }else{
                    if(normalColor.b < -0.9){
                        normalMap.b = -normalMap.b;
                        normalMap.g = 1.0 - normalMap.g;// OpenGl G flip
                        normalMap.r = 1.0 - normalMap.r;
                        normalMap.rg = normalMap.rg * 2.0 - 1.0;
                        normalMap.b = normalMap.b * 2.0 + 1.0;
                        normalMap.rg *= normalMapStrength;
                        normalColor.rgb = normalize(normalMap.rgb);
                    }else{
                        if(normalColor.r > 0.9){
                            normalMap.g = 1.0 - normalMap.g;// OpenGl G flip
                            normalMap.r = 1.0 - normalMap.r;
                            normalMap.rb = normalMap.br;
                            normalMap.rgb = normalMap.rgb * 2.0 - 1.0;
                            normalMap.gb *= normalMapStrength;
                            normalColor.rgb = normalize(normalMap.rgb);
                        }else{
                            if(normalColor.r < -0.9){
                                normalMap.b = -normalMap.b;
                                normalMap.g = 1.0 - normalMap.g;//OpenGl G flip
                                normalMap.rb = normalMap.br;
                                normalMap.gb = normalMap.gb * 2.0 - 1.0;
                                normalMap.r = normalMap.r * 2.0 + 1.0;
                                normalMap.gb *= normalMapStrength;
                                normalColor.rgb = normalize(normalMap.rgb);
                            }
                        }
                    }
                }
            }
        }
    }
    return normalColor;

}




/////////////////////////////////////////////some experiments with TBN calculation ///////////////////////////////////////////////

// vec3 rotateNormalMap(vec3 normalMap, vec3 initNormalColor, vec2 uv0, vec3 dp1, vec3 dp2){
//     highp vec2 duv1 = dFdx(uv0);
//     highp vec2 duv2 = dFdy(uv0);

//     highp vec3 dp2perp = cross(dp2, initNormalColor);
//     highp vec3 dp1perp = cross(initNormalColor, dp1);

//     highp vec3 T = normalize(dp2perp * duv1.x + dp1perp * duv2.x);
//     highp vec3 B = normalize(dp2perp * duv1.y + dp1perp * duv2.y);

//     highp float invmax = inversesqrt(max(dot(T,T), dot(B,B)));
    
//     highp mat3 tbn = mat3(T, B, initNormalColor);

//     normalMap.rgb = normalMap.rgb * 2.0 - 1.0;
    
//     return tbn * normalMap.rgb;
// }





// vec3 rotateNormalMap(vec3 initNormalColor, vec3 normalColor, vec3 normalMap, vec3 position, vec2 uv0){
//     highp vec3 q1 = dFdx(-position.xyz);
//     highp vec3 q2 = dFdy(-position.xyz);

//     highp vec2 st1 = dFdx(uv0);
//     highp vec2 st2 = dFdy(uv0);

//     highp vec3 T = normalize(q1*st2.t - q2*st1.t);
//     highp vec3 B = normalize(-q1*st2.s + q2*st1.s);

//     highp mat3 tbn = mat3(T, B, initNormalColor);

//     normalColor.rgb = normalColor.rgb * 2.0 - 1.0;

//     return normalMap.rgb * tbn;
// }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// highp vec2 parallax(highp vec2 uv, highp vec3 viewDir){
    
//     highp vec3 n = vec3(0.0, 1.0, 0.0);
//     highp vec3 t = vec3(0.0, 0.0, 1.0);
//     highp vec3 b = vec3(1.0, 0.0, 0.0);

//     highp mat3 tbn = transpose(mat3(t, b, n));

//     viewDir = tbn * viewDir;

//     highp float height_scale = 0.01;

//     //highp float height = texture2D(TEXTURE_0, uv).b;
//     highp float height = 0.5;
//     highp vec2 p = viewDir.xy / viewDir.z * (height * height_scale);

//     //return uv;
//     return uv - p;
// }