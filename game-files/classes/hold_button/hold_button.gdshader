shader_type canvas_item;

uniform float percentage = 0.0;
uniform vec4 highlight_color : source_color;


void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	vec4 final_color = pixel_color;
	
	if (UV.x < percentage && pixel_color.a > 0.0) {
		
		if (pixel_color.rgb != vec3(1.0, 1.0, 1.0)) {
			final_color = highlight_color;
		}
		
	}
	
	COLOR = final_color;
}
