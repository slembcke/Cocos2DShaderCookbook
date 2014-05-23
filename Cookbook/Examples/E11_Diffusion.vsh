uniform vec2 u_NoiseTexturePixelSize;

uniform float u_AnimationEnabled;
uniform float u_BlockSize;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	
	vec2 screen01 = (0.5*gl_Position.xy/gl_Position.w + 0.5);
	cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTexturePixelSize;
	
	vec2 randomAnimatedOffset = cc_Random01.xy*u_AnimationEnabled;
	cc_FragTexCoord2 = (cc_FragTexCoord2 + randomAnimatedOffset)/u_BlockSize;
}
