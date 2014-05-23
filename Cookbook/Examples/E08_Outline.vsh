uniform vec2 cc_MainTextureSize;
uniform float u_OutlineWidth;

const int SAMPLES = 6;
varying vec2 v_OutlineSamples[SAMPLES];

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	
	vec2 outlineSize = u_OutlineWidth/cc_MainTextureSize;
	for(int i=0; i<SAMPLES; i++){
		float angle = 2.0*3.14159*float(i)/float(SAMPLES);
		v_OutlineSamples[i] = cc_TexCoord1 + outlineSize*vec2(cos(angle), sin(angle));
	}
}
