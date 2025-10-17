#version 330 compatibility

out vec2 gfragtexcoord;

void main()
{
    gfragtexcoord = vec2(gl_TextureMatrix[0] * gl_MultiTexCoord0);
    gl_Position = ftransform();
}