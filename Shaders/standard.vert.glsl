#version 450

in vec3 position;
in vec3 normal;
in vec2 texcoord;

uniform mat4 MVP;
uniform mat4 N;

out vec3 norm;
out vec2 uv;

void main() {
    norm = normalize((N * vec4(normal, 0.0)).xyz);
    uv = texcoord;
    gl_Position = MVP * vec4(position, 1.0);
}
