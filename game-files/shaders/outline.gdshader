shader_type canvas_item;


uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform float intensity = 1.0;
uniform vec4 modulate : source_color = vec4(1.0, 1.0, 1.0, 1.0);


void fragment() {
	vec4 pixel_color = texture(TEXTURE, vec2(UV.x, UV.y + (sin(TIME * 1.5)) * 0.005 ));
	vec4 final_color = pixel_color;
	
	vec4 left_pixel_color = texture(TEXTURE, vec2(UV.x + TEXTURE_PIXEL_SIZE.x, UV.y + (sin(TIME * 1.5)) * 0.005));
	vec4 right_pixel_color = texture(TEXTURE, vec2(UV.x - TEXTURE_PIXEL_SIZE.x, UV.y + (sin(TIME * 1.5)) * 0.005));
	vec4 top_pixel_color = texture(TEXTURE, vec2(UV.x, UV.y + TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	vec4 bottom_pixel_color = texture(TEXTURE, vec2(UV.x, UV.y - TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	
	vec4 top_right_pixel_color = texture(TEXTURE, vec2(UV.x + TEXTURE_PIXEL_SIZE.x, UV.y + TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	vec4 top_left_pixel_color = texture(TEXTURE, vec2(UV.x - TEXTURE_PIXEL_SIZE.x, UV.y + TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	vec4 bottom_right_pixel_color = texture(TEXTURE, vec2(UV.x + TEXTURE_PIXEL_SIZE.x, UV.y - TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	vec4 bottom_left_pixel_color = texture(TEXTURE, vec2(UV.x - TEXTURE_PIXEL_SIZE.x, UV.y - TEXTURE_PIXEL_SIZE.y + (sin(TIME * 1.5)) * 0.005));
	
	if (pixel_color.a == 0.0) {
		final_color = outline_color;
		final_color.a = float(
			left_pixel_color.a > 0.0 ||
			right_pixel_color.a > 0.0 ||
			top_pixel_color.a > 0.0 ||
			bottom_pixel_color.a > 0.0 ||
			top_left_pixel_color.a > 0.0 ||
			bottom_left_pixel_color.a > 0.0 ||
			bottom_right_pixel_color.a > 0.0 ||
			top_right_pixel_color.a > 0.0
		);
	}
			
	COLOR = final_color;
}
