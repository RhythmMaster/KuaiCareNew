//
//  ForgetPswViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "LoginViewController.h"
#import "Utils.h"
#import "ErrorInfoConstants.h"
#import "MBProgressHUD+NJ.h"
#import "ErrorInfoConstants.h"
#import "NetConstants.h"
@interface ForgetPswViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *tfUserPhone;
@property (nonatomic,strong)UITextField *tfUserPass;
@property (nonatomic,strong)UITextField *tfCodePass;
@property (nonatomic,strong)UIButton *checkButton;
@property (nonatomic, strong) NSTimer *timer;
@property int timerCount;
@property (nonatomic ,strong)UIButton *getcodeButton;
@property (nonatomic ,copy)NSString *uuid;

@property(nonatomic) UIImageView *isAllowImg;


@end

@implementation ForgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    self.uuid = uuid;
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
    
    
    UIButton *gobackbutton = [[UIButton alloc] init];
    [gobackbutton setImage:[UIImage imageNamed:@"icon-蓝色返回"] forState:UIControlStateNormal];
    [gobackbutton setTitle:@" 登录" forState:UIControlStateNormal];
    [gobackbutton setTitleColor:RGB(38, 107, 255) forState:UIControlStateNormal];
    [gobackbutton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:gobackbutton];
    
    
    
    
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
    
    
    [gobackbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(35);
        make.left.equalTo(-40);
        make.width.equalTo(KCWIDTH*0.4);
        make.height.equalTo(30);
    }];
    
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
    [_tfUserPhone.placeholder setValue:RGB(38, 107, 255) forKeyPath:@"placeholderLabel.textColor"];
    _tfUserPhone.font = [UIFont systemFontOfSize:14];
    [_tfUserPhone setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
    _tfUserPhone.textColor = RGB(38, 107, 255);
    _tfUserPhone.clearButtonMode = UITextFieldViewModeAlways;
    _tfUserPhone.delegate = self;
    [view2 addSubview:_tfUserPhone];
    
    UIImageView *pswView = [[UIImageView alloc] init];
    pswView.image = [UIImage imageNamed:@"bg_edittext_login"];;
    [view2 addSubview:pswView];
    
    UIImageView *pswIcon = [[UIImageView alloc] init];
    pswIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
    [view2 addSubview:pswIcon];
    
    
    
    UIButton *pswSeebutton = [[UIButton alloc] init];
    [pswSeebutton setBackgroundImage:[UIImage imageNamed:@"icon_pw_see"] forState:UIControlStateNormal];
    [pswSeebutton addTarget:self action:@selector(pswSeebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:pswSeebutton];
    
    
    
    
    _tfUserPass = [[UITextField alloc] init];
    [_tfUserPass.placeholder setValue:RGB(38, 107, 255) forKeyPath:@"placeholderLabel.textColor"];
    [_tfUserPass setPlaceholder:@"请输入密码(6-20位，字母和数字组合)"];
    _tfUserPass.textColor = RGB(38, 107, 255);
    _tfUserPass.clearButtonMode = UITextFieldViewModeAlways;
    _tfUserPass.delegate = self;
    _tfUserPass.font = [UIFont systemFontOfSize:14];
    [_tfUserPass setSecureTextEntry:YES];
    [view2 addSubview:_tfUserPass];
    
    
    
    UIImageView *codeView = [[UIImageView alloc] init];
    codeView.image = [UIImage imageNamed:@"bg_edittext_login"];
    [view2 addSubview:codeView];
    
    UIImageView *codeIcon = [[UIImageView alloc] init];
    codeIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
    [view2 addSubview:codeIcon];
    
    _tfCodePass = [[UITextField alloc] init];
    // _tfCodePass.borderStyle = UITextBorderStyleRoundedRect;
    _tfCodePass.font = [UIFont systemFontOfSize:14];
    _tfCodePass.textColor = RGB(38, 107, 255);
    [_tfCodePass.placeholder setValue:RGB(38, 107, 255) forKeyPath:@"placeholderLabel.textColor"];
    [_tfCodePass setPlaceholder:@"请输入验证码"];
    _tfCodePass.clearButtonMode = UITextFieldViewModeAlways;
    _tfCodePass.delegate = self;
    [view2 addSubview:_tfCodePass];
    
    
    _isAllowImg = [UIImageView new];
    _isAllowImg.userInteractionEnabled = YES;
    _isAllowImg.image = [UIImage imageNamed:@"icon_l_hqyzm"];
    [view2 addSubview:_isAllowImg];
    [_isAllowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.centerX.equalTo(view2.mas_centerX);
        make.right.equalTo(codeView.mas_right);
        make.width.equalTo(view2.mas_width).multipliedBy(0.3);
        make.height.equalTo(view2.mas_height).multipliedBy(0.25);
        
    }];
    
    
    _getcodeButton = [[UIButton alloc] init];
    [_getcodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getcodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_getcodeButton addTarget:self action:@selector(getcodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_isAllowImg addSubview:_getcodeButton];
    
    
    
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
    
    
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.centerX.equalTo(view2.mas_centerX);
        make.width.equalTo(view2.mas_width).multipliedBy(0.8);
        make.height.equalTo(view2.mas_height).multipliedBy(0.25);
        
    }];
    
    [codeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_top).offset(8);
        make.left.equalTo(codeView.mas_left).offset(20);
        make.width.equalTo(view2.mas_width).multipliedBy(0.05);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    
    [_tfCodePass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_top).offset(8);
        make.left.equalTo(pswIcon.mas_right).offset(15);
        make.width.equalTo(view2.mas_width).multipliedBy(0.4);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    
    [_getcodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        
    }];
    
    
    [pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_bottom).offset(15);
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
        make.width.equalTo(view2.mas_width).multipliedBy(0.55);
        make.height.equalTo(view2.mas_height).multipliedBy(0.15);
    }];
    
    [pswSeebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tfUserPass.mas_centerY);
        make.left.equalTo(_tfUserPass.mas_right).offset(1);
        make.width.equalTo(view2.mas_width).multipliedBy(0.06);
        make.height.equalTo(view2.mas_height).multipliedBy(0.08);
    }];
    
    
    
    _checkButton = [[UIButton alloc] init];
    [_checkButton setTitle:@"修改密码" forState:UIControlStateNormal];
    _checkButton.backgroundColor = RGB(38, 107, 255);
    _checkButton.layer.cornerRadius = 20;
    _checkButton.layer.masksToBounds = YES;
    [_checkButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:_checkButton];
    
    
   
    
    
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerX.equalTo(view3.mas_centerX);
        make.height.equalTo(view3.mas_height).multipliedBy(0.2);
        make.width.equalTo(view3.mas_width).multipliedBy(0.8);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    if(self.view.frame.origin.y < 0){
        [self moveDownKeyBoard];
    }
}


- (void)getcodeButtonClick
{
    NSString* phoneNumber=[_tfUserPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidPhoneNumber:phoneNumber]){
        
        [MBProgressHUD showToast:Error_TextFiled_PhoneNumber];
        return;
    }else{
        _timerCount = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
        _isAllowImg.image = [UIImage imageNamed:@"icon_l_djs"];
        [_getcodeButton setEnabled:false];
    }
    [MBProgressHUD showMessage:Net_Connecting];
    
    NSDictionary *parameters = @{@"phone":phoneNumber,@"uniqueCode":self.uuid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app/common/randomCode",KCBaseURLString];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",responseObject);
        NSDictionary *resultDic = responseObject;
        [MBProgressHUD showToast:[resultDic objectForKey:@"MSG"]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}
-(void)timerFireMethod{
    
    _timerCount--;
    if(_timerCount==0){
        [_timer invalidate];
        _timer = nil;
        [_getcodeButton setEnabled:true];
        _isAllowImg.image = [UIImage imageNamed:@"icon_l_hqyzm"];
        [_getcodeButton setTitle:@"验证码" forState:UIControlStateNormal];
        
    }else{
        
        NSString *title=[NSString stringWithFormat:@"%iS重发",_timerCount];
        [_getcodeButton setTitle:title forState:UIControlStateNormal];
    }
}
-(void)checkButtonClick
{
    
    NSString* phoneNumber=[_tfUserPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidPhoneNumber:phoneNumber]){
        
        [MBProgressHUD showToast:Error_TextFiled_PhoneNumber];
        return;
    }
    NSString* registerCode=[_tfCodePass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidRegisterCode:registerCode]){
        
        [MBProgressHUD showToast:Error_TextFiled_RegisterCode];
        return;
    }
    NSString* userPass=[_tfUserPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![Utils isInvalidPassWord:userPass]){
        
        [MBProgressHUD showToast:_tfUserPass.placeholder];
        return;
    }
    [MBProgressHUD showMessage:Net_Connecting];
    NSDictionary *parameters = @{@"phone":phoneNumber,@"userPass":userPass,@"randomCode":registerCode,@"uniqueCode":self.uuid};
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/index/retrievePass",KCBaseURLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"密码已重置成功"] ) {
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}
-(void)pswSeebuttonClick
{
    _tfUserPass.enabled = NO;
    _tfUserPass.secureTextEntry = !_tfUserPass.secureTextEntry;
    _tfUserPass.enabled = YES;
    
}
-(void)goBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dismissKeyboardEvent{
    
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    [_tfUserPass resignFirstResponder];
    [_tfUserPhone resignFirstResponder];
    [_tfCodePass resignFirstResponder];
}

//UITextField method

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    if (_tfUserPass == textField) {
        [_tfUserPass resignFirstResponder];
    }else  if(_tfCodePass == textField)
    {
        [_tfCodePass resignFirstResponder];
    }else
    {
        [_tfUserPhone resignFirstResponder];
    }
    return YES;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if(self.view.frame.origin.y<0){
//        [self moveDownKeyBoard];
//    }
//
//        [_tfUserPass resignFirstResponder];
//        [_tfCodePass resignFirstResponder];
//        [_tfUserPhone resignFirstResponder];
//
//}

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
    
    if (textField == _tfUserPhone || textField == _tfCodePass) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}
-(void)moveDownKeyBoard{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)moveUpKeyBoard:(CGFloat)offset{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
