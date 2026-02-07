#version 330 compatibility

uniform sampler2D colortex0;
uniform float frameTime;

in vec2 gfragtexcoord;

#include "program/preset.h"
#include "program/commons.glsl"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 gfragcolor0;

void main()
{
    vec4 gfragfinal = texture2D(colortex0, gfragtexcoord);
    float gLum = luma(gfragfinal.rgb);

    vec3 gout0 = vec3(0.0);
    float gtotal = 0.0;

    for (int e = -3; e <= 3; e++)
    {
        for (int f = -3; f <= 3; f++)
        {
            vec2 gGlowImgs = vec2(float(e), float(f) * 1.5) * bloomRadius;
            float gWeight = exp(-mag2(gGlowImgs) / 6.0);

            vec3 gSmpColor = texture2D(colortex0, gfragtexcoord + gGlowImgs).rgb;
            float gSmpLuma = luma(gSmpColor);
            float gSmpMsk = smoothcube(smoothstep(luminanceBias, 1.0, gSmpLuma));

            gout0 += maxx3(gSmpColor.r, gSmpColor.g, gSmpColor.b) * gSmpMsk * gWeight;
            gtotal += max0(gWeight);
        }
    }
    gout0 /= gtotal;
    
    float gCtrLum = gLum;
    float gCtrMsk = clmpPower(smoothstep(luminanceDetect, 1.0, gCtrLum));
    float gbloomp = 1.0 + 0.3 * sin(frameTime * 60.0);

    #ifdef BLOOM_LIGHT
    gfragfinal.rgb += gout0 * bloomIntensity * smoothcube(inverse2(gCtrMsk, gCtrLum));
    #endif

    gfragcolor0 = gfragfinal;
}