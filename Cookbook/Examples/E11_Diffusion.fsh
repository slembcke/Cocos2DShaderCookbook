uniform float u_Radius;
uniform vec2 u_MainTextureSize;
uniform sampler2D u_NoiseTexture;

void main(){
	vec2 noise = 2.0*texture2D(u_NoiseTexture, cc_FragTexCoord2).xy - 1.0;
	vec2 distortionOffset = u_Radius*noise/u_MainTextureSize;
	
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1 + distortionOffset);
}
