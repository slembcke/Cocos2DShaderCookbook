#import "ExampleBase.h"

#import "CCTexture_Private.h"


#define EXAMPLENAME E16_MetaParticles


@interface EXAMPLENAME : ExampleBase @end
@implementation EXAMPLENAME

-(CCNode *)exampleContent
{
	// Percentage of the screen covered by the effect.
	CGSize size = CC_SIZE_SCALE(self.contentSizeInPoints, 1.0);
	
	CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:size.width height:size.height];
	rt.autoDraw = YES;
	rt.clearColor = [CCColor clearColor];
	rt.clearFlags = GL_COLOR_BUFFER_BIT;
	rt.sprite.shader = [CCShader shaderNamed:self.shaderName];
	
	// Run the render texture at a low resolution.
	// No need to waste fillrate on a smooth effect.
	rt.contentScale = 0.5;
	
	// This is currently a private method, thus the private header above.
	// Render textures default to using nearest neighbor (aliased/blocky) filtering.
	// The effect will look really crummy if it's blocky.
	rt.texture.antialiased = YES;
	
	CCParticleSystem *particles = [CCParticleSystem particleWithFile:@"Fog.plist"];
	particles.position = ccp(size.width/2, size.height/2);
	[rt addChild:	particles];
	
	return rt;
}

@end
