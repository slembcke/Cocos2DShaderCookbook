#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface ExampleBase : CCScene {
	CCNode *_exampleContent;
	CCLabelTTF *_sourceLabel;
}

+(NSArray *)examples;

+(instancetype)scene;

@property(nonatomic, readonly) NSString *exampleName;

@property(nonatomic, readonly) NSString *shaderName;
@property(nonatomic, readonly) CCTime time;

@property(nonatomic, readonly) CCNode *exampleContent;
@property(nonatomic, readonly) CCLabelTTF *sourceLabel;

@end


@interface ColorSlider : CCSlider

@property(nonatomic) CCColor *startColor, *endColor;

-(id)initWithNode:(CCNode *)node;

@end
