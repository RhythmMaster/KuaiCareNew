//
//  MyWeiTabarController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MyWeiTabarController.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "MyorderViewController.h"
#import "PersonalViewController.h"
#import "MainWeiViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface MyWeiTabarController ()<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager*manger;

@end

@implementation MyWeiTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self setUp];
    
    
    
    [self initUI];
}
-(void)setUp{
    
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
}
//ios8以后要用户手动授权
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status==kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if (status==kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"授权成功");
        [self.manger startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
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
            [ud setObject:city forKey:@"city"];
            [ud synchronize];
        }
    }];
    
}
-(void)initUI
{
    
    MainViewController *mainWeiVC = [[MainViewController alloc] init];
   
    
    MyorderViewController *orderVC = [[MyorderViewController alloc] init];
    
    PersonalViewController *personVC = [[PersonalViewController alloc] init];
    
    
     
    [self initChildViewController:mainWeiVC tilte:@"首页" imageName:@"icon_m_sy_unselect" selectedImageName:@"icon_m_sy_select"];
   
    [self initChildViewController:orderVC tilte:@"订单" imageName:@"icon_m_dd_unselect" selectedImageName:@"icon_m_dd_select"];
    [self initChildViewController:personVC tilte:@"我的" imageName:@"icon_m_my_unselect" selectedImageName:@"icon_m_my_select"];
    
}
- (void)initChildViewController:(UIViewController *)childViewController tilte:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childViewController];
    
    
    nav.navigationBar.barTintColor = RGB(38, 107, 255);
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barStyle = UIBarStyleBlack;
    nav.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    
    
    
    // 不渲染图片
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 未选中时tabBarItem上字体的颜色
    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(38, 107, 255)} forState:UIControlStateSelected];
    // 设置标题和图片
    
    childViewController.title = title;
    
    childViewController.tabBarItem = [childViewController.tabBarItem initWithTitle:title
                                                                             image:image
                                                                     selectedImage:selectedImage];
    
    [self addChildViewController:nav];
    
    
}@end
