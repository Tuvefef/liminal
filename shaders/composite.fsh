#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex10;
uniform float frameTime;

in vec2 gfragtexcoord;

#include "program/preset.h"
#include "program/commons.glsl"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 gfragcolor0;

float selectChannelRGBA(vec4 gdatavec, int gselectvec)
{
         if(gselectvec == 0) return gdatavec.r;
    else if(gselectvec == 1) return gdatavec.g;
    else if(gselectvec == 2) return gdatavec.b;
    else                     return gdatavec.a;
}

vec4 chromaticAberrationImg(sampler2D samplerImg, vec2 gdatacoord)
{
    vec4 gout = vec4(0.0);
    vec2 gcentered = centervec(gdatacoord);
    //float gdist = mag0(gcentered);
    //float pulse = 0.5 + 0.5 * sin(frameTime * 8.0 + gdist * 10.0);
    float gsmoothdist = correctCenter(gcentered);

    gout.r = texture2D(samplerImg, gdatacoord + (gcentered * cvecr * gsmoothdist) * chromaAbberationIntensity).r;
    gout.g = texture2D(samplerImg, gdatacoord + (gcentered * cvecg * gsmoothdist) * chromaAbberationIntensity).g;
    gout.b = texture2D(samplerImg, gdatacoord + (gcentered * cvecb * gsmoothdist) * chromaAbberationIntensity).b;

    float gmincolor = minx3(gout.r, gout.g, gout.b);
    gout.rgb = mix(vec3(gmincolor), gout.rgb, 0.5 + 0.5 * gsmoothdist);

    return gout;
}

float linearBlueNoiseRGB(sampler2D samplerNoise, vec2 gdatatexcoord0, int gchannel)
{
    vec2 ganim = vec2(sin(frameTime * 0.4), cos(frameTime * 0.1));
    vec4 grenderNoise = texture2D(samplerNoise, fract(gdatatexcoord0 * 7.9 + ganim));
    return selectChannelRGBA(grenderNoise, gchannel);
}

void main()
{
    vec4 gfragfinal = texture2D(colortex0, gfragtexcoord);
    //gfragfinal.rgb *= vec3(0.3961, 0.4314, 0.6314);

    float glum = luma(gfragfinal.rgb);
    vec3 chroma = gfragfinal.rgb - vec3(glum);
    chroma = qtzn0(chroma, 16.0);
    float gflicker = 0.96 + flickerIntensity * sin(frameTime * flickerVelocity);
    float glow = smoothstep(0.35, 1.0, glum);
    
    #ifdef CHROMA_ABERRATION
    gfragfinal = chromaticAberrationImg(colortex0, gfragtexcoord);
    #endif

    float n = linearBlueNoiseRGB(colortex10, gfragtexcoord * 4.0 + (frameTime), rgbaChannel);
    float gnoise = mix(0.02, 0.08, luma(gfragfinal.rgb)) * noiseIntensity;

    #ifdef IMG_NOISE
    gfragfinal.rgb += (n - 0.5) * gnoise * inverse(glum);
    #endif

    #ifndef CHROMA
    gfragfinal.rgb = chroma + (gfragfinal.rgb - chroma) * 1.04;
    #endif

    #ifdef FLICKER
    gfragfinal.rgb *= smoothcube(gflicker);
    #endif

    #ifdef WAHS
    gfragfinal.rgb = qtzn0(gfragfinal.rgb, washedImg);
    #endif
    gfragfinal.rgb += smoothcube(powx2(max0(glow))) * 0.08;
    gfragfinal.rgb *= mix(cgreentint, cbluetint, glow);

    gfragcolor0 = gfragfinal;
}