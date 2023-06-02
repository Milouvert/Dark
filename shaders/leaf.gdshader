shader_type spatial;

uniform sampler2D wind_noise;
uniform float wind_force = 0.5;
uniform float time_mult = 0.02;
uniform vec3 leaf_color: source_color = vec3(0.15, 0.35, 0.15);

void vertex() {
	vec2 wind_coord = VERTEX.xy + vec2(TIME * time_mult);
	float wind = texture(wind_noise, wind_coord).x;
	VERTEX.xz += wind * wind_force;
	COLOR = vec4(leaf_color, 1.0);
}

void fragment() {
	ALBEDO = COLOR.xyz;
	ROUGHNESS = 0.9;
	SPECULAR = 0.5;
	
}
