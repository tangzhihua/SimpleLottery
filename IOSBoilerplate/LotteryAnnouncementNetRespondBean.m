//
//  LotteryAnnouncementNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "LotteryAnnouncementNetRespondBean.h"
#import "LotteryAnnouncement.h"

@interface LotteryAnnouncementNetRespondBean ()
@property (nonatomic, readwrite, strong) NSString *noticeTime;
@property (nonatomic, readwrite, strong) NSMutableDictionary *lotteryAnnouncementMap;
@end


@implementation LotteryAnnouncementNetRespondBean


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  LotteryAnnouncement *lotteryAnnouncement = [[LotteryAnnouncement alloc] initWithDictionary:value];
	[self.lotteryAnnouncementMap setValue:lotteryAnnouncement forUndefinedKey:key];
}

- (id) init {
  self = [super init];
  if (self) {
    // Initialization code here.
    self.lotteryAnnouncementMap = [NSMutableDictionary dictionary];
  }
  
  return self;
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
