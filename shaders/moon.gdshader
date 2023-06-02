shader_type spatial;
render_mode unshaded;

uniform vec4 color: source_color = vec4(1,1,1,1);

void vertex() {
	VERTEX += vec3(sin(TIME + VERTEX.x), sin(TIME * 2. + VERTEX.y), sin(TIME * 3. + VERTEX.z)) * 0.05;
	COLOR = color;
}

void fragment() {
	ALBEDO = COLOR.xyz;
}