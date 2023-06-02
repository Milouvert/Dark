shader_type canvas_item;

uniform sampler2D screen: hint_screen_texture;
uniform sampler2D distortion: repeat_enable;
uniform vec2 scroll = vec2(0.1, 0.5);
uniform float strength = 0.01;

void fragment() {
	vec2 newUV = SCREEN_UV;
	newUV = SCREEN_UV + texture(distortion, UV + TIME * scroll).xy * strength;
	vec4 col = texture(screen, newUV);
	COLOR = col;
}
