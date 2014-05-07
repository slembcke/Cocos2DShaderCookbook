#import "ExampleBase.h"
#import "CCTextureCache.h"
#import "CCTexture_Private.h"

#define EXAMPLENAME E11_PixelBlur

@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];

	CCTexture* distortion = [[CCTextureCache sharedTextureCache] addImage:@"gaussianBlur.png"];
	// Nearest neighboor interpolating to create a pixely effect out of the distortion texture.
	ccTexParams params = {GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT};
	[distortion setTexParameters:&params];
	
	sprite.shaderUniforms[@"u_DistortionTexture"] = distortion;
	sprite.shaderUniforms[@"u_mainTextureSize"] = [NSValue valueWithCGSize:distortion.contentSizeInPixels];

	
	
	ColorSlider *distortionSlider = [ColorSlider node];
	distortionSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	distortionSlider.endColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	distortionSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_DistortionSize"] = [NSNumber numberWithFloat:color.red *0.1f];};
	
	ColorSlider *animationSlider = [ColorSlider node];
	animationSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	animationSlider.endColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	// Round the number so it's on or off
	animationSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_AnimationEnabled"] = [NSNumber numberWithFloat: roundf(color.red)];};
	
	ColorSlider *blockSizeSlider = [ColorSlider node];
	blockSizeSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	blockSizeSlider.endColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	blockSizeSlider.colorBlock = ^(CCColor *color){
		sprite.shaderUniforms[@"u_BlockSize"] = [NSNumber numberWithFloat:color.red];
	};
	
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:blockSizeSlider];
	[content addChild:animationSlider];
	[content addChild:distortionSlider];
	[content addChild:sprite];
	
	
	
	return content;
}

@end
