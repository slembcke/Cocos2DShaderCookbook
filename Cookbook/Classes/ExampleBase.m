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
		
		CCLabelTTF *exampleLabel = [CCLabelTTF labelWithString:self.exampleName fontName:@"Helvetica" fontSize:36];
		exampleLabel.color = [CCColor blackColor];
		exampleLabel.positionType = CCPositionTypeNormalized;
		exampleLabel.position = ccp(0.1, 0.9);
		exampleLabel.anchorPoint = ccp(0.0, 0.5);
		[self addChild:exampleLabel];
		
		// Nav buttons
		{
			CCButton *back = [CCButton buttonWithTitle:@"Back"];
			back.color = [CCColor blackColor];
			[back setTarget:self selector:@selector(back:)];
			
			CCButton *prev = [CCButton buttonWithTitle:@"Prev"];
			prev.color = [CCColor blackColor];
			[prev setTarget:self selector:@selector(prev:)];
			
			CCButton *next = [CCButton buttonWithTitle:@"Next"];
			next.color = [CCColor blackColor];
			[next setTarget:self selector:@selector(next:)];
			
			CCLayoutBox *buttons = [CCLayoutBox node];
			buttons.spacing = 10.0;
			buttons.anchorPoint = ccp(1.0, 0.5);
			buttons.positionType = CCPositionTypeNormalized;
			buttons.position = ccp(0.9, 0.9);
			
//			[buttons addChild:back];
			[buttons addChild:prev];
			[buttons addChild:next];
			[self addChild:buttons];
		}
		
		_exampleContent = self.exampleContent;
		_exampleContent.positionType = CCPositionTypeNormalized;
		_exampleContent.position = ccp(5.0/6.0, 0.5);
//		_exampleContent.position = ccp(0.5, 0.5);
		[self addChild:_exampleContent];
		
		_sourceLabel = self.sourceLabel;
		_sourceLabel.positionType = CCPositionTypeNormalized;
		_sourceLabel.position = ccp(2.0/6.0, 0.5);
		_sourceLabel.anchorPoint = ccp(0.5, 0.5);
		[self addChild:_sourceLabel];
	}
	
	return self;
}

-(void)back:(CCButton *)sender
{
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
	return NSStringFromClass(self.class);
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


@implementation ColorSlider {
	CCNodeGradient *_gradient;
}

-(id)init
{
	CCSpriteFrame *bg = [CCSpriteFrame frameWithImageNamed:@"slider-background.png"];
	CCSpriteFrame *handle = [CCSpriteFrame frameWithImageNamed:@"slider-handle.png"];
	
	if((self = [super initWithBackground:bg andHandleImage:handle])){
		self.startColor = [CCColor whiteColor];
		self.endColor = [CCColor blackColor];
		
		[self setTarget:self selector:@selector(callback:)];
		self.continuous = YES;
		
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
