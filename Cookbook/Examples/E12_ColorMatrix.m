#import "ExampleBase.h"
#import "CCTextureCache.h"
#import "CCTexture_Private.h"

#define EXAMPLENAME E12_ColorMatrix

@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME
{
	float _colorRotation = 0.0f;
	float _colorScale = 1.0f;
	float _saturationAdjustment = 1.0f;
	CCSprite *_sprite;
}

-(CCNode *)exampleContent
{
	_sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	_sprite.shader = [CCShader shaderNamed:self.shaderName];

	_sprite.shaderUniforms[@"u_ColorMatrix"] = [NSValue valueWithGLKMatrix4:GLKMatrix4Identity];
	
	ColorSlider *hueRotation = [ColorSlider node];
	hueRotation.preferredSize = CGSizeMake(_sprite.contentSize.width, 32);
	hueRotation.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	hueRotation.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:1];
	hueRotation.colorBlock = ^(CCColor *color){
		_colorRotation = color.red * M_PI * 2.0;
		[self updateColors];
	};
	
	ColorSlider *colorScaleSlider = [ColorSlider node];
	colorScaleSlider.sliderValue = 0.5f;
	colorScaleSlider.preferredSize = CGSizeMake(_sprite.contentSize.width, 32);
	colorScaleSlider.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	colorScaleSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:1];
	colorScaleSlider.colorBlock = ^(CCColor *color){
		_colorScale = color.red * 2.0;
		[self updateColors];
	};
	
	
	ColorSlider *luminanceSlider = [ColorSlider node];
	luminanceSlider.sliderValue = 0.5f;
	luminanceSlider.preferredSize = CGSizeMake(_sprite.contentSize.width, 32);
	luminanceSlider.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	luminanceSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:1];
	luminanceSlider.colorBlock = ^(CCColor *color){
		_saturationAdjustment = color.red * 2.0;
		[self updateColors];
	};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:luminanceSlider];
	[content addChild:colorScaleSlider];
	[content addChild:hueRotation];
	[content addChild:_sprite];
	
	return content;
}

-(void) updateColors
{

	// For a nice guide on image manipulation using matricies, see:
	// http://www.graficaobscura.com/matrix/
	// There's probably a lot more you could do, but here are some simple examples.
	
	GLKMatrix4  colorMatrix = GLKMatrix4Identity;
	// Multiply in the color rotation matrix, for hue rotation.
	colorMatrix = GLKMatrix4Rotate(colorMatrix, _colorRotation, 1, 1, 1);

	// Brightness adjustments are defined as a scale operation.
	colorMatrix = GLKMatrix4Scale(colorMatrix, _colorScale, _colorScale, _colorScale);
	
	// Adjust Saturation:
	colorMatrix = GLKMatrix4Multiply(colorMatrix, GLKMatrix4MakeSaturation(_saturationAdjustment));
	
	_sprite.shaderUniforms[@"u_ColorMatrix"] = [NSValue valueWithGLKMatrix4:colorMatrix];
}

/*
 * Adjust the saturation. Good values for s range from zero (convert to 
 * black and white), to 1.0 (no change), and up (for oversaturation)
 */
GLKMatrix4 GLKMatrix4MakeSaturation(float s)
{
	// These are some luminance values defined by the gamma.
	float rwgt = 0.3086;
	float gwgt = 0.6094;
	float bwgt = 0.0820;
	// Calculate coefficients.
	float red = (1.0 - s)*rwgt;
	float blue = (1.0 - s)*bwgt;
	float green = (1.0 - s)*gwgt;
	// Adding "s" serves as a scale term.
	return GLKMatrix4MakeAndTranspose(red + s,	red,				red,				0,
																		blue,			blue + s,		blue,				0,
																		green,		green,			green + s,	0,
																		0,				0,					0,					1);
}

@end
