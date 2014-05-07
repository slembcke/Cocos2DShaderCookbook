uniform mat4 u_ColorMatrix;

void main(){
	// Multiply the color we sample out of the main texture by the colorMatrix.
	gl_FragColor = texture2D(cc_MainTexture, cc_FragTexCoord1) * u_ColorMatrix;
}
