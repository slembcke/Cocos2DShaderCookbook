void main(){
	// Another builtin Cocos2D shader value is cc_Time.
	// It's a vec4 that holds [time, time/2, time/4, time/8]
	float time = cc_Time[0];
	
	// Make a copy of the texture coordinate.
	vec2 texCoord = cc_FragTexCoord1;
	
	// Add some sine wave distortion to the x-coordinate based on the y-coordinate.
	// Add time to it to make it animate.
	texCoord.x += 0.1*sin(10.0*texCoord.y + time);
	
	// Sample the texture's color and tint it by the sprite's color.
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, texCoord);
	
	// Notice that there are two ways to access a vector.
	// Like an array or like a struct. texCoord[0] and texCoord.x.
	// GLSL uses vectors for both positions (x/y/z/w) and colors (r/g/b/a).
	// You can use whatever makes most sense.
}