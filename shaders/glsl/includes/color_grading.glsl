
vec4 colorGrading(vec4 color){
    
    vec3 tint = vec3(1.5, 1.25, 1.0)*2.75;
	color.rgb *= tint;

	float contrast = 2.0;
	color.rgb = pow(color.rgb, vec3(contrast));

	// Tone compensation
	color.rgb = color.rgb/(color.rgb + vec3(1.0));
	
	// Gamma correction
	float gamma = 1.0;
	color.rgb = pow(color.rgb, vec3(1.0 / gamma));

	float saturation = 1.0;
	float grayScale = (color.r + color.g + color.b) / 3.0;
	color.rgb = mix(vec3(grayScale), color.rgb, saturation);
	
	
	return color;
}