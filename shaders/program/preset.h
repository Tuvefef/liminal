#ifndef PRESET_H_GLSL_LIB
#define PRESET_H_GLSL_LIB 1
#define GLSL_CTRL 1

#ifdef GLSL_CTRL 
#define BLOOM_LIGHT
#define LOW_RES
#define DITHERING

#define rgbaChannel 3 //[0 1 2 3]

#define bloomIntensity 1.0 //[0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0]
#define luminanceBias 0.6 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
#define luminanceDetect 0.3 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
#define bloomRadius 0.002 //[0.001 0.002 0.003]

#define IMG_NOISE
#define noiseIntensity 2.0 //[0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0]

#define FLICKER
#define flickerIntensity 0.3 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9]
#define flickerVelocity 2.0 //[0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0]

#define CHROMA_ABERRATION
#define chromaAbberationIntensity 1.5 //[0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5]

#define ditheringLevel 4.0 //[2.0 4.0 6.0 8.0]

/* macros in functions */

float gpowx2(float x) { return x * x; }
float gpowx3(float x) { return gpowx2(x) * x; }
float gpowx4(float x) { return gpowx3(x) * x; }

#endif
#endif