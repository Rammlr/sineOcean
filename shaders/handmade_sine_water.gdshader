shader_type spatial;
//render_mode wireframe;


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
    float angle = random(float(index + 1)) * TAU; // hash1 gives [0, 1)
    return vec2(cos(angle), sin(angle));
}

float sine_fbm(vec3 position) {
	float result = 0.0;
	float current_amplitude = amplitude;
	float current_frequency  = frequency;

  for (int i = 0; i < wave_count; i++){
	vec2 random_direction = get_random_wave_direction(i);
	// TODO: domain warp
	// this works out well because the random direction for
	// index 0 is (0, 0)
	vec2 previous_wave_direction = get_random_wave_direction(i - 1);
	//previous_wave_direction = vec2(0., 0.);
    result += current_amplitude * sin(dot(random_direction, position.xz + previous_wave_direction)
		* current_frequency + TIME * speed);
    current_amplitude *= amplitude_multiplier;
    current_frequency *= frequency_multiplier;
  }

  return result;
}

vec3 sine_fbm_normal(vec3 position) {
	vec3 result = vec3(0., 1., 0.);
	float current_amplitude = amplitude;
	float current_frequency  = frequency;

  for (int i = 0; i < wave_count; i++){
	vec2 random_direction = get_random_wave_direction(i);
    result.x -= current_amplitude * random_direction.x * current_frequency
		* cos(dot(random_direction, position.xz) * current_frequency + TIME * speed);
	result.z -= current_amplitude * random_direction.y * current_frequency
		* cos(dot(random_direction, position.xz) * current_frequency + TIME * speed);
    current_amplitude *= amplitude_multiplier;
    current_frequency *= frequency_multiplier;
  }

  return normalize(result);
}

void vertex() {
	VERTEX.y += sine_fbm(VERTEX);
	NORMAL = sine_fbm_normal(VERTEX);
}

void fragment() {
	//ALBEDO = vec3(90,188,216) / 255.;
	ALBEDO = vec3(0.0, 0.18, 0.3);
	ROUGHNESS = .05;
	METALLIC = 0.0;
	SPECULAR = .255;
}

//void light() {
	//// Called for every pixel for every light affecting the material.
	//// Uncomment to replace the default light processing function with this one.
//}
