#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface ExampleBase : CCScene {
	CCNode *_exampleContent;
	CCLabelTTF *_sourceLabel;
}

+(NSArray *)examples;

+(instancetype)scene;

-(NSString *)shaderName;

-(CCNode *)exampleContent;
-(CCLabelTTF *)sourceLabel;

@end


@interface ColorSlider : CCSlider

@property(nonatomic) CCColor *startColor, *endColor;

-(id)initWithNode:(CCNode *)node;

@end
