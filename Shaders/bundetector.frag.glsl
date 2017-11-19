#version 450

uniform vec4 bunFactor;
out vec4 fragColour;

void main() {
    fragColour = bunFactor;
}
