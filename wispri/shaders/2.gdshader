shader_type spatial;
//render_mode wireframe;

uniform vec3 color: source_color;

uniform float amplitude = .5;
uniform float frequency = 1.;
uniform float speed = 1.;
uniform float amplitude_multiplier = .5;
uniform float frequency_multiplier = 1.5;
uniform int wave_count : hint_range(0, 32) = 10;

float random(float x) {
    return fract(sin(x * 13.9898) * 43758.5453123);
}

vec2 get_random_wave_direction(int index) {
    float angle = random(float(index + 1)) * TAU; // random gives [0, 1)
    return vec2(cos(angle), sin(angle));
}

float sine_stack(vec3 position) {
	float result = 0.0;
	float current_amplitude = amplitude;
	float current_frequency  = frequency;

	for (int i = 0; i < wave_count; i++){
		vec2 random_direction = get_random_wave_direction(i);
		// vec2 previous_wave_direction = get_random_wave_direction(i - 1);
    	result += current_amplitude * sin(dot(random_direction, position.xz)
			* current_frequency + TIME * speed);
    	current_amplitude *= amplitude_multiplier;
    	current_frequency *= frequency_multiplier;
  	}

  	return result;
}

void vertex() {
	VERTEX.y += sine_stack(VERTEX);
}

void fragment() {
	ALBEDO = color;
	//ROUGHNESS = .05;
	//METALLIC = 0.0;
	//SPECULAR = .255;
}
