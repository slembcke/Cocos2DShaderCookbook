void main(){
	// Start off with the basic tinted sprite shader.
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// To make it grayscale, let's average the red, green and blue together.
	// ("Proper" grayscale is not a simple average, but it's not that important.)
	float gray = (gl_FragColor.r + gl_FragColor.g + gl_FragColor.b)/3.0;
	
	// Now for some fancy GLSL vector usage.
	// We could set the components individualy to the value of gray,
	// but there is a better way. First make a vec3 filled with 3 copies of 'gray'.
	// Then set the r/g/b values of gl_FragColor using that vector.
	gl_FragColor.rgb = vec3(gray);
}
