shader_type canvas_item;

instance uniform float mask_strength : hint_range(0.0, 2.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.a != 0.0) {
		COLOR.r += mask_strength;
		COLOR.g += mask_strength;
		COLOR.b += mask_strength;
	}
	if (mask_strength > 1.0) {
		COLOR.a *= 2.0 - mask_strength;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
