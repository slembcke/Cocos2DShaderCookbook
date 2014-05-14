void main(){
	vec2 texCoord = cc_FragTexCoord1;
	
	float time = cc_Time[0];
	texCoord.x += 0.1*sin(10.0*texCoord.y + time);
	
	gl_FragColor = cc_FragColor*texture2D(cc_MainTexture, texCoord);
}
