#version 450

in vec3 position;
in vec3 normal;
in vec2 texcoord;

uniform mat4 MVP;
uniform mat4 M;
uniform mat4 shadowMVP;

out vec3 pos;
out vec3 norm;
out vec2 uv;
out vec4 shadowPos;

void main() {
    pos = (M * vec4(position, 1.0)).xyz;
    norm = (M * vec4(normal, 0.0)).xyz;
    uv = texcoord;
    shadowPos = shadowMVP * vec4(position, 1.0);
    gl_Position = MVP * vec4(position, 1.0);
}
