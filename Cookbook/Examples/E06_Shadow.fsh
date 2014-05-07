void main(){
	vec4 color = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Opacity of the shadow.
	float shadowOpacity = 0.5;
	
	// Offset of the shadow in texture coordinates.
	vec2 shadowOffset = vec2(-0.03, -0.03);
	float shadow = texture2D(cc_MainTexture, cc_FragTexCoord1 + shadowOffset).a;
	
	// We'll output the shadow to the color first.
	gl_FragColor = vec4(vec3(0.0), shadow*shadowOpacity);
	
	// Blending textures isn't as trivial as using the GLSL mix() function.
	// You always need to blend color and alpha separately.
	
	// Blend the pre-multiplied texture colors like this.
	gl_FragColor.rgb = color.rgb + (color.a - 1.0)*gl_FragColor.rgb;
	
	// Blend alpha values like this.
	gl_FragColor.a = mix(gl_FragColor.a, 1.0, color.a);
}