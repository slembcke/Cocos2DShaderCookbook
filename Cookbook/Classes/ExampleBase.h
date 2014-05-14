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

@end


@interface ExampleSlider : CCSlider

+(instancetype)sliderNamed:(NSString *)name;

@end


@interface FloatSlider : ExampleSlider

@property(nonatomic, assign) float startValue, endValue;
@property(nonatomic, copy) void (^valueBlock)(float value);

@end


@interface ColorSlider : ExampleSlider

@property(nonatomic, strong) CCColor *startColor, *endColor;
@property(nonatomic, copy) void (^colorBlock)(CCColor *color);

@end
