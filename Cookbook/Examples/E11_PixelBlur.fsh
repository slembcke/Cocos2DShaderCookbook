
uniform float u_DistortionSize;

uniform sampler2D u_DistortionTexture;

varying vec2 v_distortionCoords;

void main(){

	// v_distortionCoords was calculated in the vertex shader, so we just need to do the texture lookups here.
	vec2 distortionOffset = texture2D(u_DistortionTexture, v_distortionCoords).rg;
	// Look up the main texture, now that we've sampled the distortion texture. Offset the
	// distortion by -0.5 so the content remains centered.
	vec4 c = texture2D(cc_MainTexture, cc_FragTexCoord1 + (distortionOffset - 0.5) * (u_DistortionSize));
	
	gl_FragColor = vec4(c.rgb, 1);
}
