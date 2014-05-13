uniform sampler2D u_NoiseTexture;
uniform sampler2D u_CausticTexture;

void main(){
	vec2 distortion = 2.0*texture2D(u_NoiseTexture, cc_FragTexCoord2).xy - 1.0;
	vec2 distortionOffset = distortion*0.05;
	
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1 + distortionOffset);
	gl_FragColor += 0.5*texture2D(u_CausticTexture, cc_FragTexCoord1 - distortionOffset);
}
