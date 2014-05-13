#import "ExampleBase.h"
#import "CCTexture_Private.h"

#define EXAMPLENAME E11_PixelBlur

@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];

	// Load the distortion texture, a noise texture which we use to determine how to offset individual fragments when we draw them.
	CCTexture* noise = [CCTexture textureWithFile:@"gaussianNoise.png"];
	// Nearest neighboor interpolating to create a pixely effect out of the distortion texture.
	noise.texParameters = &(ccTexParams){GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT};
	
	sprite.shaderUniforms[@"u_NoiseTexture"] = noise;
	// Pass in the content size in pixels so we can match the texture to the screen pixel for pixel.
	sprite.shaderUniforms[@"u_NoiseTextureSize"] = [NSValue valueWithCGSize:noise.contentSizeInPixels];
	
	// We use the texture's size, so we can scale the distortion to match the aspect ratio of the texture.
	sprite.shaderUniforms[@"u_MainTextureSize"] = [NSValue valueWithCGSize:sprite.texture.contentSize];

	ColorSlider *blurSlider = [ColorSlider node];
	blurSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	blurSlider.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	blurSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:0];
	blurSlider.sliderValue = 0.5;
	blurSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_BlurRadius"] = [NSNumber numberWithFloat:20.0*color.red];};
	
	ColorSlider *animationSlider = [ColorSlider node];
	animationSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	animationSlider.endColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	// Round the number so it's on or off. 0 will disable the animation, 1 will enable it.
	animationSlider.colorBlock = ^(CCColor *color){sprite.shaderUniforms[@"u_AnimationEnabled"] = [NSNumber numberWithFloat: roundf(color.red)];};
	
	ColorSlider *blockSizeSlider = [ColorSlider node];
	blockSizeSlider.preferredSize = CGSizeMake(sprite.contentSize.width, 32);
	blockSizeSlider.startColor = [CCColor colorWithRed:0 green:0 blue:0 alpha:0];
	blockSizeSlider.endColor = [CCColor colorWithRed:1 green:1 blue:1 alpha:1];
	blockSizeSlider.colorBlock = ^(CCColor *color){
		float size = floorf(powf(2.0f, 8.0*color.red));
		sprite.shaderUniforms[@"u_BlockSize"] = [NSNumber numberWithFloat:size];
	};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:blockSizeSlider];
	[content addChild:animationSlider];
	[content addChild:blurSlider];
	[content addChild:sprite];
	
	
	
	return content;
}

@end
