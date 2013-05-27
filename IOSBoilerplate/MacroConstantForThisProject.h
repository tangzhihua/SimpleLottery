//
//  MacroConstantForThisProject.h
//  airizu
//
//  Created by 唐志华 on 12-12-27.
//
//

#ifndef airizu_MacroConstantForThisProject_h
#define airizu_MacroConstantForThisProject_h


/******************         服务器返回的错误枚举      *********************/
typedef NS_ENUM(NSInteger, NetErrorCodeWithServerEnum) {
  kNetErrorCodeWithServerEnum_Failed    = 1000, // "操作失败"
  kNetErrorCodeWithServerEnum_Exception = 2000, // "处理异常"
  kNetErrorCodeWithServerEnum_Noresult  = 3000, // "无结果返回"
  kNetErrorCodeWithServerEnum_Needlogin = 4000  // "需要登录"
};

typedef NS_ENUM(NSInteger, UserNotificationEnum) {
	
	// 从服务器获取重要信息成功
	kUserNotificationEnum_GetImportantInfoFromServerSuccess = 2013,
  // 用户登录 "成功"
  kUserNotificationEnum_UserLogonSuccess,
  // 用户已经退出登录
  kUserNotificationEnum_UserLoged,
  // 获取用户当前的坐标 "成功"
  kUserNotificationEnum_GetUserLocationSuccess,
  // 获取用户当前地址 "成功"
  kUserNotificationEnum_GetUserAddressSuccess,
  // 获取软件新版本信息 "成功"
  kUserNotificationEnum_GetNewAppVersionSuccess,
  // 跳转到 "购彩大厅" 页面
  kUserNotificationEnum_GotoGoucaidatingActivity,

  // 订单支付成功
  kUserNotificationEnum_OrderPaySucceed,
  // 订单支付失败
  kUserNotificationEnum_OrderPayFailed
  
};


typedef NS_ENUM(NSInteger, NewVersionDetectStateEnum) {
  // 还未进行 新版本 检测
  kNewVersionDetectStateEnum_NotYetDetected = 0,
  // 服务器端有新版本存在
  kNewVersionDetectStateEnum_HasNewVersion,
  // 本地已经是最新版本
  kNewVersionDetectStateEnum_LocalAppIsTheLatest
};

// 彩票销售状态
typedef NS_ENUM(NSInteger, LotteryOpenPrizeStatusEnum) {
	kLotteryOpenPrizeStatusEnum_NONE = 0,                 //
  kLotteryOpenPrizeStatusEnum_TodayOpenPrize,           // "今日开奖"
  kLotteryOpenPrizeStatusEnum_TodayAddAward,            // "今日加奖"
  kLotteryOpenPrizeStatusEnum_TodayOpenPrizeAndAddAward // "今日 开奖 + 加奖"
};
 
#define kPlatform @"iPhone"

#define kCoopid   @"28" //appStore

//#define kRuYiCaiCoopid   @"29" //91手机助手iPhone
//#define kRuYiCaiCoopid   @"34" //泡椒iPhone
//#define kRuYiCaiCoopid   @"35" //蚕豆网iPhone
//#define kRuYiCaiCoopid   @"49" //十字猫
//#define kRuYiCaiCoopid   @"53" //软吧

#define kAESKey @"<>hj12@#$$%^~~ff"


#define kAdImageNameForWelcomePage @"adimage.png"


//
#define kLotteryKey_7lecai                  @"7lecai"
#define kLotteryCode_7lecai                 @"F47102"
#define kLotteryName_7lecai                 @"七乐彩"
//
#define kLotteryKey_7xingcai                @"7xingcai"
#define kLotteryCode_7xingcai               @"T01009"
#define kLotteryName_7xingcai               @"七星彩"
//
#define kLotteryKey_22xuan5                 @"22xuan5"
#define kLotteryCode_22xuan5                @"T01013"
#define kLotteryName_22xuan5                @"22选5"
//
#define kLotteryKey_daletou                 @"daletou"
#define kLotteryCode_daletou                @"T01001"
#define kLotteryName_daletou                @"大乐透"
//
#define kLotteryKey_fucai_3d                @"fucai_3d"
#define kLotteryCode_fucai_3d               @"F47103"
#define kLotteryName_fucai_3d               @"福彩3D"
//
#define kLotteryKey_guangdong_11xuan5       @"guangdong_11xuan5"
#define kLotteryCode_guangdong_11xuan5      @"T01014"
#define kLotteryName_guangdong_11xuan5      @"广东11选5"
//
#define kLotteryKey_jingcai_basketball     @"jingcai_basketball"
#define kLotteryCode_jingcai_basketball    @"JC_L"
#define kLotteryName_jingcai_basketball    @"竞彩篮球"
//
#define kLotteryKey_jiangxi_11xuan5         @"jiangxi_11xuan5"
#define kLotteryCode_jiangxi_11xuan5        @"T01010"
#define kLotteryName_jiangxi_11xuan5        @"江西11选5"
//
#define kLotteryKey_jingcai_football        @"jingcai_football"
#define kLotteryCode_jingcai_football       @"JC_Z"
#define kLotteryName_jingcai_football       @"竞彩足球"
//
#define kLotteryKey_pailie3                 @"pailie3"
#define kLotteryCode_pailie3                @"T01002"
#define kLotteryName_pailie3                @"排列三"
//
#define kLotteryKey_pailie5                 @"pailie5"
#define kLotteryCode_pailie5                @"T01001"
#define kLotteryName_pailie5                @"排列五"
//
#define kLotteryKey_shandong_11yun_duojin   @"shandong_11yun_duojin"
#define kLotteryCode_shandong_11yun_duojin  @"T01012"
#define kLotteryName_shandong_11yun_duojin  @"山东十一运夺金"
//
#define kLotteryKey_shishicai               @"shishicai"
#define kLotteryCode_shishicai              @"T01007"
#define kLotteryName_shishicai              @"时时彩"
//
#define kLotteryKey_shuangseqiu             @"shuangseqiu"
#define kLotteryCode_shuangseqiu            @"F47104"
#define kLotteryName_shuangseqiu            @"双色球"
//
#define kLotteryKey_zucai                   @"zucai"
#define kLotteryCode_zucai                  @"T01003"
#define kLotteryName_zucai                  @"足彩"
 

#endif
