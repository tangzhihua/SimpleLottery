//
//  LuckyPickMainLayer.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-4.
//
//

#import "LuckyPickMainLayer.h"

#import "LuckyPickNumberDisplayLayer.h"

@interface LuckyPickMainLayer ()
@property (nonatomic, strong) LuckyPickNumberDisplayLayer *numberDisplayLayer;

@property (nonatomic, strong) CCSprite *testSprite;
@end


@implementation LuckyPickMainLayer

-(id) init
{
	if( (self=[super init])) {
    
    self.numberDisplayLayer = [LuckyPickNumberDisplayLayer node];
    [self addChild:self.numberDisplayLayer z:3];
    
    self.testSprite = [CCSprite spriteWithFile:@"lottery_icon_for_pailie3.png"];
    
    
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"欢迎来到Cocos2d的世界" fontName:@"Marker Felt" fontSize:30];
    
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
    
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// to avoid a retain-cycle with the menuitem and blocks
		__weak id weakSelf = self;
		
		// Achievement Menu Item using blocks
		CCMenuItem *menuItemOfGo = [CCMenuItemFont itemWithString:@"大奖GO" block:^(id sender) {
			
      CGSize s = [[CCDirector sharedDirector] winSize];
      
      id move = [CCMoveBy actionWithDuration:3 position:ccp(0, -s.height)];
      //	id move_back = [move reverse];
      
      id move_ease_inout1 = [CCEaseElasticInOut actionWithAction:[move copy] period:0.3f];
      id move_ease_inout_back1 = [move_ease_inout1 reverse];
      
      
      
      id delay = [CCDelayTime actionWithDuration:0.25f];
      
      id seq1 = [CCSequence actions: move_ease_inout1, delay, move_ease_inout_back1, [delay copy], nil];
      
      
   

			[self.numberDisplayLayer runAction:move_ease_inout1];
      
		}];
		
 
    
		
		CCMenu *menu = [CCMenu menuWithItems:menuItemOfGo, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
 
}

@end
