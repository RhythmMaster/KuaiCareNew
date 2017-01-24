//
//  ViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//
#import "ViewController.h"
#import "AppDelegate.h"
#import "MyTabbarController.h"
//#import <CoreLocation/CoreLocation.h>


@interface ViewController ()
//@property(nonatomic,strong) CLLocationManager*manger;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"2" forKey:@"firstLogin"];
   
    [ud setObject:@"第一次" forKey:@"是"];
    [ud synchronize];
    [ud synchronize];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    UIImageView *backView = [[UIImageView alloc] init];
    backView.userInteractionEnabled = YES;//打开背景图片的可交互性
    backView.frame = CGRectMake(0, 0, KCWIDTH, KCHEIGHT);
    backView.image = [UIImage imageNamed:@"icon_welcome"];
    [self.view addSubview:backView];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(backView.mas_bottom).offset(-120);
        make.left.offset(60);
        make.height.equalTo(backView.mas_height).multipliedBy(0.1);
    }];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_welcome_bt"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(tiyanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)tiyanButtonClick
{
        MyTabbarController *mvc= [[MyTabbarController alloc] init];
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        app.window.rootViewController=mvc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
