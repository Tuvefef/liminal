#ifndef GLCOMMONS_INC
#define GLCOMMONS_INC 2

/* macros and constants */

const vec2 vec2Center = vec2(0.5, 0.5);

const vec2 cvecr = vec2(0.009);
const vec2 cvecg = vec2(0.006);
const vec2 cvecb = vec2(-0.006);

const vec3 cbluetint = vec3(0.993, 1.0, 1.07);
const vec3 cgreentint = vec3(0.993, 1.02, 1.0);

const vec3 cvecluma0 = vec3(0.299, 0.587, 0.114);
const vec3 cvecluma1 = vec3(0.2126, 0.7152, 0.0722);

#define luma(vec) dot(vec, cvecluma0)
#define centervec(x) (x - vec2Center)
#define qtzn0(x, q) (floor(x * q + 0.5) / q)

#define powx2(x) (x * x)
#define powx3(x) (powx2(x) * x)
#define powx4(x) (powx3(x) * x)

#define max0(x) max(x, 0.0)
#define maxx3(x, y, z) max(max(x, y), z)
#define min0(x) min(x, 0.0)
#define minx3(x, y, z) min(min(x, y), z)

#define inverse(x) (1.0 - x)
#define inverse2(x, y) (1.0 - max(x, y))
#define inverse3(x, y, z) (1.0 - maxx3(x, y, z))

#define smoothcube(x) (powx2(x) * (3.0 - 2.0 * x))

#define mag2(vec) dot(vec, vec)
#define mag0(vec) sqrt(mag2(vec))

float correctCenter(vec2 x){ return smoothcube(inverse(mag0(x))); }

mat2 rotate2D(float m)
{
    return mat2(
        cos(m), -sin(m), sin(m), cos(m)
    );
}

float clmpPower(float x)
{
    return powx2(clamp(abs(x), 1e-6, 1e6));
}

float bandify(float f, float s)
{
    return floor(f * s) / s;
}

#endif