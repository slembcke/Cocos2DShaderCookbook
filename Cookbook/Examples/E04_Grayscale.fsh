void main(){
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	float gray = (gl_FragColor.r + gl_FragColor.g + gl_FragColor.b)/3.0;
	gl_FragColor.rgb = vec3(gray);
}
