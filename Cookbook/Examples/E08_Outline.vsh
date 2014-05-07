const float PI_2 = 2.0*3.14159;

#define SAMPLES 6
varying vec2 v_OutlineSamples[SAMPLES];

uniform vec2 u_MainTextureSize;
uniform float u_OutlineWidth;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	
	vec2 outlineSize = u_OutlineWidth/u_MainTextureSize;
	for(int i=0; i<SAMPLES; i++){
		float angle = PI_2*float(i)/float(SAMPLES);
		v_OutlineSamples[i] = cc_TexCoord1 + outlineSize*vec2(cos(angle), sin(angle));
	}
}
