#import "ExampleBase.h"


#define EXAMPLENAME E13_MotionBlur


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME
{
	CCSprite * _sprite;
}

-(CCNode *)exampleContent
{
	_sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	_sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	
	CGPoint blurVector = CGPointMake(1.0, -1.5);
	
	CGPoint p = CGPointMake(blurVector.x / _sprite.texture.contentSize.width, blurVector.y / _sprite.texture.contentSize.height);
	_sprite.shaderUniforms[@"u_BlurVector"] = [NSValue valueWithCGPoint:p];

	
	return _sprite;
}

-(void)update:(CCTime)delta
{
	_sprite.position = ccp(5.0/6.0, 0.5);
}

@end
