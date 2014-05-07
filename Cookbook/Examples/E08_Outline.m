#import "ExampleBase.h"


#define EXAMPLENAME E08_Outline


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	sprite.shaderUniforms[@"u_MainTextureSize"] = [NSValue valueWithCGSize:sprite.texture.contentSize];
	
	ColorSlider *colorSlider = [ColorSlider node];
	colorSlider.startColor = [CCColor colorWithRed:0 green:0 blue:1 alpha:1];
	colorSlider.endColor = [CCColor colorWithRed:0 green:0 blue:1 alpha:0];
	colorSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	colorSlider.colorBlock = ^(CCColor *color){sprite.colorRGBA = color;};
	
	ColorSlider *widthSlider = [ColorSlider node];
	widthSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	widthSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_OutlineWidth"] = @(3.0*color.red);};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:widthSlider];
	[content addChild:colorSlider];
	[content addChild:sprite];
	
	return content;
}

@end
