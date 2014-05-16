const int SAMPLES = 6;
varying vec2 v_OutlineSamples[SAMPLES];

vec4 composite(vec4 over, vec4 under){
	return over + (1.0 - over.a)*under;
}

void main(){
	// Use the coordinates from the v_OutlineSamples[] array.
	float outlineAlpha = 0.0;
	for(int i=0; i<SAMPLES; i++){
		float alpha = texture2D(cc_MainTexture, v_OutlineSamples[i]).a;
		
		// Blend the alpha with our other samples.
		outlineAlpha = outlineAlpha + (1.0 - outlineAlpha)*alpha;
	}
	
	// Let's repurpose cc_FragColor for the outline color.
		vec4 outlineColor = cc_FragColor*outlineAlpha;
	vec4 textureColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
	gl_FragColor = composite(textureColor, outlineColor);
}
