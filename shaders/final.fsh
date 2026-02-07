#version 330 compatibility

in vec2 gfragtexcoord;
uniform sampler2D colortex0;

layout(location = 0) out vec4 gfragcolor0;

#include "program/preset.h"

vec2 lowres(vec2 c, vec2 f)
{
    return floor(c * f) / f;
}

void main()
{
    vec2 texel = 1.0 / vec2(1280.0, 720.0);
    vec2 texel2 = vec2(640.0, 360.0);

    vec4 color = vec4(0.0);

    vec2 uv = gfragtexcoord;

    color += texture(colortex0, uv + texel * vec2(-1, -1));
    color += texture(colortex0, uv + texel * vec2( 0, -1));
    color += texture(colortex0, uv + texel * vec2( 1, -1));
    color += texture(colortex0, uv + texel * vec2(-1,  0));
    color += texture(colortex0, lowres(uv, texel2));
    color += texture(colortex0, uv + texel * vec2( 1,  0));
    color += texture(colortex0, uv + texel * vec2(-1,  1));
    color += texture(colortex0, uv + texel * vec2( 0,  1));
    color += texture(colortex0, uv + texel * vec2( 1,  1));

    #ifdef LOW_RES
        gfragcolor0 = color / 9.0;
    #else 
        gfragcolor0 = texture2D(colortex0, gfragtexcoord);
    #endif
}