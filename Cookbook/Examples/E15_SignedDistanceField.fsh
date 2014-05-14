#ifdef GL_ES
#extension GL_OES_standard_derivatives : enable
#endif

// Premultiplied color that takes the place of red, green and blue from the SDF texture.
const vec4 colorR = vec4(0.92, 0.39, 0.00, 1);
const vec4 colorG = vec4(0.98, 1.00, 0.00, 1);
const vec4 colorB = vec4(0.00, 0.00, 0.00, 1);

const vec4 outlineColor = vec4(0.60, 0.26, 0.00, 1);
const vec4 shadowColor = vec4(0, 0, 0, 0.25);

vec4 distance2D(vec2 texCoord){
	return 2.0*texture2D(cc_MainTexture, texCoord) - 1.0;
}

vec4 pmCombine(vec4 over, vec4 under){
	return vec4(over.rgb + (1.0 - over.a)*under.rgb, over.a + under.a - over.a*under.a);
}

void main(){
	vec4 distanceField = distance2D(cc_FragTexCoord1);
	vec4 fw = fwidth(distanceField);
	vec4 mask = smoothstep(-fw, fw, distanceField);
	
	// Combine all the layers using top down blending.
	gl_FragColor = vec4(0);
	gl_FragColor = pmCombine(gl_FragColor, colorB*mask.b);
	gl_FragColor = pmCombine(gl_FragColor, colorG*mask.g);
	gl_FragColor = pmCombine(gl_FragColor, colorR*mask.r);
	
	// Now lets have some fun with signed distance fields.
	// First let's add an outline to the red channel color.
	vec4 maskOutline = smoothstep(-fw, fw, distanceField + 0.1);
	gl_FragColor = pmCombine(gl_FragColor, outlineColor*(maskOutline.r));
	
	// You can add soft drow shadows using SDFs too.
	// Not a bad idea to calculate shadow texcoord in the vertex shader.
	vec2 shadowOffset = vec2(0.02, 0.02);
	mediump float shadowMask = 8.0*distance2D(cc_FragTexCoord1 - shadowOffset).r;
	gl_FragColor = pmCombine(gl_FragColor, shadowColor*(shadowMask + 1.0));
}
