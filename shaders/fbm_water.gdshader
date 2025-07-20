shader_type spatial;

uniform float amplitude = .5;
uniform float frequency = 1.;
uniform float speed = .5;

void vertex() {
	float sine1 = amplitude * sin(VERTEX.x * VERTEX.z * frequency + TIME * speed);
	//float sine2 = amplitude * .5 * sin(VERTEX.x * VERTEX.z * frequency * 2.3 + TIME * speed * 3.);
	VERTEX.y += sine1;

}

//void fragment() {
	//// Called for every pixel the material is visible on.
//}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
