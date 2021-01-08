#define NORMAL_MAPPING 
#define POINT_LIGHTS_NORMALS
#define WATER_NORMAL_LAYERS 4 // min -2; max - 4

#define PARALAX_MAPPING
#define ADVANCED_PARALAX_MAPPING //false - simple parax, true - pom
#define POM_STEPS 16 // min - 2; max - 16

#define MER_MAPPING
#define REFLECTION_BLUR_STEPS 16 //min - 2; max - 16

#define REFLECT_CUBEMAP
#define REFLECT_CLOUDS
#define CLOUD_REFLECTION_DETAIL  4

#define CUMULUS_CLOUDDS
#define HIGH_CLOUDS
#define CLOUDS_DETAIL 8 //min 2; max - 8

#define SKY_ZENITH_COLORIZE

#define BLINN_PHONG //default specular
#define PHONG //spetial effect for sunrizes and sunsets

#define FRESNEL
#define SKY_LIGHT // if it is not enabled default in game AO will be used
#define FAKE_GI 
#define FAKE_GI_NORMALS

#define FOLIAGE_WAVING
#define ADVANCED_FOLIAGE_WAVING // more random foliage_waving

#define WATER_WAVING
#define ADWANCED_WATER_WAVING //more random waving

#define BLUE_FOG
#define MILKY_FOG
#define FAR_FOG