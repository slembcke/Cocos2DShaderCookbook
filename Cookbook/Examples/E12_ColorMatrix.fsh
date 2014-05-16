uniform mat4 u_ColorMatrix;

void main(){
	gl_FragColor = u_ColorMatrix*texture2D(cc_MainTexture, cc_FragTexCoord1);
}
