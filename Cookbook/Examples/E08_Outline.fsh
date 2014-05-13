vec4 pmCombine(vec4 over, vec4 under){
	return vec4(over.rgb + (1.0 - over.a)*under.rgb, over.a + under.a - over.a*under.a);
}

#define SAMPLES 6
varying vec2 v_OutlineSamples[SAMPLES];

void main(){
	// Start with the sprite's texture color.
	gl_FragColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	for(int i=0; i<SAMPLES; i++){
		float alpha = texture2D(cc_MainTexture, v_OutlineSamples[i]).a;
		
		// Let's repurpose cc_FragColor for the outline color.
		// You might choose to do this since setting unique uniforms per sprite prevents batching.
		vec4 outlineColor = cc_FragColor*alpha;
		
		// Now blend the outline underneath the current color.
		gl_FragColor = pmCombine(gl_FragColor, outlineColor);
	}
}
