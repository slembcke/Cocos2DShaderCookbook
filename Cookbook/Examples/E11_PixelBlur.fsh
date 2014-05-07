
uniform float u_DistortionSize;

uniform sampler2D u_DistortionTexture;

varying vec2 v_distortionCoords;

void main(){

	vec2 distortionOffset = texture2D(u_DistortionTexture, v_distortionCoords).rg;

	vec4 c = texture2D(cc_MainTexture, cc_FragTexCoord1 + (distortionOffset - 0.5) * (u_DistortionSize));
	
	gl_FragColor = vec4(c.rgb, 1);
}