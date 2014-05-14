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
	
	_blurStrength = 20.0;
	
	_sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	_sprite.shader = [CCShader shaderNamed:self.shaderName];
	

	// TODO: If you add the _sprite (and slider) to content node, the _sprite no longer moves.
	/*
	ColorSlider *blurStrengthSlider = [ColorSlider node];
	blurStrengthSlider.sliderValue = 0.5f;
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
	 */
	
	return _sprite;
}

-(void)update:(CCTime)delta
{
	[super update:delta];
	
	CGPoint previousPosition = _sprite.position;
	
	_sprite.position = ccp(0.5, 0.5);
	_sprite.position = ccpAdd(_sprite.position, ccp(sinf(self.time * 2.0) / 10.0, cosf(self.time * 3.0) / 10.0));
	
	// To find the amount we moved this frame, we can subtract our new position from the previous position...
	CGPoint blurVector = ccpSub(_sprite.position, previousPosition);
	
	// Cocos2D flips the y axis.
	blurVector.y = -blurVector.y;

	// Divide by the delta time to avoid inconsistent trail lengths when framerate is inconsistent. And multiply by blur strength.s
	blurVector = CGPointMake(blurVector.x / delta * _blurStrength, blurVector.y / delta * _blurStrength);
	
	CGPoint p = CGPointMake(blurVector.x / _sprite.texture.contentSize.width, blurVector.y / _sprite.texture.contentSize.height);
	_sprite.shaderUniforms[@"u_BlurVector"] = [NSValue valueWithCGPoint:p];
}

@end
