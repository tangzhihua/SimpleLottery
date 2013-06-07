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
-(NSMutableDictionary *)lotteryAnnouncementMap{
  if (_lotteryAnnouncementMap == nil) {
    _lotteryAnnouncementMap = [[NSMutableDictionary alloc] initWithCapacity:20];
  }
  return _lotteryAnnouncementMap;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  LotteryAnnouncement *lotteryAnnouncement = [[LotteryAnnouncement alloc] initWithDictionary:value];
	[self.lotteryAnnouncementMap setValue:lotteryAnnouncement forKey:key];
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
