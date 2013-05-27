//
//  ListActivity.h
//  airizu
//
//  Created by 唐志华 on 13-1-8.
//
//

#import "Activity.h"

#import "EGORefreshTableHeaderView.h"

@interface ListActivity : Activity <EGORefreshTableHeaderDelegate> {
  
  EGORefreshTableHeaderView *_refreshHeaderView;
  BOOL _reloading;
  
}

@property (nonatomic, retain) IBOutlet UITableView *table;

- (void)doneLoadingTableViewData;
@end

