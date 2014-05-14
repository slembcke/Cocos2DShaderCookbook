#import "ExampleBase.h"
#import "CCTextureCache.h"
#import "CCTexture_Private.h"

#define EXAMPLENAME E12_ColorMatrix

@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME
{
	float _colorRotation;
	float _colorScale;
	float _saturationAdjustment;
	CCSprite *_sprite;
}

-(CCNode *)exampleContent
{
	_colorRotation = 0.0f;
	_colorScale = 1.0f;
	_saturationAdjustment = 1.0f;
	
	_sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	_sprite.shader = [CCShader shaderNamed:self.shaderName];

	_sprite.shaderUniforms[@"u_ColorMatrix"] = [NSValue valueWithGLKMatrix4:GLKMatrix4Identity];
	
	FloatSlider *hueRotation = [FloatSlider sliderNamed:@"Hue Rotation"];
	hueRotation.startValue = 0.0f;
	hueRotation.endValue = 360.0f;
	hueRotation.valueBlock = ^(float value){
		_colorRotation = value*M_PI/180.0f;
		[self updateColors];
	};
	
	FloatSlider *colorScaleSlider = [FloatSlider sliderNamed:@"Exposure"];
	colorScaleSlider.endValue = 2.0f;
	colorScaleSlider.sliderValue = 0.5f;
	colorScaleSlider.valueBlock = ^(float value){
		_colorScale = value;
		[self updateColors];
	};
	
	
	FloatSlider *saturationSlider = [FloatSlider sliderNamed:@"Saturation"];
	saturationSlider.endValue = 2.0f;
	saturationSlider.sliderValue = 0.5f;
	saturationSlider.valueBlock = ^(float value){
		_saturationAdjustment = value;
		[self updateColors];
	};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:saturationSlider];
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
