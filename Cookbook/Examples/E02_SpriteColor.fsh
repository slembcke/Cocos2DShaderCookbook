void main(){
	// Read the sprite's texture's color for the current pixel.
	vec4 textureColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Tint the texture color by the sprite's color.
	gl_FragColor = cc_FragColor*textureColor;
}
