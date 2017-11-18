#version 450

in vec3 norm;
in vec2 uv;

uniform vec3 lightDirection;
uniform vec3 lightColour;
uniform vec3 ambientColour;
uniform sampler2D tex;

out vec4 fragColour;

void main() {
	float dLight0 = clamp(dot(norm, lightDirection), 0.0, 1.0);
    vec3 light = lightColour * dLight0 + ambientColour;
    fragColour = vec4(texture(tex, uv).rgb * light, 1.0);
}
