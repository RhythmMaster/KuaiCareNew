//
//  YuechongzhiViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuechongzhiViewController.h"
#import "HZMyMyCashchangeNM.h"

@interface YuechongzhiViewController ()<UITextFieldDelegate>

@property(nonatomic) UIView *backView;
@property(nonatomic) UILabel *moneyLb;
@property(nonatomic) UITextField *textField;
@property(nonatomic) UIButton *nextBtn;




@end

@implementation YuechongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"余额充值";

   
    [self textField];
    [self nextBtn];
    
    
    
}
-(void)initUI {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 20, KCWIDTH, 40);
    [self.view addSubview:backView];
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.frame =CGRectMake(20, 15, KCWIDTH*0.2, 20);
    namelabel.text = @"金额 (元)";
    [backView addSubview:namelabel];

    
    UITextField *pricetextfield = [[UITextField alloc] init];
    pricetextfield.frame = CGRectMake(KCWIDTH*0.2 + 30, 10, KCWIDTH*0.6, 20);
    pricetextfield.placeholder = @"请输入金额";
    [backView addSubview:pricetextfield];
    
    
    UIButton *nextButton = [[UIButton alloc] init];
    nextButton.frame = CGRectMake(15, 50, KCWIDTH-30, 50);
    nextButton.layer.cornerRadius = 5;
    nextButton.layer.masksToBounds = YES;
    nextButton.backgroundColor = RGB(146, 171, 213);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark delete textField
- (void) textFieldDidChange:(UITextField *) TextField {
    if (TextField.text.length) {
        self.nextBtn.backgroundColor = kBlueColor;
    } else {
        _nextBtn.backgroundColor = RGB(146, 171, 213);
        
    }
    
}


#pragma mark method 
- (void)nextClick:(UIButton *)sendder {
    [self.view endEditing:YES];
    if (!_textField.text.length) {
        [self.view showWarning:@"请输入金额!"];
        return;
    }
    
    
    
    NSString *appID = kAlipayAppID;
    NSString *privateKey = kAlipayPrivateKey;
    if ([appID length] == 0 || [privateKey length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少appId或者私钥。"delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"快护理账户充值";
    order.biz_content.subject = @"快护理账户充值";
    
    
    
    //自己生成订单编号
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter1 = [NSDateFormatter new];
    formatter1.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *dateStr = [formatter1 stringFromDate:now];
    kAppdelegate.rechange = dateStr;
    NSLog(@"dateStr%@", dateStr);
    
    NSString *zhifucode = dateStr;
    order.biz_content.out_trade_no = zhifucode; //订单ID（由商家自行制定）
    
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", self.textField.text.floatValue]; //商品价格
    //order.biz_content.total_amount = self.zhifuprice; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"kuaihuli";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, signedString];
        kAppdelegate.alipayType = TZLAlipayTypeRechangeMode;
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"aaffaf %@",resultDic);
            
            int status = [[resultDic objectForKey:@"resultStatus"] intValue];
            NSLog(@"dafaf%d",status);
            
            if (status == 9000) {
                [HZMyMyCashchangeNM getRechargeWithOrderCode:zhifucode completionHandler:^(id model, NSError *error) {
                   
                    NSLog(@"model:%@", model);
                    
                }];
            }
            
        }];
        
    }
    
    
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    
    
}


#pragma  mark lazy

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.left.right.equalTo(0);
            make.height.equalTo(50);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)moneyLb {
    if (!_moneyLb) {
        _moneyLb = [UILabel new];
        [self.backView addSubview:_moneyLb];
        [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _moneyLb.text = @"金额 (元)";
    }
    return _moneyLb;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        [self.backView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLb.mas_right).equalTo(8);
            make.centerY.equalTo(0);
            make.height.equalTo(45);
            make.width.equalTo(kScreenW * 0.7);
        }];
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.placeholder = @"请输入金额";
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.top.equalTo(self.backView.mas_bottom).equalTo(10);
            make.height.equalTo(50);
        }];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 5;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.backgroundColor = RGB(146, 171, 213);
        [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
