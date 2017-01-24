//
//  MyorderViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/11.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MyorderViewController.h"
#import "OrderViewController.h"
#import "CustomBtn2.h"
#import "ChooseCityViewController.h"
#import "CancelAlreadyOrderViewController.h"
#import "CancelWeiJiedanViewController.h"

@interface MyorderViewController ()
@property (nonatomic ,copy)NSString *city;
@property (nonatomic ,strong)CustomBtn2 *button;
@property (nonatomic ,copy)NSString *cityString;
@end

@implementation MyorderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuHeight = 44; //导航栏高度
    self.menuItemWidth = 100; //每个 MenuItem 的宽度
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;//这里设置菜单view的样式
    self.progressHeight = 1;//下划线的高度，需要WMMenuViewStyleLine样式
    self.progressColor = RGB(38, 107, 255);//设置下划线(或者边框)颜色
    self.titleSizeSelected = 18;//设置选中文字大小
    self.titleColorSelected = RGB(38, 107, 255);//设置选中文字颜色
    self.titleSizeNormal = 14;
    self.selectIndex = 0;
    [super viewDidLoad];//这里注意，需要写在最后面，要不然上面的效果不会出现
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"我的订单";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"message_title" name:@"" target:self action:@selector(rightClick)];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    
    CustomBtn2 *button = [[CustomBtn2 alloc] init];
    [button addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 100, 50);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *city = [ud objectForKey:@"citys"];
    NSString *str = [ud objectForKey:@"是"];
    if ([str isEqualToString:@"第一次"]) {
        [button setTitle:city forState:UIControlStateNormal];

    }
    if ([str isEqualToString:@"第二次"]) {
         [button setTitle:self.cityString forState:UIControlStateNormal];
    }
    [button setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = item;
    self.button = button;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];

  }

- (void)tongzhi:(NSNotification *)text{
    
    self.cityString = [text.userInfo objectForKey:@"text"];
    [self.button setTitle:[text.userInfo objectForKey:@"text"] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
    NSLog(@"3333%@ ",[text.userInfo objectForKey:@"text"]);
    
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index == 0) {
        OrderViewController *ordervc = [OrderViewController new];
        ordervc.orderindex = @"0";
        ordervc.orderIndex = 0;
        return ordervc;
    }else if (index == 1)
    {
        OrderViewController *ordervc = [OrderViewController new];
        ordervc.orderindex = @"1";
        ordervc.orderIndex = 1;
        return ordervc;
    }
    OrderViewController *ordervc = [OrderViewController new];
    ordervc.orderindex = @"2";
    ordervc.orderIndex = 2;
    return ordervc;
}


-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"全部";
    }else if (index == 1)
    {
        return @"进行中";
    }
    return @"已完成";
}
-(void)leftClick
{
    self.hidesBottomBarWhenPushed = YES;
    ChooseCityViewController *chooseVC = [[ChooseCityViewController alloc] init];
    chooseVC.block = ^(NSString *str)
    {
        self.city = str;
    };
    [self.navigationController pushViewController:chooseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)rightClick
{

    
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
