//
//  AppDelegate.m
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PPGetAddressBook.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import <CoreLocation/CoreLocation.h>



#import "WelcomeViewController.h"
#import "AppDelegate+Custom.h"
#import "MyTabbarController.h"




#import "HZMyMyCashchangeNM.h"
#import "HZOrderDetailNetManager.h"




@interface AppDelegate ()<CLLocationManagerDelegate>
@property (nonatomic ,strong)BMKMapManager *mapManager;
@property (nonatomic ,strong) UINavigationController *navigationController;
@property(nonatomic,strong) CLLocationManager*manger;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.manger = [[CLLocationManager alloc]init];
    self.manger.distanceFilter = 100.f;//多远获取一次
    self.manger.delegate = self;
    self.manger.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        [self.manger  startUpdatingLocation];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>= 8) {
            
            // 手动开启
            [_manger requestAlwaysAuthorization];
            [_manger requestWhenInUseAuthorization];
            
        }else{
            NSLog(@"版本小于8.0");
        }
    }

   
    
    [PPGetAddressBook requestAddressBookAuthorization];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"ckaylsGMcvG2nHujxKRFzejtdV2ADTpt"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:_navigationController.view];
    [self.window makeKeyAndVisible];
    
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    
    
    
    //归档实现 数据持久化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //通过key值 判断是否是第一次使用
    if ([defaults boolForKey:@"isLogin"] != YES) {
        //第一次使用 进入引导页
        [self showWelcomeView];
    } else {
        //不是第一次使用 进入首页
        [self showHomeViewController];
    }
    
    
    
    
    [self addGlobalConfig];
    return YES;

}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            int status = [[resultDic objectForKey:@"resultStatus"] intValue];
            NSLog(@"dafaf%d",status);
            if (status == 9000) {
                if (_alipayType == TZLAlipayTypeRechangeMode) {
                    [HZMyMyCashchangeNM getRechargeWithOrderCode:_rechange completionHandler:^(id model, NSError *error) {
                        [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
                    }];
                } else {
                    [HZOrderDetailNetManager getOrderAlipayWithOrderId:_orderDic completionHandler:^(id model, NSError *error) {
                        NSLog(@"%@", model);
                        [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
                        
                    }];
                }
                
            }
            
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result1111 = %@",resultDic);
            int status = [[resultDic objectForKey:@"resultStatus"] intValue];
            NSLog(@"dafaf%d",status);
            if (status == 9000) {
                if (_alipayType == TZLAlipayTypeRechangeMode) {
                    
                    [HZMyMyCashchangeNM getRechargeWithOrderCode:_rechange completionHandler:^(id model, NSError *error) {
                        [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
                    }];
                } else {
                    [HZOrderDetailNetManager getOrderAlipayWithOrderId:_orderDic completionHandler:^(id model, NSError *error) {
                        NSLog(@"%@", model);
                        [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
                        
                    }];
                }
            }
            
            
            
        }];
    }
    return YES;
}
-(void)setUp{
    
  }

//ios8以后要用户手动授权
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status==kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if (status==kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"授权成功");
        [self.manger startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    NSLog(@"%f",location.coordinate.latitude);
    NSLog(@"%f",location.coordinate.longitude);
    NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:latitude forKey:@"latitude"];
    [ud setObject:longitude forKey:@"longitude"];
    
    
    // 获取当前所在的城市
    CLGeocoder *geo = [CLGeocoder new];
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error == nil && [placemarks count ]> 0) {
            
            // 地标属性
            CLPlacemark *placeMarks = [placemarks objectAtIndex:0];
            NSLog(@"====%@",placeMarks.locality);
            NSString *city = placeMarks.locality;
            if (!city) {
                city = placeMarks.administrativeArea;
            }
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:city forKey:@"citys"];
            [ud synchronize];
        }
    }];
}



//进入欢迎页
- (void)showWelcomeView {
    WelcomeViewController *welcomeVC = [WelcomeViewController new];
    _window.rootViewController = welcomeVC;
}

//进入app首页
- (void)showHomeViewController {
    
    
    MyTabbarController *mvc= [[MyTabbarController alloc] init];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController=mvc;
    
    
    
}












@end
