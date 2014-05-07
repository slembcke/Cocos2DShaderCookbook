/*
	Shaders!
	The most interesting type of shader is the fragment (pixel) shader.
	It's a tiny little program the GPU runs once for each pixel it's about to draw.
	
	The fragment shader has only one responsibility, to set the gl_FragColor variable.
	This is a variable built into OpenGL, and represents the output color of the pixel.
	
	You should be familiar with CGPoints in Cocos2D, values that store an x and y component.
	GLSL has vectors that can store 2-4 components for things like positions (x/y, x/y/z)
	and colors (r/g/b, r/g/b/a).
	
	Enough chatter. It draws all pixels as an exciting red color!
*/

// Like a C program, every shader needs at least a main funcntion.
void main(){
	// Set the output color to red.
	// You just need to set gl_FragColor to a 4 component vector for the RGBA color.
	gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}