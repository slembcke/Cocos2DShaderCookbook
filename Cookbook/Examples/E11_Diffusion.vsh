uniform vec2 u_NoiseTextureSize;

uniform float u_AnimationEnabled;
uniform float u_BlockSize;

void main(){
	gl_Position = cc_Position;
	cc_FragColor = clamp(cc_Color, 0.0, 1.0);
	cc_FragTexCoord1 = cc_TexCoord1;
	
	// We do as much work as possible in the vertex shader, and pass the results to the fragment shader.
	// First calculate the vertex position relative to the screen.
	vec2 ssuv = (0.5*gl_Position.xy/gl_Position.w + 0.5);
	// Then convert that to the texture while saving a 1:1 screen to texture pixel ratio.
	vec2 uv = ssuv*cc_ViewSizeInPixels/u_NoiseTextureSize;
	// Apply a random offset, if animation is enabled.
	vec2 randomAnimatedOffset = cc_Random01.xy*u_AnimationEnabled;
	cc_FragTexCoord2 = (uv + randomAnimatedOffset)/u_BlockSize;
}
