//
//  GoucaidatingActivity.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "Activity.h"
#import "CustomControlDelegate.h"

@interface GoucaidatingActivity : ListActivity
<UITableViewDelegate,
UITableViewDataSource,
IDomainNetRespondCallback,
CustomControlDelegate,
UIAlertViewDelegate> {
	
}

@property (weak, nonatomic) IBOutlet UIView *bodyLayout;



@end
