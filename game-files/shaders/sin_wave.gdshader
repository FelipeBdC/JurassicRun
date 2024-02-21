shader_type canvas_item;


uniform float intensity = 1.0;
uniform vec4 modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0);


void fragment() {
	vec4 displaced_color = texture(TEXTURE, vec2( UV.x, UV.y + sin(TIME * 2.0) * 0.1 ));
	
	COLOR = displaced_color * modulate;
}