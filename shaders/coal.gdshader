shader_type spatial;

uniform sampler2D noise;
uniform vec3 glow: source_color = vec3(1, 0.25, 0.0);
uniform vec3 dark: source_color = vec3(0.0, 0.0, 0.0);

void fragment() {
	
	float noise_val = texture(noise, vec2(TIME * 0.05)).x;
	ALBEDO = mix(glow, dark, noise_val);
	EMISSION = ALBEDO;
}
