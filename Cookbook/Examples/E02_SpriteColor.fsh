/*
	Making a red square is neat, but graphics are better.
	We need to ask OpenGL for pixels from a texture and set the color to that.
	OpenGL doesn't let you read texture pixels directly.
	Instead you use the texture2D() GLSL function to "sample" a texture.
	By default, texture sampling in Cocos2D uses "linear filtering".
	This means that if you sample between two pixels, you will get a color between them.
	
	Next thing to know is that OpenGL texture coordinates are not it pixels.
	Instead texture coordinates are normalized between 0 and 1.
	(0, 0) is the upper left corner of the texture and (1, 1) is the lower right.
	
	So how do you tell OpenGL which texture to sample from and which spot?
	How do you know what color the sprite should be tinted as?
	Fortunately Cocos2D has built in variables to make this easy.
	cc_FragColor is the pre-multiplied** color set on the sprite.
	cc_MainTexture is the main texture for a sprite, particle, etc.
	cc_FragTexCoord1 is the coordinate you should read from.
	The basic sprite shader becomes quite simple then.
	
	** I'll explain pre-multiplied colors later.
*/

void main(){
	// First we'll read the texture's pixel color.
	// GLSL's texture function takes a texture and texture coordinate as parameters.
	vec4 textureColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Now we just need to mix the texture color with the sprite's color.
	// To tint the sprite, we just need to multiply the two colors together.
	gl_FragColor = cc_FragColor*textureColor;
	
	// This is the default shader in Cocos2D and does most of the drawing.
}
