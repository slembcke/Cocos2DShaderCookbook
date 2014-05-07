#define SAMPLES 6
varying vec2 v_OutlineSamples[SAMPLES];

void main(){
	vec4 tex = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	float mask = tex.a;
	for(int i=0; i<SAMPLES; i++){
		mask = max(mask, texture2D(cc_MainTexture, v_OutlineSamples[i]).a);
	}
	
	vec4 outline = cc_FragColor*mask;
	gl_FragColor.rgb = tex.rgb + (1.0 - tex.a)*outline.rgb;
	gl_FragColor.a = tex.a + outline.a - tex.a*outline.a;
}
