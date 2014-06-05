#ifdef GL_ES
#extension GL_OES_standard_derivatives : enable
#endif

// These are premultiplied colors.
const vec4 fillColor = vec4(0, 0, 0, 1);
const vec4 glowColor = vec4(1, 0, 1, 1);

// If you want the glow to be additive instead of alpha blended, make it's alpha 0.

// Render texture must be above this to get filled.
const float threshold = 0.5;

// Render texture must be above this to glow.
const float glowThreshold = 0.4;

vec4 composite(vec4 over, vec4 under){
	return over + (1.0 - over.a)*under;
}

void main(){
	vec4 textureColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
	
	// Lay down the glow first
	float glowAlpha = (textureColor.a - glowThreshold)/(threshold - glowThreshold);
	gl_FragColor = glowColor*glowAlpha;
	
	// Composite the filled blob over the glow.
	// High quality anti-aliased version:
	float fw = fwidth(textureColor.a)*0.5;
	float fillAlpha = smoothstep(threshold - fw, threshold + fw, textureColor.a);
	
	// Slightly faster aliased version:
//	float fillAlpha = step(threshold, textureColor.a);

	gl_FragColor = composite(fillColor*fillAlpha, gl_FragColor);
}
