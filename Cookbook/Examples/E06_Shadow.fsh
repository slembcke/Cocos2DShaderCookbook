// Blend one premultiplied color over another.
// The result is another properly premultiplied color.
vec4 pmCombine(vec4 over, vec4 under){
	// Blend the colors using the premultiplied alpha equation.
	vec3 color = over.rgb + (1.0 - over.a)*under.rgb;
	
	// You don't want to blend the alpha. The alpha should stack so that gets darker.
	float alpha = over.a + under.a - over.a*under.a;
	
	return vec4(color, alpha);
}

void main(){
	vec4 textureColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Offset of the shadow in texture coordinates.
	vec2 shadowOffset = vec2(-0.03, -0.03);
	float shadow = texture2D(cc_MainTexture, cc_FragTexCoord1 + shadowOffset).a;
	
	const float shadowOpacity = 0.5;
	// This is the premultiplied shadow color.
	vec4 shadowColor = vec4(vec3(0.0), shadow*shadowOpacity);
	
	// Combine the sprite's texture over the shadow.
	gl_FragColor = pmCombine(textureColor, shadowColor);
}
