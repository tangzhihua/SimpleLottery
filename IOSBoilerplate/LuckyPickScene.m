//
//  LuckyPickView.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-4.
//
//

#import "LuckyPickScene.h"

#import "LuckyPickMainLayer.h"


@implementation LuckyPickScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	

	LuckyPickMainLayer *layer = [LuckyPickMainLayer node];
	[scene addChild: layer];
  
   
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
    
		
    
	}
	return self;
}
@end
