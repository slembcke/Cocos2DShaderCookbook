#import "ExampleBase.h"
#import "CCTexture_Private.h"


#define EXAMPLENAME E09_Static


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	CCTexture *noise = [CCTexture textureWithFile:@"gaussianNoise.png"];
	noise.texParameters = &(ccTexParams){GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT};
	sprite.shaderUniforms[@"u_NoiseTexture"] = noise;

	FloatSlider *noiseSlider = [FloatSlider sliderNamed:@"Amount"];
	noiseSlider.sliderValue = 1.0;
	noiseSlider.valueBlock = ^(float value){sprite.shaderUniforms[@"u_NoiseAmount"] = [NSNumber numberWithFloat:value];};
	
	CCLayoutBox *content = [CCLayoutBox node];
	content.anchorPoint = ccp(0.5, 0.5);
	content.direction = CCLayoutBoxDirectionVertical;
	
	[content addChild:noiseSlider];
	[content addChild:sprite];
	
	return content;
}

@end
