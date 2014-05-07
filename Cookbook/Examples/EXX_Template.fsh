void main(){
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1);
}
