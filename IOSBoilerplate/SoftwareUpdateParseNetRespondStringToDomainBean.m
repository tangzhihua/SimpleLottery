//
//  SoftwareUpdateParseNetRespondStringToDomainBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateParseNetRespondStringToDomainBean.h"

#import "SoftwareUpdateDatabaseFieldsConstant.h"
#import "SoftwareUpdateNetRespondBean.h"

#import "JSONKit.h"

#import "NSDictionary+SafeValue.h"

#import "BroadcastMessageNetReapondBean.h"
#import "LotteryIssueInfo.h"
#import "LotteryCurrentIssueNetRespondBean.h"
#import "UserLoggedInfo.h"
#import "AdImageInWelcomePageNetRespondBean.h"

@implementation SoftwareUpdateParseNetRespondStringToDomainBean
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 IParseNetRespondStringToDomainBean 接口
- (id) parseNetRespondStringToDomainBean:(in NSString *) netRespondString {
  do {
    if ([NSString isEmpty:netRespondString]) {
      PRPLog(@"%@-> 入参 netRespondString 为空 !");
      break;
    }
    
		const char *jsonStringForUTF8 = [netRespondString UTF8String];
		NSError *error = [[NSError alloc] init];
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSDictionary *jsonRootNSDictionary
    = [jsonDecoder objectWithUTF8String:(const unsigned char *)jsonStringForUTF8
                                 length:(unsigned int)strlen(jsonStringForUTF8)];
    jsonDecoder = nil;
		error = nil;
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
		
    // 关键数据字段检测
    NSString *defaultValueForString = @"";
		NSNumber *defaultValueForNumber = [NSNumber numberWithBool:NO];
		NSString *tmpString = nil;
		
		 
    // 获取新闻和下次联网时间
		NSString *news = [jsonRootNSDictionary safeStringObjectForKey:k_News_RespondKey_news withDefaultValue:defaultValueForString];
	  NSNumber *noticetime = [jsonRootNSDictionary safeNumberObjectForKey:k_Noticetime_RespondKey_noticetime withDefaultValue:defaultValueForNumber];
	
		// 广播消息
		BroadcastMessageNetReapondBean *broadcastMessageNetReapondBean = nil;
	  NSDictionary *jsonDictionaryForBroadcastMessage = [jsonRootNSDictionary safeDictionaryObjectForKey:k_BroadcastMessage_RespondKey_broadcastmessage];
    if (jsonDictionaryForBroadcastMessage != nil) {
			
			// 消息ID 客户端保存的id与返回的id比较，如果不同则弹出广播消息
			NSNumber *ID = [jsonDictionaryForBroadcastMessage safeNumberObjectForKey:k_BroadcastMessage_RespondKey_id withDefaultValue:defaultValueForNumber];
			// 消息标题
			NSString *title = [jsonDictionaryForBroadcastMessage safeStringObjectForKey:k_BroadcastMessage_RespondKey_title withDefaultValue:defaultValueForString];
			// 消息内容
			NSString *message = [jsonDictionaryForBroadcastMessage safeStringObjectForKey:k_BroadcastMessage_RespondKey_message withDefaultValue:defaultValueForString];
			
			broadcastMessageNetReapondBean = [BroadcastMessageNetReapondBean broadcastMessageNetReapondBeanWithID:ID title:title message:message];
		}
		
		// 下载图片信息
		AdImageInWelcomePageNetRespondBean *adImageInWelcomePageRespondBean = nil;
		NSDictionary *jsonDictionaryForAdImage = [jsonRootNSDictionary safeDictionaryObjectForKey:k_AdImage_RespondKey_image];
    if (jsonDictionaryForAdImage != nil) {
			
			//  
			NSString *errorCode = [jsonDictionaryForAdImage safeStringObjectForKey:k_AdImage_RespondKey_errorCode withDefaultValue:defaultValueForString];
			BOOL isShowAdImageFromServer = YES;
			if ([errorCode isEqualToString:@"true"]) {
				isShowAdImageFromServer = YES;
			} else {
				isShowAdImageFromServer = NO;
			}
			//  
			NSString *ID = [jsonDictionaryForAdImage safeStringObjectForKey:k_AdImage_RespondKey_id withDefaultValue:defaultValueForString];
			//  
			NSString *imageUrl = [jsonDictionaryForAdImage safeStringObjectForKey:k_AdImage_RespondKey_imageUrl withDefaultValue:defaultValueForString];
			
			adImageInWelcomePageRespondBean = [AdImageInWelcomePageNetRespondBean adImageInWelcomePageNetRespondBeanWithIsShowAdImageFromServer:isShowAdImageFromServer ID:ID imageUrl:imageUrl];
		}
		
		
		// 自动登录用户信息
		UserLoggedInfo *userLoggedInfo = nil;
		NSDictionary *jsonDictionaryForAutoLogin = [jsonRootNSDictionary safeDictionaryObjectForKey:k_AutoLogin_RespondKey_autoLogin];
 
		if (jsonDictionaryForAutoLogin != nil) {
			
			NSString *isAutoLogin = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_isAutoLogin withDefaultValue:defaultValueForString];
			
			 
			if ([isAutoLogin isEqualToString:@"true"]) {
				NSString *userno = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_userno withDefaultValue:defaultValueForString];
				NSString *certid = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_certid withDefaultValue:defaultValueForString];
				NSString *mobileid = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_mobileid withDefaultValue:defaultValueForString];
				NSString *name = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_name withDefaultValue:defaultValueForString];
				NSString *userName = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_userName withDefaultValue:defaultValueForString];
				NSString *sessionid = [jsonDictionaryForAutoLogin safeStringObjectForKey:k_AutoLogin_RespondKey_sessionid withDefaultValue:defaultValueForString];
				
				userLoggedInfo = [UserLoggedInfo userLoggedInfoWithMessage:nil userno:userno certid:certid mobileid:mobileid name:name userName:userName sessionid:sessionid randomNumber:nil];
			}
		}
		
		// 所有彩种的当前排期
		NSMutableDictionary *lotteryCurrentIssueInfoDictionary = [NSMutableDictionary dictionary];
		LotteryCurrentIssueNetRespondBean *lotteryCurrentIssueNetRespondBean = [LotteryCurrentIssueNetRespondBean lotteryCurrentIssueNetRespondBeanWithIssueDictionary:lotteryCurrentIssueInfoDictionary];
		NSDictionary *jsonDictionaryForCurrentBatchCodeInfos = [jsonRootNSDictionary safeDictionaryObjectForKey:k_BatchCodeInfo_RespondKey_currentBatchCode];
    for (NSString *lotteryCode in [jsonDictionaryForCurrentBatchCodeInfos allKeys]) {
			NSDictionary *jsonDictionaryForBatchCodeInfo = [jsonDictionaryForCurrentBatchCodeInfos objectForKey:lotteryCode];
			
			//
			tmpString = [jsonDictionaryForBatchCodeInfo safeStringObjectForKey:k_BatchCodeInfo_RespondKey_batchCode withDefaultValue:defaultValueForString];
			NSNumber *batchCode = nil;
			if (![NSString isEmpty:tmpString]) {
				batchCode = [NSNumber numberWithInteger:[tmpString integerValue]];
			}
			//
			NSNumber *endSecond = [jsonDictionaryForBatchCodeInfo safeNumberObjectForKey:k_BatchCodeInfo_RespondKey_endSecond withDefaultValue:defaultValueForNumber];
			//
			NSString *endTime = [jsonDictionaryForBatchCodeInfo safeStringObjectForKey:k_BatchCodeInfo_RespondKey_endTime withDefaultValue:defaultValueForString];
			
			LotteryIssueInfo *lotteryIssueInfo = [LotteryIssueInfo lotteryIssueInfoWithMessage:nil batchcode:batchCode syscurrenttime:nil starttime:nil endtime:endTime time_remaining:endSecond];
			
			[lotteryCurrentIssueInfoDictionary setObject:lotteryIssueInfo forKey:lotteryCode];
		}
		
		return [SoftwareUpdateNetRespondBean softwareUpdateNetRespondBeanWithNews:news
																																	 noticetime:noticetime
																									broadcastMessageReapondBean:broadcastMessageNetReapondBean
																				lotteryCurrentBatchCodeNetRespondBean:lotteryCurrentIssueNetRespondBean
																					 adImageInWelcomePageNetRespondBean:adImageInWelcomePageRespondBean
																															 userLoggedInfo:userLoggedInfo];
	} while (NO);
  
  return nil;
}

@end