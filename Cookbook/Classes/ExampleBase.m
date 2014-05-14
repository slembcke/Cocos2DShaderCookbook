#import "ExampleBase.h"


@implementation ExampleBase

+(NSArray *)examples
{
	NSMutableArray *arr = [NSMutableArray array];
	
	int count = objc_getClassList(NULL, 0);
	Class classes[count];
	objc_getClassList(classes, count);
	
	for(int i=0; i<count; i++){
		Class klass = classes[i];
		if(class_getSuperclass(klass) == self){
			[arr addObject:klass];
		}
	}
	
	return [arr sortedArrayUsingComparator:^NSComparisonResult(Class klass1, Class klass2) {
		return [NSStringFromClass(klass1) compare:NSStringFromClass(klass2)];
	}];
}

+(CCScene *)scene
{
	return [self node];
}

-(id)init
{
	if((self = [super init])){
		self.color = [CCColor whiteColor];
		
		CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:self.exampleName fontName:@"Helvetica" fontSize:18];
		titleLabel.color = [CCColor blackColor];
		titleLabel.positionType = CCPositionTypeNormalized;
		titleLabel.position = ccp(0.5, 0.9);
		[self addChild:titleLabel];
		
		CCButton *prev = [CCButton buttonWithTitle:@"Prev"];
		prev.positionType = CCPositionTypeNormalized;
		prev.position = ccp(0.25, 0.1);
		prev.color = [CCColor blackColor];
		[prev setTarget:self selector:@selector(prev:)];
		[self addChild:prev];
		
		CCButton *next = [CCButton buttonWithTitle:@"Next"];
		next.positionType = CCPositionTypeNormalized;
		next.position = ccp(0.75, 0.1);
		next.color = [CCColor blackColor];
		[next setTarget:self selector:@selector(next:)];
		[self addChild:next];
		
		_exampleContent = self.exampleContent;
		_exampleContent.positionType = CCPositionTypeNormalized;
		_exampleContent.position = ccp(0.5, 0.5);
		[self addChild:_exampleContent];
	}
	
	return self;
}

-(void)prev:(CCButton *)sender
{
	NSArray *examples = [ExampleBase examples];
	NSUInteger index = [examples indexOfObject:self.class];
	
	Class klass = examples[(index - 1 + examples.count)%examples.count];
	[[CCDirector sharedDirector] replaceScene:[klass scene]];
}

-(void)next:(CCButton *)sender
{
	NSArray *examples = [ExampleBase examples];
	NSUInteger index = [examples indexOfObject:self.class];
	
	Class klass = examples[(index + 1 + examples.count)%examples.count];
	[[CCDirector sharedDirector] replaceScene:[klass scene]];
}

-(void)update:(CCTime)delta
{
	_time += delta;
}

-(NSString *)exampleName
{
	NSString *className = NSStringFromClass(self.class);
	
	NSUInteger i = 0;
	NSMutableString *name = [NSMutableString stringWithCapacity:0];
	
	for(; i < className.length; i++){
		unichar c = [className characterAtIndex:i];
		if(c == '_'){
			[name appendString:@": "];
			
			i++;
			break;
		} else {
			[name appendString:[NSString stringWithCharacters:&c length:1]];
		}
	}
	
	for(; i < className.length; i++){
		unichar c = [className characterAtIndex:i];
		if('A' <= c && c <= 'Z'){
			[name appendString:@" "];
		}
		
		[name appendString:[NSString stringWithCharacters:&c length:1]];
	}
	
	return name;
}

-(CCNode *)exampleContent
{
	NSAssert(NO, @"Override me!");
	return nil;
}

-(NSString *)shaderName
{
	return NSStringFromClass(self.class);
}

-(NSString *)sourceString
{
	NSString *shaderName = self.shaderName;
	
	NSString *fragmentName = [shaderName stringByAppendingPathExtension:@"fsh"];
	NSString *fragmentPath = [[CCFileUtils sharedFileUtils] fullPathForFilename:fragmentName];
	NSAssert(fragmentPath, @"Failed to find '%@'.", fragmentName);
	NSString *fragmentSource = [NSString stringWithContentsOfFile:fragmentPath encoding:NSUTF8StringEncoding error:nil];
	
	NSString *vertexName = [shaderName stringByAppendingPathExtension:@"vsh"];
	NSString *vertexPath = [[CCFileUtils sharedFileUtils] fullPathForFilename:vertexName];
	NSString *vertexSource = (vertexPath ? [NSString stringWithContentsOfFile:vertexPath encoding:NSUTF8StringEncoding error:nil] : @"... Default Vertex Shader. Don't worry about it yet.");
	
	return [NSString stringWithFormat:@"VERTEX SHADER:\n\n%@\n\nFRAGMENT SHADER:\n\n%@\n", vertexSource, fragmentSource];
}

-(CCLabelTTF *)sourceLabel
{
	CCLabelTTF *label = [CCLabelTTF labelWithString:self.sourceString fontName:@"Helvetica" fontSize:12.0];
	label.color = [CCColor blackColor];
	
	return label;
}

@end


@implementation ExampleSlider

+(instancetype)sliderNamed:(NSString *)name
{
	return [[self alloc] initWithName:name];
}

-(id)initWithName:(NSString *)name
{
	CCSpriteFrame *bg = [CCSpriteFrame frameWithImageNamed:@"slider-background.png"];
	CCSpriteFrame *handle = [CCSpriteFrame frameWithImageNamed:@"slider-handle.png"];
	
	if((self = [super initWithBackground:bg andHandleImage:handle])){
		self.preferredSize = CGSizeMake(100, bg.originalSize.height);
		
		[self setTarget:self selector:@selector(callback:)];
		self.continuous = YES;
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:[name stringByAppendingString:@":"] fontName:@"Helvetica" fontSize:12];
		label.color = [CCColor blackColor];
		label.anchorPoint = ccp(1.0, 0.5);
		label.positionType = CCPositionTypeNormalized;
		label.position = ccp(-0.1, 0.5);
		
		[self addChild:label];
	}
	
	return self;
}

@end


@implementation FloatSlider {
	CCLabelTTF *_valueLabel;
}

-(id)initWithName:(NSString *)name
{
	if((self = [super initWithName:name])){
		self.startValue = 0.0f;
		self.endValue = 1.0f;
		
		_valueLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:12];
		_valueLabel.color = [CCColor blackColor];
		_valueLabel.anchorPoint = ccp(0.0, 0.5);
		_valueLabel.positionType = CCPositionTypeNormalized;
		_valueLabel.position = ccp(1.1, 0.5);
		
		[self addChild:_valueLabel];
	}
	
	return self;
}

-(void)callback:(CCSlider *)slider
{
	float alpha = slider.sliderValue;
	float value = (1.0f - alpha)*self.startValue + alpha*self.endValue;
	_valueLabel.string = [NSString stringWithFormat:@"%.2f", value];
	
	if(_valueBlock) _valueBlock(value);
}

-(void)setStartValue:(float)startValue
{
	_startValue = startValue;
	[self callback:self];
}

-(void)setEndValue:(float)endValue
{
	_endValue = endValue;
	[self callback:self];
}

-(void)setValueBlock:(void (^)(float))valueBlock
{
	_valueBlock = valueBlock;
	[self callback:self];
}

@end


@implementation ColorSlider {
	CCNodeGradient *_gradient;
}

-(id)initWithName:(NSString *)name
{
	if((self = [super initWithName:name])){
		self.startColor = [CCColor whiteColor];
		self.endColor = [CCColor blackColor];
		
		_gradient = [CCNodeGradient nodeWithColor:self.startColor fadingTo:self.endColor alongVector:ccp(-1, 0)];
		_gradient.contentSizeType = CCSizeTypeNormalized;
		_gradient.contentSize = CGSizeMake(1.0, 1.0);
		
		[self addChild:_gradient z:-1];
	}
	
	return self;
}

-(void)callback:(CCSlider *)slider
{
	if(_colorBlock) _colorBlock([_startColor interpolateTo:_endColor alpha:self.sliderValue]);
}

-(void)setStartColor:(CCColor *)startColor
{
	_startColor = startColor;
	[self callback:self];
	
	_gradient.startColor = startColor;
	_gradient.startOpacity = startColor.alpha;
}

-(void)setEndColor:(CCColor *)endColor
{
	_endColor = endColor;
	[self callback:self];
	
	_gradient.endColor = endColor;
	_gradient.endOpacity = endColor.alpha;
}

-(void)setColorBlock:(void (^)(CCColor *))colorBlock
{
	_colorBlock = colorBlock;
	[self callback:self];
}

@end
