//
//  LuckyPickNumberDisplayLayer.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-4.
//
//

#import "LuckyPickNumberDisplayLayer.h"

#import "LuckyPickNumberDisplayView.h"

@implementation LuckyPickNumberDisplayLayer
-(id) init
{
	if( (self=[super init])) {
    
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    //获取图像
    LuckyPickNumberDisplayView *view = [LuckyPickNumberDisplayView luckyPickNumberDisplayView];
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
      UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    } else {
      UIGraphicsBeginImageContext(view.frame.size);
    }
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
		CCSprite *background;
		
		background = [CCSprite spriteWithCGImage:image.CGImage key:@"test"];
    
		background.position = ccp(160, size.height+170);
    
		// add the label as a child to this Layer
		[self addChild: background];
    
    // Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
    
		
		// Achievement Menu Item using blocks
		CCMenuItem *menuItemOfGo = [CCMenuItemFont itemWithString:@"关闭" block:^(id sender) {
			
      
      
      id move = [CCMoveBy actionWithDuration:3 position:ccp(0, size.height)];
      //	id move_back = [move reverse];
      
      id move_ease_inout1 = [CCEaseElasticInOut actionWithAction:[move copy] period:0.3f];
      
      
      
			[self runAction:move_ease_inout1];
      
      
		}];
		
    
    
		
		CCMenu *menu = [CCMenu menuWithItems:menuItemOfGo, nil];
		
    [menu setColor:ccBLUE];
		[menu alignItemsHorizontallyWithPadding:40];
		[menu setPosition:ccp(size.width/2, size.height+300)];
		
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
