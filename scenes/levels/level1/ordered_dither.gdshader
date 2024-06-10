shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform float colorDivisions : hint_range(1, 8, 1);

const float BAYER_MATRIX[64] = {
	-32.0/64.0, 0.0/64.0, -24.0/64.0, 8.0/64.0, -30.0/64.0, 2.0/64.0, -22.0/64.0, 10.0/64.0,
	16.0/64.0, -16.0/64.0, 24.0/64.0, -8.0/64.0, 18.0/64.0, -14.0/64.0, 26.0/64.0, -6.0/64.0,
	-20.0/64.0, 12.0/64.0, -28.0/64.0, 4.0/64.0, -18.0/64.0, 14.0/64.0, -26.0/64.0, 6.0/64.0,
	28.0/64.0, -4.0/64.0, 20.0/64.0, -12.0/64.0, 30.0/64.0, -2.0/64.0, 22.0/64.0, -10.0/64.0,
	-29.0/64.0, 3.0/64.0, -21.0/64.0, 11.0/64.0, -31.0/64.0, 1.0/64.0, -23.0/64.0, 9.0/64.0,
	19.0/64.0, -13.0/64.0, 27.0/64.0, -5.0/64.0, 17.0/64.0, -15.0/64.0, 25.0/64.0, -7.0/64.0,
	-17.0/64.0, 15.0/64.0, -25.0/64.0, 7.0/64.0, -19.0/64.0, 13.0/64.0, -27.0/64.0, 5.0/64.0,
	31.0/64.0, -1.0/64.0, 23.0/64.0, -9.0/64.0, 29.0/64.0, -3.0/64.0, 21.0/64.0, -11.0/64.0
};

//const mat4 bayerIndex = mat4(
    //vec4(-0.8/16.0, 4.0/16.0, -5.0/16.0, 07.0/16.0),
    //vec4(00.0/16.0, -4.0/16.0, 03.0/16.0, -1.0/16.0),
    //vec4(-6.0/16.0, 06.0/16.0, -7.0/16.0, 05.0/16.0),
    //vec4(02.0/16.0, -2.0/16.0, 01.0/16.0, -3.0/16.0));
	
const vec2 ditheringSizeVec2 = vec2(8, 8);

vec3 quantize(vec3 color, float bits) {
	float modVal = 1./bits;
	vec3 retVal = color.rgb;
	retVal.r = color.r + modVal - mod(color.r, modVal);
	retVal.g = color.g + modVal - mod(color.g, modVal);
	retVal.b = color.b + modVal - mod(color.b, modVal);
	return retVal;
}

void fragment() {
	vec4 screenColor = COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 xy = SCREEN_UV / SCREEN_PIXEL_SIZE;

	vec2 bayerModulo = mod(xy, ditheringSizeVec2);
	float offset = BAYER_MATRIX[int(bayerModulo.x) + (int(bayerModulo.y) * 8)];
	
	float adjustedOffset = offset / colorDivisions;
	vec3 offsetScreenColor = screenColor.rgb + vec3(adjustedOffset, adjustedOffset, adjustedOffset);
	
	COLOR.rgb = quantize(offsetScreenColor, colorDivisions);
}
