//
//  WelcomeViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/7.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void) initUI {
    
    UIImageView *backView = [UIImageView new];
    backView.userInteractionEnabled = YES;//打开背景图片交互性
    backView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    backView.image = [UIImage imageNamed:@"icon_welcome"];
    [self.view addSubview:backView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(backView.mas_bottom).equalTo(-120);
        make.left.equalTo(60);
        make.height.equalTo(backView.mas_height).multipliedBy(0.1);
    }];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_welcome_bt"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(intoLogin:) forControlEvents:UIControlEventTouchUpInside];
}

//进入app  login
- (void)intoLogin:(UIButton *)sender {
    
    //数据持久化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isLogin"];
    [defaults synchronize];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showHomeViewController];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
