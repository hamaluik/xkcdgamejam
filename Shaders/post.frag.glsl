#version 450

uniform vec2 resolution;
uniform vec4 params; // flash, desaturation, ?, ?
uniform sampler2D tex;

out vec4 fragColour;

const float vignetteRadius = 0.75;
const float vignetteSoftness = 0.45;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    vec3 screen = texture(tex, uv).rgb;

    // desaturate
    screen = mix(screen, vec3(dot(screen, vec3(0.2125, 0.7154, 0.0721))), vec3(params.y, params.y, params.y));

    // vignette
	vec2 position = (uv) - vec2(0.5, 0.5);
	float len = length(position);
    float vignette = smoothstep(vignetteRadius, vignetteRadius - vignetteSoftness, len);
    screen = mix(screen, screen * vignette, 0.5);

    // flash
    screen = mix(screen, vec3(1.0, 1.0, 1.0), params.x);

    fragColour = vec4(screen, 1.0);
}
