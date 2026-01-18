shader_type spatial;
//render_mode wireframe, cull_disabled;

uniform vec3 color: source_color;

void vertex() {
	VERTEX = VERTEX;
}

void fragment() {
	ALBEDO = color;
}

//void light() {
	//// Called for every pixel for every light affecting the material.
	//// Uncomment to replace the default light processing function with this one.
//}
