#version 450

in vec3 norm;
in vec2 uv;

uniform vec3 lightDirection;
uniform sampler2D tex;

out vec4 fragColour;

void main() {
	float dLight0 = clamp(dot(norm, lightDirection), 0.0, 1.0);
    fragColour = vec4(texture(tex, uv).rgb * dLight0, 1.0);
}
