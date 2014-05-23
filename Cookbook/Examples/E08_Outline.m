#import "ExampleBase.h"


#define EXAMPLENAME E08_Outline


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	ColorSlider *colorSlider = [ColorSlider sliderNamed:@"Outline Color"];
	colorSlider.startColor = [CCColor colorWithRed:0 green:0 blue:1 alpha:1];
	colorSlider.endColor = [CCColor colorWithRed:0 green:0 blue:1 alpha:0];
	colorSlider.colorBlock = ^(CCColor *color){sprite.colorRGBA = color;};
	
	FloatSlider *widthSlider = [FloatSlider sliderNamed:@"Outline Width"];
	widthSlider.endValue = 3.0;
	widthSlider.sliderValue = 1.0;
	widthSlider.valueBlock = ^(float value){sprite.shaderUniforms[@"u_OutlineWidth"] = @(value);};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:widthSlider];
	[content addChild:colorSlider];
	[content addChild:sprite];
	
	return content;
}

@end
