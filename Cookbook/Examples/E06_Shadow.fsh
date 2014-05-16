vec4 composite(vec4 over, vec4 under){
	return over + (1.0 - over.a)*under;
}

void main(){
	vec4 textureColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Offset of the shadow in texture coordinates.
	vec2 shadowOffset = vec2(-0.03, -0.03);
	float shadowMask = texture2D(cc_MainTexture, cc_FragTexCoord1 + shadowOffset).a;
	
	const float shadowOpacity = 0.5;
	vec4 shadowColor = vec4(vec3(0.0), shadowMask*shadowOpacity);
	
	gl_FragColor = composite(textureColor, shadowColor);
}
