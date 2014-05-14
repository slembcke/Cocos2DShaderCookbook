#import "ExampleBase.h"


@interface E02_SpriteColor : ExampleBase @end
@implementation E02_SpriteColor

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	ColorSlider *slider = [ColorSlider sliderNamed:@"Tint Color"];
	slider.positionType = CCPositionTypeNormalized;
	slider.position = ccp(0.5, 0.25);
	slider.anchorPoint = ccp(0.5, 0.5);
	slider.endColor = [CCColor magentaColor];
	slider.colorBlock = ^(CCColor *color){sprite.color = color;};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:slider];
	[content addChild:sprite];
	
	return content;
}

@end
