#version 450

in vec3 pos;
in vec3 norm;
in vec2 uv;
in vec4 shadowPos;

uniform vec3 lightDirection;
uniform vec3 lightColour;
uniform vec3 ambientColour;
uniform sampler2D tex;
uniform sampler2D shadowMap;
uniform float shadowBias;

out vec4 fragColour;

float unpackDepth(const in vec4 rgbaDepth) {
    const vec4 bitShift = vec4(1.0, 1.0/256.0, 1.0/(256.0 * 256.0), 1.0/(256.0*256.0*256.0));
    float depth = dot(rgbaDepth, bitShift);
    return depth;
}


const vec2 poissonDisk[16] = vec2[]( 
   vec2( -0.94201624, -0.39906216 ), 
   vec2( 0.94558609, -0.76890725 ), 
   vec2( -0.094184101, -0.92938870 ), 
   vec2( 0.34495938, 0.29387760 ), 
   vec2( -0.91588581, 0.45771432 ), 
   vec2( -0.81544232, -0.87912464 ), 
   vec2( -0.38277543, 0.27676845 ), 
   vec2( 0.97484398, 0.75648379 ), 
   vec2( 0.44323325, -0.97511554 ), 
   vec2( 0.53742981, -0.47373420 ), 
   vec2( -0.26496911, -0.41893023 ), 
   vec2( 0.79197514, 0.19090188 ), 
   vec2( -0.24188840, 0.99706507 ), 
   vec2( -0.81409955, 0.91437590 ), 
   vec2( 0.19984126, 0.78641367 ), 
   vec2( 0.14383161, -0.14100790 ) 
);

float random(vec3 seed, int i){
	vec4 seed4 = vec4(seed,i);
	float dot_product = dot(seed4, vec4(12.9898,78.233,45.164,94.673));
	return fract(sin(dot_product) * 43758.5453);
}

void main() {
    vec3 shadowCoord = (shadowPos.xyz/shadowPos.w)/2.0 + 0.5;
    const float texelSize = 1.0 / 2048.0;
    float visibility = 1.0;
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 0))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 1))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 2))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 3))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 4))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 5))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 6))%16]* texelSize)) + shadowBias, shadowCoord.z);
    visibility -= 0.0625 * step(unpackDepth(texture(shadowMap, shadowCoord.xy + poissonDisk[int(16.0*random(floor(pos.xyz * 1000.0), 7))%16]* texelSize)) + shadowBias, shadowCoord.z);

	float dLight0 = clamp(dot(norm, lightDirection), 0.0, 1.0) * 0.5 + 0.5;
    vec3 light = lightColour * dLight0 * visibility + ambientColour;
    
    fragColour = vec4(texture(tex, uv).rgb * light, 1.0);
}
