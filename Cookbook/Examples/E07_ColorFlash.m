#import "ExampleBase.h"


#define EXAMPLENAME E07_ColorFlash


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	ColorSlider *flashSlider = [ColorSlider sliderNamed:@"Flash Color"];
	flashSlider.startColor = [CCColor colorWithRed:1 green:0 blue:0 alpha:0];
	flashSlider.endColor = [CCColor redColor];
	flashSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_ColorFlash"] = color;};
		
	ColorSlider *tintSlider = [ColorSlider sliderNamed:@"Tint Color"];
	tintSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:0];
	tintSlider.colorBlock = ^(CCColor *color){sprite.colorRGBA = color;};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:tintSlider];
	[content addChild:flashSlider];
	[content addChild:sprite];
	
	return content;
}

@end
