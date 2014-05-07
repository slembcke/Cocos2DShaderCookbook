
uniform vec2 u_mainTextureSize;
uniform float u_AnimationEnabled;
uniform float u_BlockSize;

varying vec2 v_distortionCoords;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	cc_FragTexCoord2 = cc_TexCoord2;

	// We do as much work as possible in the vertex shader, and pass the results to the fragment shader.
	// Here we calculate a properly scaled UV coordinates...
	vec2 scaleDistortion = u_mainTextureSize / max(u_mainTextureSize.x, u_mainTextureSize.y);
	// Apply a random offset, if animation is enabled.
	vec2 randomAnimatedOffset = cc_Random01.xy * u_AnimationEnabled;
	// pass our UV coordinates to the fragment shader for the texture lookups. BlockSize allows us to "zoom in" on the
	// distortion texture, so the distortion blocks are like giant pixels.
	v_distortionCoords = (cc_FragTexCoord1 + randomAnimatedOffset) * u_BlockSize * scaleDistortion;
	
	
}