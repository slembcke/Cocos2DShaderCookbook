#import "ExampleBase.h"


#define EXAMPLENAME E15_SignedDistanceField


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"DistanceField.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	[sprite runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:
		[CCActionScaleTo actionWithDuration:2 scale:4],
		[CCActionScaleTo actionWithDuration:2 scale:1],
		nil
	]]];
	
	return sprite;
}

@end
