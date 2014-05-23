#import "ExampleBase.h"
#import "CCTexture_Private.h"


#define EXAMPLENAME E10_Water


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Rocks.png"];
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	sprite.shaderUniforms[@"u_CausticTexture"] = [CCTexture textureWithFile:@"Caustic.png"];
	
	CCTexture *noise = [CCTexture textureWithFile:@"BisectionNoise.png"];
	noise.texParameters = &(ccTexParams){GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
	sprite.shaderUniforms[@"u_NoiseTexture"] = noise;
	
	return sprite;
}

@end
