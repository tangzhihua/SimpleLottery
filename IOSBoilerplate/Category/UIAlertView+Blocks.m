//
//  UIAlertView+Blocks.m
//  UIKitCategoryAdditions
//

#import "UIAlertView+Blocks.h"

static dispatch_queue_t queue() {
  static dispatch_queue_t _queue = NULL;
  if (_queue == NULL) {
    _queue = dispatch_queue_create("UIAlertView+Blocks", DISPATCH_QUEUE_CONCURRENT);
  }
  return _queue;
}


static NSMutableDictionary *blockCache(){
  static NSMutableDictionary *_blockCache = nil;
  // synchronization 同步互斥
  dispatch_sync(queue(), ^{
		if (_blockCache == nil) {
      _blockCache = [NSMutableDictionary dictionaryWithCapacity:50];
    }
	});
  
  return _blockCache;
}

@implementation UIAlertView (Blocks)

static NSInteger _tagForUIAlertView = 0;
+ (UIAlertView *) showAlertViewWithTitle:(NSString *) title
                                 message:(NSString *) message
                       cancelButtonTitle:(NSString *) cancelButtonTitle
                       otherButtonTitles:(NSArray *) otherButtons
                               onDismiss:(DismissBlock) dismissed
                                onCancel:(CancelBlock) cancelled {
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                  message:message
                                                 delegate:[self self]
                                        cancelButtonTitle:cancelButtonTitle
                                        otherButtonTitles:nil];
  
  alert.tag = _tagForUIAlertView++;
  NSMutableArray *blockArray = [NSMutableArray arrayWithCapacity:2];
  blockArray[0] = cancelled;
  blockArray[1] = dismissed;
  [blockCache() setObject:blockArray forKey:[NSNumber numberWithInteger:alert.tag]];
  
  for(NSString *buttonTitle in otherButtons) {
    [alert addButtonWithTitle:buttonTitle];
  }
  
  [alert show];
  return alert;
}

+ (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
  
  NSMutableArray *blockArray = [blockCache() objectForKey:[NSNumber numberWithInteger:alertView.tag]];
  CancelBlock cancelBlock = blockArray[0];
  DismissBlock dismissBlock = blockArray[1];
  
	if(buttonIndex == [alertView cancelButtonIndex]) {
		cancelBlock();
	} else {
    dismissBlock(buttonIndex - 1); // cancel button is button 0
  }
  
  [blockCache() removeObjectForKey:[NSNumber numberWithInteger:alertView.tag]];
}


@end