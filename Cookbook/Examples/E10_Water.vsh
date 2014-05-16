uniform vec2 u_NoiseTextureSize;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	cc_FragTexCoord2 = cc_TexCoord2;
	
	vec2 distortionScroll = vec2(cc_Time[0], 0.0);
	vec2 screen01 = (0.5*gl_Position.xy/gl_Position.w + 0.5);
	cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTextureSize + distortionScroll;
}
