
uniform vec2 u_mainTextureSize;
uniform float u_AnimationEnabled;
uniform float u_BlockSize;

varying vec2 v_distortionCoords;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	cc_FragTexCoord2 = cc_TexCoord2;
	
	vec2 scaleDistortion = u_mainTextureSize / max(u_mainTextureSize.x, u_mainTextureSize.y);
	vec2 randomAnimatedOffset = cc_Random01.xy * u_AnimationEnabled;
	v_distortionCoords = (cc_FragTexCoord1 + randomAnimatedOffset) * u_BlockSize * scaleDistortion;
	
	
}