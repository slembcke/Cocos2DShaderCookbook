void main(){
	float t = cc_Time[0];
	vec2 uv = cc_FragTexCoord1;
	float wave = 0.01;
	
	// Sample the same texture several times at different locations.
	vec4 r = texture2D(cc_MainTexture, uv + vec2(wave*sin(1.0*t + uv.y*5.0), 0.0));
	vec4 g = texture2D(cc_MainTexture, uv + vec2(wave*sin(1.3*t + uv.y*5.0), 0.0));
	vec4 b = texture2D(cc_MainTexture, uv + vec2(wave*sin(1.6*t + uv.y*5.0), 0.0));
	
	// Then combine them.
	// Average the alpha value.
	gl_FragColor = vec4(r.r, g.g, b.b, (r.a + b.a + g.a)/3.0);
}