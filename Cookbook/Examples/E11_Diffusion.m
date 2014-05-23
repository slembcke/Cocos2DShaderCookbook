#import "ExampleBase.h"
#import "CCTexture_Private.h"

#define EXAMPLENAME E11_Diffusion

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

	FloatSlider *blurSlider = [FloatSlider sliderNamed:@"Radius"];
	blurSlider.endValue = 10.0f;
	blurSlider.sliderValue = 0.5;
	blurSlider.valueBlock = ^(float value){sprite.shaderUniforms[@"u_Radius"] = @(value);};
	
	FloatSlider *animationSlider = [FloatSlider sliderNamed:@"Animation"];
	animationSlider.sliderValue = 1.0;
	// Round the number so it's on or off. 0 will disable the animation, 1 will enable it.
	animationSlider.valueBlock = ^(float value){sprite.shaderUniforms[@"u_AnimationEnabled"] = @(roundf(value));};
	
	FloatSlider *blockSizeSlider = [FloatSlider sliderNamed:@"BlockSize"];
	blockSizeSlider.startValue = 1.0f;
	blockSizeSlider.endValue = 256.0f;
	blockSizeSlider.valueBlock = ^(float value){sprite.shaderUniforms[@"u_BlockSize"] = @(floorf(value));};
	
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
