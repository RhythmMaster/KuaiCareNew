//
//  LoginViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTabbarController.h"
#import "ForgetPswViewController.h"

#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"





@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *tfUserPhone;
@property (nonatomic,strong)UITextField *tfUserPass;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
   
    
}
-(void)initUI
{
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 0, KCWIDTH, KCHEIGHT*0.45);
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(0, KCHEIGHT*0.45, KCWIDTH, KCHEIGHT*0.25);
    [self.view addSubview:view2];
    
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(0, KCHEIGHT*0.7, KCWIDTH, KCHEIGHT*0.3);
    [self.view addSubview:view3];
    
    
    UIImageView *LogoView = [[UIImageView alloc] init];
    LogoView.image = [UIImage imageNamed:@"Loginlogo"];
    [view1 addSubview:LogoView];
    UILabel *logolabel1 = [[UILabel alloc] init];
    logolabel1.text = @"快护理";
    logolabel1.textColor = RGB(38, 107, 255);
    logolabel1.textAlignment = NSTextAlignmentCenter;
    logolabel1.font = [UIFont systemFontOfSize:16];
    [view1 addSubview:logolabel1];
    
    UILabel *logolabel2 = [[UILabel alloc] init];
    logolabel2.text = @"Faster Attendance";
    logolabel2.textColor = RGB(38, 107, 255);
    logolabel2.textAlignment = NSTextAlignmentCenter;
    logolabel2.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:logolabel2];
    
    [LogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.offset(80);
        make.width.equalTo(view1.mas_width).multipliedBy(0.3);
        make.height.equalTo(view1.mas_width).multipliedBy(0.3);
    }];
    
    [logolabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.equalTo(LogoView.mas_bottom).offset(5);
        make.width.equalTo(view1.mas_width).multipliedBy(0.5);
        make.height.equalTo(view1.mas_height).multipliedBy(0.1);
    }];
    
    [logolabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1.mas_centerX);
        make.top.equalTo(logolabel1.mas_bottom).offset(5);
        make.width.equalTo(view1.mas_width).multipliedBy(0.5);
        make.height.equalTo(view1.mas_height).multipliedBy(0.05);
    }];
    
    UIImageView *phoneView = [[UIImageView alloc] init];
    phoneView.image = [UIImage imageNamed:@"bg_edittext_login"];
    [view2 addSubview:phoneView];
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.image = [UIImage imageNamed:@"icon-请输入用户名"];
    [view2 addSubview:phoneIcon];
    
    _tfUserPhone = [[UITextField alloc] init];
    [_tfUserPhone.placeholder setValue:RGB(38, 107, 255) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfUserPhone setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
    _tfUserPhone.textColor = RGB(38, 107, 255);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults valueForKey:@"phoneText"];
    if (phone) {
        _tfUserPhone.text = phone;
    }
    _tfUserPhone.font = [UIFont systemFontOfSize:14];
    _tfUserPhone.clearButtonMode = UITextFieldViewModeAlways;
    _tfUserPhone.delegate = self;
    [view2 addSubview:_tfUserPhone];
    
    UIImageView *pswView = [[UIImageView alloc] init];
    pswView.image = [UIImage imageNamed:@"bg_edittext_login"];;
    [view2 addSubview:pswView];
    
    UIImageView *pswIcon = [[UIImageView alloc] init];
    pswIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
    [view2 addSubview:pswIcon];
    
    _tfUserPass = [[UITextField alloc] init];

    NSString *pwdText = [defaults valueForKey:@"pwdText"];
    if (pwdText) {
        _tfUserPass.text = pwdText;
    }
    _tfUserPass.textColor = RGB(38, 107, 255);
    _tfUserPass.font = [UIFont systemFontOfSize:14];
    [_tfUserPass.placeholder setValue:RGB(38, 107, 255) forKeyPath:@"_placeholderLabel.textColor"];
    [_tfUserPass setPlaceholder:@"请输入密码"];
    _tfUserPass.clearButtonMode = UITextFieldViewModeAlways;
    _tfUserPass.delegate = self;
    [_tfUserPass setSecureTextEntry:YES];
    [view2 addSubview:_tfUserPass];
    
    UIButton *forgetpswButton = [[UIButton alloc] init];
    [forgetpswButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [forgetpswButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetpswButton setTitleColor:RGB(38, 107, 255) forState:UIControlStateNormal];
    forgetpswButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:forgetpswButton];
    
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.centerX.equalTo(view2.mas_centerX);
        make.width.equalTo(view2.mas_width).multipliedBy(0.8);
        make.height.equalTo(view2.mas_height).multipliedBy(0.25);
    }];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_top).offset(8);
        make.left.equalTo(phoneView.mas_left).offset(20);
        make.width.equalTo(view2.mas_width).multipliedBy(0.05);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    [_tfUserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_top).offset(8);
        make.left.equalTo(phoneIcon.mas_right).offset(15);
        make.width.equalTo(view2.mas_width).multipliedBy(0.6);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    
    [pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.centerX.equalTo(view2.mas_centerX);
        make.width.equalTo(view2.mas_width).multipliedBy(0.8);
        make.height.equalTo(view2.mas_height).multipliedBy(0.25);
    }];
    [pswIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pswView.mas_top).offset(8);
        make.left.equalTo(pswView.mas_left).offset(20);
        make.width.equalTo(view2.mas_width).multipliedBy(0.05);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    [_tfUserPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pswView.mas_top).offset(8);
        make.left.equalTo(pswIcon.mas_right).offset(15);
        make.width.equalTo(view2.mas_width).multipliedBy(0.6);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    [forgetpswButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pswView.mas_bottom).offset(20);
        make.left.equalTo(pswView.mas_left).offset(0);
        make.width.equalTo(view2.mas_width).multipliedBy(0.25);
        make.height.equalTo(view2.mas_height).multipliedBy(0.1);
    }];
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.layer.cornerRadius = 20;
    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = RGB(38, 107, 255);
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:loginButton];
    
    UIButton *registButton = [[UIButton alloc] init];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:RGB(38, 107, 255) forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:registButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_top).offset(5);
        make.centerX.equalTo(view3.mas_centerX);
        make.height.equalTo(view3.mas_height).multipliedBy(0.2);
        make.width.equalTo(view3.mas_width).multipliedBy(0.8);
    }];
    
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(5);
        make.centerX.equalTo(view3.mas_centerX);
        make.height.equalTo(view3.mas_height).multipliedBy(0.2);
        make.width.equalTo(view3.mas_width).multipliedBy(0.8);
    }];
    
}
//点击了登录按钮
-(void)loginButtonClick {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_tfUserPhone.text forKey:@"phoneText"];
    [defaults setValue:_tfUserPass.text forKey:@"pwdText"];
    [defaults synchronize];
    
    
    NSString *userNameString=[_tfUserPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidPhoneNumber:userNameString]){
        
        [MBProgressHUD showToast:_tfUserPhone.placeholder];
        return;
    }
    NSString *userPassString=[_tfUserPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidPassWord:userPassString]){
        
        [MBProgressHUD showToast:_tfUserPass.placeholder];
        return;
    }
   
    NSDictionary *paramaters = @{@"phone":userNameString,@"userPass":userPassString};
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/index/login",KCBaseURLString];
    
    [self.view showBusyHUD];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramaters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];

        if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"登录成功"]) {
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.haveLogin = YES;
            self.hidesBottomBarWhenPushed = YES;
            MyTabbarController *mvc= [MyTabbarController new];
            [self.navigationController pushViewController:mvc animated:YES];
            [kAppdelegate.window showWarning:@"登录成功"];
        } else {
            [self.view showWarning:[responseObject objectForKey:@"MSG"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    

    
}
//点击了注册按钮
-(void)registButtonClick {
    self.hidesBottomBarWhenPushed = YES;
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    WK(weakSelf)
    registerVC.block = ^(NSString *phoneText, NSString *pwdText) {
        weakSelf.tfUserPhone.text = phoneText;
        weakSelf.tfUserPass.text = pwdText;
    };
    [self.navigationController pushViewController:registerVC animated:YES];
}
//点击了忘记密码按钮
-(void)forgetButtonClick
{
  
    ForgetPswViewController *forgetVC = [[ForgetPswViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

-(void)dismissKeyboardEvent{
    
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    [_tfUserPass resignFirstResponder];
    [_tfUserPhone resignFirstResponder];
}

//UITextField method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    if(self.view.frame.origin.y < 0){
        [self moveDownKeyBoard];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    if (_tfUserPass == textField) {
        [_tfUserPass resignFirstResponder];
    }else{
        [_tfUserPhone resignFirstResponder];
    }
    return YES;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if(self.view.frame.origin.y<0){
//        [self moveDownKeyBoard];
//    }
//        [_tfUserPass resignFirstResponder];
//
//        [_tfUserPhone resignFirstResponder];
//    
//}
//
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGFloat offset=320-(self.view.frame.size.height-(textField.frame.origin.y+textField.frame.size.height));
    //    NSLog(@"%f",offset);
    if(offset>0){
        
        [self moveUpKeyBoard:offset];
    }else{
        
        if(!(textField.superview==self.view)){
            
            CGFloat superOffset=320-(H(self.view)-(Y_H(textField.superview)));
            //            NSLog(@"%f",superOffset);
            if(superOffset>0){
                
                [self moveUpKeyBoard:superOffset];
            }
        }
    }
    
    if (textField == _tfUserPhone) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    
    
    
    
    
    
    
}
- (void)moveDownKeyBoard {
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)moveUpKeyBoard:(CGFloat)offset {
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
