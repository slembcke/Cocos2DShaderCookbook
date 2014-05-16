uniform float u_BlurRadius;
uniform vec2 u_MainTextureSize;
uniform sampler2D u_NoiseTexture;

void main(){
	// v_distortionCoords was calculated in the vertex shader, so we just need to do the texture lookups here.
	vec2 noise = texture2D(u_NoiseTexture, cc_FragTexCoord2).xy;
	vec2 distortionOffset = u_BlurRadius*(2.0*noise - 1.0)/u_MainTextureSize;
	
	// Look up the main texture, now that we've sampled the distortion texture.
	// Use the distortion offset to change the texture coordinate to sample.
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1 + distortionOffset);
}
