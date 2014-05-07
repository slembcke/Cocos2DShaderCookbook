#import "cocos2d.h"
#import "ExampleBase.h"


@interface E01_SimplestShader : ExampleBase @end
@implementation E01_SimplestShader

-(CCNode *)exampleContent
{
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Logo.png"];
	
	// Load the fragment shader in the file name E01_SimplestShader.fsh.
	// Also loads E01_SimplestShader.vsh as the vertex shader if it exists.
	sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	return sprite;
}

@end
