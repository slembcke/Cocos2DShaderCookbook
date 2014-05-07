uniform sampler2D u_NoiseTexture;

uniform float u_NoiseAmount;

void main(){
	vec4 texture = texture2D(cc_MainTexture, cc_FragTexCoord1);
	vec4 noise = texture2D(u_NoiseTexture, cc_FragTexCoord2);
	
	gl_FragColor = cc_FragColor*texture;
	gl_FragColor.rgb += u_NoiseAmount*(2.0*noise.rgb - 1.0);
}
