#import "ExampleBase.h"


@interface E03_SpriteDistort : ExampleBase @end
@implementation E03_SpriteDistort

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	return sprite;
}

@end
