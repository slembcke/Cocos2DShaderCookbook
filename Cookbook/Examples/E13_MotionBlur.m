#import "ExampleBase.h"


#define EXAMPLENAME E13_MotionBlur


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME
{
	CCSprite * _sprite;
	float _blurStrength;
}

-(CCNode *)exampleContent
{
	
	_blurStrength = 10000.0;
	
	_sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	_sprite.shader = [CCShader shaderNamed:self.shaderName];
	

	
	ColorSlider *blurStrengthSlider = [ColorSlider node];
	blurStrengthSlider.sliderValue = 0.5f;
	blurStrengthSlider.preferredSize = CGSizeMake(_sprite.contentSize.width, 32);
	blurStrengthSlider.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	blurStrengthSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:1];
	blurStrengthSlider.colorBlock = ^(CCColor *color){
		_blurStrength = color.red * 10000.0;
	};

	CCNode *content = [CCNode node];
	//content.contentSize = CGSizeMake(100.0f, 100.0f);
	blurStrengthSlider.position = ccp(-200, -300);
	
	[content addChild:blurStrengthSlider];
	[content addChild:_sprite];
	
	return content;
}

-(void)update:(CCTime)delta
{
	[super update:delta];
	
	CGPoint previousPosition = _sprite.position;
	
	_sprite.position = ccp(5.0/6.0, 0.5);
	_sprite.position = ccpAdd(_sprite.position, ccp(sinf(self.time * 2.0) / 10.0, cosf(self.time * 3.0) / 10.0));
	
	// To find the amount we moved this frame, we can subtract our new position from the previous position...
	CGPoint blurVector = ccpSub(_sprite.position, previousPosition);
	
	CGPoint p = CGPointMake(blurVector.x / _sprite.texture.contentSize.width * _blurStrength, blurVector.y / _sprite.texture.contentSize.height * _blurStrength);
	_sprite.shaderUniforms[@"u_BlurVector"] = [NSValue valueWithCGPoint:p];
}

@end
