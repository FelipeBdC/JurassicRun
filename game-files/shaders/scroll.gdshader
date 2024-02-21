shader_type canvas_item;

uniform bool scroll = true;
uniform float speed = 0.5;
uniform float scroll_amount = 0.0;

void fragment() {
	if (scroll) {
		vec4 displaced_color = texture(TEXTURE, vec2(UV.x + scroll_amount * speed, UV.y));
		COLOR = displaced_color;
	}
}
