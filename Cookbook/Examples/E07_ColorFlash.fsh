// This is a GLSL uniform variable.
// It's value is set in Cocos2D using the CCSprite.shaderUniforms dictionary.
// See E07_ColorFlash.m for the code.
uniform vec4 u_ColorFlash;

void main(){
	vec4 color = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Mix the flash color over the texture RGB color using the flash color's alpha.
	// mix() is a GLSL builtin function that performs linear interpolation.
	color.rgb = mix(color.rgb, u_ColorFlash.rgb, u_ColorFlash.a);
	
	// Now tint the final color.
	gl_FragColor = cc_FragColor*color;
}
