#ifdef GL_ES
#extension GL_OES_standard_derivatives : enable
#endif

// Premultiplied color that takes the place of red, green and blue from the SDF texture.
const vec4 colorR = vec4(vec3(0.5), 1.0)*0.5;
const vec4 colorG = vec4(0.6, 0.0, 0.9, 1.0);
const vec4 colorB = vec4(0.0, 0.0, 0.0, 1.0);

vec4 pmCombine(vec4 over, vec4 under){
	return vec4(over.rgb + (1.0 - over.a)*under.rgb, over.a + under.a - over.a*under.a);
}

void main(){
	vec4 distanceField = 2.0*texture2D(cc_MainTexture, cc_FragTexCoord1) - 1.0;
	vec4 fw = fwidth(distanceField);
	vec4 mask = smoothstep(-fw, fw, distanceField);
	
	// Combine all the layers.
	gl_FragColor = colorR*mask.r;
	gl_FragColor = pmCombine(colorG*mask.g, gl_FragColor);
	
	// Fun with distance fields.
	// Lets use it to add soft shadow with an offset under the blue channel layer.
	float shadow = 2.0*texture2D(cc_MainTexture, cc_FragTexCoord1 - vec2(0.02, 0.02)).b;
	vec4 shadowColor = vec4(vec3(0), 0.5);
	gl_FragColor = pmCombine(shadowColor*shadow, gl_FragColor);
	
	// Let's use it to add a little green glow too.
	gl_FragColor.rgb += vec3(0, 1, 0)*(distanceField.b*8.0 + 1.0);
	
	gl_FragColor = pmCombine(colorB*mask.b, gl_FragColor);
}
