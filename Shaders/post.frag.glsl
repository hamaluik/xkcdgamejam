#version 450

uniform vec2 resolution;
uniform sampler2D tex;

out vec4 fragColour;

const float vignetteRadius = 0.75;
const float vignetteSoftness = 0.45;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    vec3 screen = texture(tex, uv).rgb;

    // vignette
	vec2 position = (uv) - vec2(0.5, 0.5);
	float len = length(position);
    float vignette = smoothstep(vignetteRadius, vignetteRadius - vignetteSoftness, len);
    screen = mix(screen, screen * vignette, 0.5);

    fragColour = vec4(screen, 1.0);
}
