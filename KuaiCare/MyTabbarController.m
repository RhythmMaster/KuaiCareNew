//
//  MyTabbarController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/25.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MyTabbarController.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "MyorderViewController.h"
#import "PersonalViewController.h"
#import "MainWeiViewController.h"

@interface MyTabbarController ()
@property (nonatomic ,strong)UIViewController *vc;

@property(nonatomic) BOOL isLogin;

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isLogin = NO;
    
    [self initUI];
    
    

}
-(void)initUI
{
    
    MainWeiViewController *mainWeiVC = [[MainWeiViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc] init];
  
    MyorderViewController *orderVC = [[MyorderViewController alloc] init];
    
    PersonalViewController *personVC = [[PersonalViewController alloc] init];

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL haveLogin = app.haveLogin;
    
    
    if (haveLogin) {
         [self initChildViewController:mainVC tilte:@"首页" imageName:@"icon_m_sy_unselect" selectedImageName:@"icon_m_sy_select"];
    }
    else {
        [self initChildViewController:mainWeiVC tilte:@"首页" imageName:@"icon_m_sy_unselect" selectedImageName:@"icon_m_sy_select"];
        
    }
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
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
