
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
