//
//  HZShareViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZShareViewController.h"
#import "Custom1.h"
@interface HZShareViewController ()


@property(nonatomic) Custom1 *WeChatBtn;

@property(nonatomic) Custom1 *FriendBtn;

@property(nonatomic) Custom1 *QQBtn;

@property(nonatomic) Custom1 *QQSpaceBtn;

@property(nonatomic) UIView *topView;

@property(nonatomic) UIView *weChatView;

@property(nonatomic) UIView *friendView;

@property(nonatomic) UIView *QQView;

@property(nonatomic) UIView *QQSpaceView;

@property(nonatomic) UIView *upView;

@property(nonatomic) UIImageView *bigImg;

@property(nonatomic) UILabel *inviteLb;

@end

@implementation HZShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //去掉背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //去掉底部线条
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"分享有礼";

    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self WeChatBtn];
    [self FriendBtn];
    [self QQBtn];
    [self QQSpaceBtn];
    [self inviteLb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -懒加栽
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(0);
            make.height.equalTo(self.view.mas_height).multipliedBy(0.15);
        }];
        _topView.backgroundColor = RGB(38, 107, 255);
        //_topView.layer.borderColor = [UIColor colorWithRed:38 green:107 blue:255 alpha:2.0].CGColor;
    }
    return _topView;
}

- (UIView *)weChatView {
    if (!_weChatView) {
        _weChatView = [UIView new];
        [self.topView addSubview:_weChatView];
        [_weChatView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(KCWIDTH * 0.25);
        }];
        
        
    }
    return _weChatView;
}
- (UIView *)friendView {
    if (!_friendView) {
        _friendView = [UIView new];
        [self.topView addSubview:_friendView];
        [_friendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.weChatView.mas_right);
            make.width.equalTo(KCWIDTH * 0.25);
        }];
        
    }
    return _friendView;
}
- (UIView *)QQView {
    if (!_QQView) {
        _QQView = [UIView new];
        [self.topView addSubview:_QQView];
        [_QQView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.friendView.mas_right);
            make.width.equalTo(KCWIDTH * 0.25);
        }];
        
    }
    return _QQView;
}
- (UIView *)QQSpaceView {
    if (!_QQSpaceView) {
        _QQSpaceView = [UIView new];
        [self.topView addSubview:_QQSpaceView];
        [_QQSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.QQView.mas_right);
            make.width.equalTo(KCWIDTH * 0.25);
        }];
        
    }
    return _QQSpaceView;
}



- (Custom1 *)WeChatBtn {
    if (!_WeChatBtn) {
        _WeChatBtn = [Custom1 buttonWithType:UIButtonTypeCustom];
        [self.weChatView addSubview:_WeChatBtn];
        [_WeChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 60));
        }];
        
        _WeChatBtn.img.image = [UIImage imageNamed:@"img_weixin"];
        _WeChatBtn.nameLb.text = @"微信";
        
        _WeChatBtn.tag = 1111;
        
    }
    return _WeChatBtn;
}

- (Custom1 *)FriendBtn {
    if (!_FriendBtn) {
        _FriendBtn = [Custom1 buttonWithType:UIButtonTypeCustom];
        [self.friendView addSubview:_FriendBtn];
        [_FriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 60));
        }];
        _FriendBtn.img.image = [UIImage imageNamed:@"img_friends"];
        _FriendBtn.nameLb.text = @"朋友圈";
        _FriendBtn.tag = 1112;
    }
    return _FriendBtn;
}

- (Custom1 *)QQBtn {
    if (!_QQBtn) {
        _QQBtn = [Custom1 buttonWithType:UIButtonTypeCustom];
        [self.QQView addSubview:_QQBtn];
        [_QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 60));
        }];
        _QQBtn.img.image = [UIImage imageNamed:@"qq"];
        _QQBtn.nameLb.text = @"QQ";
        _QQBtn.tag = 1113;
    }
    return _QQBtn;
}

- (Custom1 *)QQSpaceBtn {
    if (!_QQSpaceBtn) {
        _QQSpaceBtn = [Custom1 buttonWithType:UIButtonTypeCustom];
        [self.QQSpaceView addSubview:_QQSpaceBtn];
        [_QQSpaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 60));
        }];
        _QQSpaceBtn.img.image = [UIImage imageNamed:@"img_qq_place"];
        _QQSpaceBtn.nameLb.text = @"QQ空间";
        _QQSpaceBtn.tag = 1114;
    }
    return _QQSpaceBtn;
}



- (UIView *)upView {
    if (!_upView) {
        _upView = [UIView new];
        [self.view addSubview:_upView];
        [_upView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.topView.mas_bottom);
        }];
    }
    return _upView;
}

- (UIImageView *)bigImg {
    if (!_bigImg) {
        _bigImg = [UIImageView new];
        [self.upView addSubview:_bigImg];
        [_bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(100);
            
        }];
        _bigImg.image = [UIImage imageNamed:@"img_inbite"];
    }
    return _bigImg;
}

- (UILabel *)inviteLb {
    if (!_inviteLb) {
        _inviteLb = [UILabel new];
        [self.upView addSubview:_inviteLb];
        [_inviteLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.bigImg.mas_bottom).equalTo(25);
        }];
        _inviteLb.text = @"邀请新朋友获得30元优惠券奖励";
        _inviteLb.font = [UIFont systemFontOfSize:18];
        _inviteLb.textColor = [UIColor lightGrayColor];
    }
    return _inviteLb;
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



















@end
