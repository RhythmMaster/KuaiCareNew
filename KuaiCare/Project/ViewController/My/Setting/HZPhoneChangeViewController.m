//
//  HZPhoneChangeViewController.m
//  dddd
//
//  Created by tang on 16/12/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPhoneChangeViewController.h"

#import "HZGetCodeNM.h"

@interface HZPhoneChangeViewController ()<UITextFieldDelegate>

@property(nonatomic) NSInteger timerCount;
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic) UIView *registerView;

@property (nonatomic) UITextField *tfUserPhone;

@property(nonatomic) UITextField *tfUserPwd;

@property(nonatomic) UITextField *tfUserCode;

@property(nonatomic) UIImageView *isAllowImg;

@property(nonatomic) UIView *btnView;

@property(nonatomic) UIButton *registerBtn;

@property(nonatomic) UIButton *getCodeBtn;
@property(nonatomic) NSString *UUID;

@end

@implementation HZPhoneChangeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _UUID = [[NSUUID UUID] UUIDString];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(1);
    }];
    lineView.backgroundColor = kRGBA(234, 234, 234, 1.0);
    
    
    
    [self registerView];
    [self btnView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (_tfUserPwd == textField) {
        [_tfUserPwd resignFirstResponder];
    } else if (_tfUserPhone) {
        [_tfUserPhone resignFirstResponder];
    } else {
        [_tfUserCode resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _tfUserPhone || textField == _tfUserCode) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) textFieldDidChange:(UITextField *) TextField {
    
    if (TextField.text.length) {
        _registerBtn.backgroundColor = kBlueColor;
    } else {
        _registerBtn.backgroundColor = kRGBA(146, 171, 214, 1.0);
    }
    
}



#pragma mark method 
//获取验证码
- (void)getCodeClick:(UIButton *)sender {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *uuid = [defaults valueForKey:@"uuid"];
    
    NSString *phoneText = _tfUserPhone.text;
    
    if (![TZLFactory isInvalidPhoneNumber:phoneText]) {
        [self.view showWarning:@"请输入正确手机号码"];
        return;
    } else {
        _timerCount = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(registerTimerFireMethod:) userInfo:nil repeats:YES];
        _isAllowImg.image = [UIImage imageNamed:@"icon_l_djs"];
        [sender setEnabled:false];
        
    }
    
    [kAppdelegate.window showBusyHUD];
    [HZGetCodeNM getRandomCodeWithUUID:_UUID flag:@"fff" phoneNumber:phoneText completionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
    }];
    
    
}

- (void)registerTimerFireMethod:(UIButton *)sender {
    
    _timerCount--;
    if(_timerCount == 0){
        [_timer invalidate];
        _timer = nil;
        [_getCodeBtn setEnabled:true];
        //   [_getcodeButton setBackgroundColor:baseTheamColor];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _isAllowImg.image = [UIImage imageNamed:@"icon_l_hqyzm"];
        
    }else{
        
        NSString *title=[NSString stringWithFormat:@"%ldS重发",_timerCount];
        [_getCodeBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)submitClick:(UIButton *)sender {
    
    NSLog(@"提交");
    
    NSString *phoneText = _tfUserPhone.text;
    
    if (![TZLFactory isInvalidPhoneNumber:phoneText]) {
        [self.view showWarning:@"请输入正确手机号码"];
        return;
    }
    
    [self.view showBusyHUD];
    [HZGetCodeNM getPwdByPhoneWithUUID:_UUID codeNumber:_tfUserCode.text newPassword:_tfUserPwd.text phoneNumber:phoneText completionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        
        if ([[model objectForKey:@"STATE"] integerValue]) {
            
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"密码修改成功!" message:@"请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [app showHomeViewController];
                
            }];
            [alertController addAction:logoutAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            
        }
        
    }];
    
    
}


- (void)isSeeClick1:(UIButton *)sender {
    _tfUserPhone.secureTextEntry = !_tfUserPhone.secureTextEntry;
}

- (void)isSeeClick:(UIButton *)sender {
    _tfUserCode.secureTextEntry = !_tfUserCode.secureTextEntry;
}

#pragma mark -懒加栽
- (UIView *)registerView {
    if (!_registerView) {
        _registerView = [UIView new];
        _registerView.frame = CGRectMake(0, 20, kScreenW, kScreenH * 0.25);
        [self.view addSubview:_registerView];
        
        //用户输入框背景
        UIImageView *userTfBackImg = [self tfBackImg];
        [_registerView addSubview:userTfBackImg];
        [userTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.9);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        //用户名icon
        UIImageView *userIcon = [UIImageView new];
        userIcon.image = [UIImage imageNamed:@"icon-请输入用户名"];
        [userTfBackImg addSubview:userIcon];
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
            
        }];
        
        //用户输入框
        [userTfBackImg addSubview:self.tfUserPhone];
        [_tfUserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userIcon.mas_right).equalTo(10);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.74, _registerView.height * 0.15));
        }];
        
        
        
        //验证码输入框背景
        UIImageView *CodeTfBackImg = [UIImageView new];
        CodeTfBackImg.userInteractionEnabled = YES;
        CodeTfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
        [_registerView addSubview:CodeTfBackImg];
        [CodeTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userTfBackImg.mas_bottom).equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.9);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        _isAllowImg = [UIImageView new];
        _isAllowImg.userInteractionEnabled = YES;
        _isAllowImg.image = [UIImage imageNamed:@"icon_l_hqyzm"];
        [_registerView addSubview:_isAllowImg];
        [_isAllowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userTfBackImg.mas_bottom).equalTo(15);
            make.right.equalTo(CodeTfBackImg.mas_right);
            make.bottom.equalTo(CodeTfBackImg.mas_bottom);
        }];
        
        
        
        //密码icon
        UIImageView *pwdIcon = [UIImageView new];
        pwdIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
        [CodeTfBackImg addSubview:pwdIcon];
        [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(CodeTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
        }];
        
        //密码输入框
        [CodeTfBackImg addSubview:self.tfUserCode];
        [_tfUserCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdIcon.mas_right).equalTo(10);
            make.centerY.equalTo(CodeTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.48, _registerView.height * 0.15));
        }];
        
        
        //获取验证码
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [_isAllowImg addSubview:_getCodeBtn];
        [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_getCodeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //密码
        //背景框
        UIImageView *pwdTfBackImg = [UIImageView new];
        pwdTfBackImg.userInteractionEnabled = YES;
        pwdTfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
        [_registerView addSubview:pwdTfBackImg];
        [pwdTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CodeTfBackImg.mas_bottom).equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.9);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        //密码icon
        UIImageView *psdIcon = [UIImageView new];
        psdIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
        [pwdTfBackImg addSubview:psdIcon];
        [psdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
        }];
        //密码输入框
        [pwdTfBackImg addSubview:self.tfUserPwd];
        [_tfUserPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdIcon.mas_right).equalTo(10);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.70, _registerView.height * 0.15));
        }];
        
        
        
        
        UIButton *isSeeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [isSeeBtn setImage:[UIImage imageNamed:@"icon_pw_see"] forState:UIControlStateNormal];
        [pwdTfBackImg addSubview:isSeeBtn];
        [isSeeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.right.equalTo(-8);
        }];
        [isSeeBtn addTarget:self action:@selector(isSeeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _registerView;
}
- (UIImageView *)tfBackImg {
    
    UIImageView *tfBackImg = [UIImageView new];
    tfBackImg.userInteractionEnabled = YES;
    tfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
    return tfBackImg;
}

- (UITextField *)tfUserPhone {
    if (!_tfUserPhone) {
        _tfUserPhone = [[UITextField alloc] init];
        [_tfUserPhone setTextColor:[UIColor whiteColor]];
        [_tfUserPhone.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        [_tfUserPhone setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
        _tfUserPhone.font = [UIFont systemFontOfSize:14];
        _tfUserPhone.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPhone.textColor = kBlueColor;
        _tfUserPhone.delegate = self;
        [self.view addSubview:_tfUserPhone];
    }
    return _tfUserPhone;
}

- (UITextField *)tfUserCode {
    if (!_tfUserCode) {
        _tfUserCode = [[UITextField alloc] init];
        _tfUserCode.font = [UIFont systemFontOfSize:14];
        [_tfUserCode setTextColor:[UIColor whiteColor]];
        [_tfUserCode.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserCode.placeholder = @"请输入验证码";
        _tfUserCode.textColor = kBlueColor;
        _tfUserCode.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserCode.delegate = self;
        [self.view addSubview:_tfUserCode];
        
    }
    return _tfUserCode;
}

- (UITextField *)tfUserPwd {
    if (!_tfUserPwd) {
        _tfUserPwd = [[UITextField alloc] init];
        _tfUserPwd.font = [UIFont systemFontOfSize:14];
        [_tfUserPwd setTextColor:[UIColor whiteColor]];
        [_tfUserPwd.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserPwd.placeholder = @"请输入新密码(6-20位,字母和数字组合)";
        _tfUserPwd.textColor = kBlueColor;
        [_tfUserPwd setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        _tfUserPwd.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPwd.delegate = self;
        _tfUserPwd.secureTextEntry = YES;
        [self.view addSubview:_tfUserPwd];
        
    }
    return _tfUserPwd;
}

- (UIView *)btnView {
    if (!_btnView) {
        _btnView = [UIView new];
        _btnView.frame = CGRectMake(0, kScreenH * 0.30, kScreenW, kScreenH * 0.3);
        [self.view addSubview:_btnView];
        
        
        
        //提交按钮
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerBtn setTitle:@"提交" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = kRGBA(38, 107, 255, 1.0);
        _registerBtn.layer.cornerRadius = _btnView.height * 0.1;
        _registerBtn.layer.masksToBounds = YES;
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
       
        [_btnView addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.centerX.equalTo(0);
            make.height.equalTo(_btnView.mas_height).multipliedBy(0.2);
            make.width.equalTo(_btnView.mas_width).multipliedBy(0.9);
        }];
        
        
    }
    return _btnView;
}




@end
