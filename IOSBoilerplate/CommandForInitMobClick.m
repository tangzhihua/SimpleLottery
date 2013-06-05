//
//  CommandForInitMobClick.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForInitMobClick.h"
#import "MobClick.h"


@interface CommandForInitMobClick ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
 
@end

#define UMENG_APPKEY @"51ac6bd456240b1826074e2d"
@implementation CommandForInitMobClick

- (void)onlineConfigCallBack:(NSNotification *)note {
  
  NSLog(@"online config has fininshed and note = %@", note.userInfo);
}


/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  
  //  友盟的方法本身是异步执行，所以不需要再异步调用
  
  if (!_isExecuted) {
		_isExecuted = YES;
		
    // 开启CrashReport收集, 默认是开启状态.
    [MobClick setCrashReportEnabled:YES];
    
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //[MobClick setLogEnabled:YES];
    
    // reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    // channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:kCoopid];
    
    // 按渠道自动更新检测 : 在友盟的网站上分渠道提交app的版本号，更新日志及openURL后，您只需添加一行代码来完成自动更新检查。
    // [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    // [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    
    // 在线参数配置 : 使用在线参数功能，可以让你动态修改应用中的参数值
    // 示例： 动态修改应用的欢迎语，修改应用中开关选项的"on"或"off"，以及类似游戏中虚拟物品的价格。
    [MobClick updateOnlineConfig];// 这句代码从服务器获取在线参数，并缓存本地。
    // 当在项目里需要获取某个具体参数时调用 [MobClick getConfigParams:@"xxxx"];
    // xxxx为友盟服务器上事先设置好的key。 如果你想获取所有的在线参数，请使用. [MobClick getConfigParams];
    // 这两个方法都是从[NSUserDefaults standardUserDefaults]获取缓存的值，
    // 所以上面的[MobClick updateOnlineConfig]方法要先在app启动时被调用。
    
    
    // 注意：
    // updateOnlineConfig 在app启动时 application:didFinishLaunchingWithOptions: 执行，
    // 前后台切换是不会执行的，如果需要在切换时更新在线参数，可以在相关回调里执行updateOnlineConfig 。
    
    // 如果您需要知道在线参数何时获取完毕，可以监听 UMOnlineConfigDidFinishedNotification ,
    // 当这个通知发生时，最新的在线参数会传递给notification.userInfo。
    
    // 如果此时未联网或在线参数获取失败，这个通知是不会被发出的。
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onlineConfigCallBack:)
                                                 name:UMOnlineConfigDidFinishedNotification
                                               object:nil];
     */
    // 最后别忘记调用removeObserver:name:object: 删除这个监听。

  }
  
}


#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    _isExecuted = NO;
  }
  
  return self;
}

+(id)commandForInitMobClick {
 
  static CommandForInitMobClick *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}
@end
