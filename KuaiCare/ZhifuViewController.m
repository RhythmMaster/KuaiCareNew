//
//  ZhifuViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ZhifuViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderFirstTableViewCell.h"
#import "OrderSecondTableViewCell.h"
#import "OrderThirdTableViewCell.h"
#import "OrderFourthTableViewCell.h"
#import "OrderFifthTableViewCell.h"
#import "OrderSixTableViewCell.h"
#import "ZhifufirstTableViewCell.h"
#import "ZhifuSecondTableViewCell.h"
#import "ZhifuThirdTableViewCell.h"
#import "ZhifuFourthTableViewCell.h"


#import "HZTotalCell.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD.h"

#import "OrderDetailViewController.h"




@interface ZhifuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic) CGFloat totalPrice;
@property(nonatomic) UIButton *selectButton1;
@property(nonatomic) UIButton *selectButton2;
@property (nonatomic) UILabel *jifenlab;
@property (nonatomic) UILabel *pricelab;
@property(nonatomic)NSDictionary *dict;
@property (nonatomic)NSString *isUseIntegral;
@property (nonatomic)NSString* zhifuprice;

@property(nonatomic) CGFloat orderPrice;

@end

@implementation ZhifuViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.totalPrice = 0;
    
    for (int i = 0; i < self.projectArr.count; i++) {
        self.totalPrice = [[self.projectArr[i] objectForKey:@"price"] floatValue] + self.totalPrice;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/orderInfo",KCBaseURLString];
    NSDictionary *dict = @{@"orderId":self.zhifuid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]
    ;
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"%@",responseObject);
        NSDictionary *dict = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"INFO"];
        self.dict = dict;
        NSLog(@"affafafbbb%@",dict);
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"订单支付";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HZTotalCell class] forCellReuseIdentifier:@"HZTotalCell"];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -8;
    self.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.block();
}

- (void)backClick:(UIButton *)sender {
    NSLog(@"返回");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.projectArr.count;
    }
    if (section == 3) {
        return 2;
    }
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"CELL1";
        OrderFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[OrderFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *name = [self.dict objectForKey:@"name"];
        
        NSString *tel = [self.dict objectForKey:@"tel"];
        NSString *phone = nil;
        if (tel.length > 4) {
            NSString *toTel = [tel substringToIndex:4];
            phone = [NSString stringWithFormat:@"%@****", toTel];

        } else {
            phone = tel;
        }
        NSString *address = [[self.dict objectForKey:@"address_info"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        NSString *jiuname = [self.dict objectForKey:@"person_name"];
        NSString *jiusex = [self.dict objectForKey:@"person_sex"];
        NSString *jiuage = [self.dict objectForKey:@"person_age"];

        
        cell.contactlabel.text = [NSString stringWithFormat:@"联系人: %@(%@)", name, phone];
        cell.addresslabel.text = [NSString stringWithFormat:@"地址: %@", address];
        cell.jiuzhenlabel.text = [NSString stringWithFormat:@"就诊人: %@  %@  %@", jiuname, jiusex, jiuage];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *cellID = @"CELL2";
        ZhifufirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZhifufirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.headView sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [self.dict objectForKey:@"head"]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        NSString *nurse = [self.dict objectForKey:@"medic_name"];
        NSString *time = [self.dict objectForKey:@"appointment_time"];
        
        cell.yihulabel.text = [NSString stringWithFormat:@"医护: %@", nurse];
        cell.timelabel.text = [NSString stringWithFormat:@"预约上门时间: %@", time];
        return cell;
        
    }else if (indexPath.section == 2) {
        static NSString *cellID = @"CELL3";
        OrderThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[OrderThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = kRGBA(240, 240, 240, 240);
        }
        
        [cell.titleView sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [self.projectArr[indexPath.row] objectForKey:@"file"]].tzl_URL placeholderImage:[UIImage imageNamed:@"icon_default_pic"]];
        cell.introlabel.text = [self.projectArr[indexPath.row] objectForKey:@"desc"];
        cell.pricelabel1.text = [NSString stringWithFormat:@"¥%@", [self.projectArr[indexPath.row] objectForKey:@"price"]];
        cell.numberlabel.text = @"x1";
        cell.pricelabel2.text = [NSString stringWithFormat:@"¥%@", [self.projectArr[indexPath.row] objectForKey:@"price"]];

        return cell;
    } else if (indexPath.section == 3) {
        static NSString *cellID = @"CELL4";
        ZhifuSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (indexPath.row == 0) {
            HZTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZTotalCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.totalNumberLb.text = [NSString stringWithFormat:@"¥%.2f", self.totalPrice];
         return cell;
        } else {
            if (cell == nil) {
                cell = [[ZhifuSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            self.jifenlab = cell.jifenlabel;
            self.pricelab = cell.pricelabel;
            NSString *jifenstring = [[self.dict objectForKey:@"integral_reserve"] stringValue];
            NSString *ratestring = [[self.dict objectForKey:@"integral_conversion"] stringValue];
            CGFloat a = [jifenstring floatValue];
            CGFloat b = [ratestring floatValue];
            CGFloat c = a/b;
            NSString *pricestring = [NSString stringWithFormat:@"%0.2f",c];
            
            NSString *string1 = [NSString stringWithFormat:@"可用%@积分抵%@元",jifenstring,pricestring];
            NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:string1];
            [AttributedStr1 addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:14.0]
                                   range:NSMakeRange(2,jifenstring.length)];
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:0/255.0 green:178/255.0 blue:149/255.0 alpha:1.0]
                                   range:NSMakeRange(2,jifenstring.length)];
            
            
            [AttributedStr1 addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:14.0]
                                   range:NSMakeRange(5+jifenstring.length,pricestring.length)];
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:255/255.0 green:182/255.0 blue:73/255.0 alpha:1.0]
                                   range:NSMakeRange(5+jifenstring.length,pricestring.length)];
            
            cell.jifenlabel.attributedText = AttributedStr1;
            
            
            [cell.jifenswitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            _orderPrice  = self.totalPrice;
            
            NSString *daistring = [NSString stringWithFormat:@"%.2f",_orderPrice];
            NSLog(@"ddda%@",daistring);
            
            NSString *string2 = [NSString stringWithFormat:@"待支付:¥%.2f",_orderPrice];
            NSLog(@"ddddg%@",string2);
            
            
            NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:string2];
            [AttributedStr2 addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:14.0]
                                   range:NSMakeRange(4,daistring.length+1)];
            [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:54/255.0 green:136/255.0 blue:255/255.0 alpha:1.0]
                                   range:NSMakeRange(4,daistring.length+1)];
            cell.pricelabel.attributedText = AttributedStr2;
            
            self.isUseIntegral = @"0";
            self.zhifuprice = daistring;
            
            return cell;
        }
    }else if (indexPath.section == 4) {
        static NSString *cellID = @"CELL5";
        ZhifuThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZhifuThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.zhifuButton setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        [cell.zhifuButton setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateSelected];
        [cell.zhifuButton addTarget:self action:@selector(selectButtonclick1:) forControlEvents:UIControlEventTouchUpInside];
        self.selectButton1 = cell.zhifuButton;
        
        [cell.yueButton setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        [cell.yueButton setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateSelected];
        [cell.yueButton addTarget:self action:@selector(selectButtonclick2:) forControlEvents:UIControlEventTouchUpInside];
        cell.yueButton.selected = YES;
        
        NSString *yuestring = [self.dict objectForKey:@"cash_reserve"];
        NSString *yuestring2 = [NSString stringWithFormat:@"余额（可用余额¥%@）",yuestring];
        
        NSMutableAttributedString *AttributedStr3 = [[NSMutableAttributedString alloc]initWithString:yuestring2];
        [AttributedStr3 addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:14.0]
                               range:NSMakeRange(7,yuestring.length+1)];
        [AttributedStr3 addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:20/255.0 alpha:1.0]
                               range:NSMakeRange(7,yuestring.length+1)];
        
        cell.yuelabel.attributedText = AttributedStr3;

        self.selectButton2 = cell.yueButton;
        
        
        return cell;
    }else if (indexPath.section == 5) {
        
        static NSString *cellID = @"CELL6";
        ZhifuFourthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZhifuFourthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
          [cell.submitButton addTarget:self action:@selector(zhifuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)switchAction:(id)sender {
    
    NSString *jifenstring = [[self.dict objectForKey:@"integral_reserve"] stringValue];
    NSString *ratestring = [[self.dict objectForKey:@"integral_conversion"] stringValue];
    CGFloat a = [jifenstring floatValue];
    CGFloat b = [ratestring floatValue];
    CGFloat c = a/b;
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        _orderPrice = self.totalPrice - c;
        
        if (_orderPrice <= 0) {
            _orderPrice = 0.00;
        }
        
        NSString *daistring = [NSString stringWithFormat:@"%.2f",_orderPrice];
        NSString *string2 = [NSString stringWithFormat:@"待支付:¥%.2f",_orderPrice];

        
        NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:string2];
        [AttributedStr2 addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:14.0]
                               range:NSMakeRange(4,daistring.length+1)];
        [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithRed:54/255.0 green:136/255.0 blue:255/255.0 alpha:1.0]
                               range:NSMakeRange(4,daistring.length+1)];
        self.pricelab.attributedText = AttributedStr2;
    
        self.isUseIntegral = @"1";
        self.zhifuprice = daistring;
      
    }else {
        _orderPrice  = self.totalPrice;
        NSString *daistring = [NSString stringWithFormat:@"%.2f",_orderPrice];
        NSString *string2 = [NSString stringWithFormat:@"待支付:¥%.2f",_orderPrice];
       
        NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:string2];
        [AttributedStr2 addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:14.0]
                               range:NSMakeRange(4,daistring.length+1)];
        [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithRed:54/255.0 green:136/255.0 blue:255/255.0 alpha:1.0]
                               range:NSMakeRange(4,daistring.length+1)];
        self.pricelab.attributedText = AttributedStr2;
        self.zhifuprice = daistring;
        
        self.isUseIntegral = @"0";
    
    }
    
}

- (void)selectButtonclick1:(UIButton*)selectButton1 {
    selectButton1.selected = !selectButton1.selected;
    if (selectButton1.selected == YES) {
       _selectButton2.selected = NO;
    } else {
        
    }
    
}
- (void)selectButtonclick2:(UIButton*)selectButton2 {
    selectButton2.selected = !selectButton2.selected;
    if (selectButton2.selected == YES) {
        
        _selectButton1.selected = NO;
    } else {
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 3) {
        return 10;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        return 64;
    } else if (indexPath.section == 2) {
        return 55;
        
    } else if (indexPath.section == 3) {
        if (indexPath.row) {
            return 80;
        } else {
            return 40;
        }
        
    } else if (indexPath.section == 4) {
        return 130;
    }
    return 65;
}
- (void)zhifuButtonClick {
    //支付宝支付
    if (self.selectButton1.selected == YES) {
        NSString *appID = @"2016110202479347";
        NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALwCnkPMEvOlZD+FTRd7vVfQP/6Raw68HYoMdwuqSdoqsIVPzukCDMCHrOd0a/R4FE2rz/NNCsQ8rcq2KS+vIbjo4Qg9Lj17nqtOPKt8kS7KfAOwaLUjXauGXr7/MiF73f9dHxPzP0QqzGD3DCjia9YIodpccureuM/6kMrtMUGTAgMBAAECgYBY+Yg6n45sfd4WbZhRP78YmrZeXCVlIMN9/G4uOBWhSMinHmDWRqEQUGUUWDVqyZUaOPA9vT0WJ307zL9rEJ+NGVyvIc382IkZcvHfIHOPnykOrVhpAjqOHNMVry40PyXYUqy4pbhadUarQYjyAJqwTKwhrTJDHK0r07VIg3dwSQJBAO3Y0NxIaQ1Yo6tlFJpLC9shZOrMGuzt2AvkZFBslb+OGXPycqs6DbvNxn9kWJdm+4076Er+aVOc2dlY5VHkEAcCQQDKXBC6mh47/X5BRsEu7p4yAAAGvFHinLFBANNJ+2zFjDLNLRkLVANFB6EC3fS2tl3Errw/ull0MY7lp/PMJkcVAkEA0OheUw160BEp+NIYrYj7Ceaj+CN8BtzFpXRes9EcGpsaOiAandCo3WrZTW167siybBPRbYVWR+193wzYpvv1IwJAF1V4ZFwDIn2/gj1rZ0MCoNdZKW2rr4rL8afrtTs1tq3M6dXKboD4g4w2p8L6RdtPgq93a43MZNaWGKs+NIsxZQJAAOJfR6cNXzjPd7N9qMdlwcK0KPxQVAkpPhj+mNyxJcAz5tZNKU+goQxQu41vdN3kD+DAiC01tIoo59jaKh2UVw==";
        /*============================================================================*/
        /*============================================================================*/
        /*============================================================================*/
        //partner和seller获取失败,提示
        if ([appID length] == 0 ||
            [privateKey length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"缺少appId或者私钥。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
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
        order.biz_content.body = @"订单支付";
        order.biz_content.subject = @"订单支付";
        
        
        NSString *zhifucode = [self.dict objectForKey:@"order_code"];
        order.biz_content.out_trade_no = zhifucode; //订单ID（由商家自行制定）
        
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", _orderPrice]; //商品价格
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
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     orderInfoEncoded, signedString];
            
            
            kAppdelegate.alipayType = TZLAlipayTypeOrderMode;
            
            NSDictionary *dict = @{@"orderId":self.zhifuid,@"address":self.gpsaddress,@"addressXY":self.addressxy,@"isUseIntegral":self.isUseIntegral};
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *paramters = @{@"data":myString};
            kAppdelegate.orderDic = paramters;
            
            
            
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"aaffaf %@",resultDic);
                
                int status = [[resultDic objectForKey:@"resultStatus"] intValue];
                NSLog(@"dafaf%d",status);
                
                if (status == 9000) {
                    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/aliPay",KCBaseURLString];
                    NSDictionary *dict = @{@"orderId":self.zhifuid,@"address":self.gpsaddress,@"addressXY":self.addressxy,@"isUseIntegral":self.isUseIntegral};
                    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    // NSString *string = [NSString stringWithFormat:@"%@", paramters];
                    NSDictionary *paramters = @{@"data":myString};
                    
                    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
                    [mannager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                   
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"%@",responseObject);
                        
                        NSString *string = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"gggg%@",string);
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                    }];
                }
            }];
        }
    }
    //余额支付
    if (self.selectButton2.selected == YES) {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定使用余额支付吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *makeAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
            NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/balancePay",KCBaseURLString];
            NSDictionary *dict = @{@"orderId":self.zhifuid,@"address":self.gpsaddress,@"addressXY":self.addressxy,@"isUseIntegral":self.isUseIntegral};
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            // NSString *string = [NSString stringWithFormat:@"%@", paramters];
            NSDictionary *paramters = @{@"data":myString};
            
            AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
            [mannager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                NSString *string = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [MBProgressHUD showToast:string];
                
                if ([[responseObject objectForKey:@"STATE"] integerValue] == 1) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }
  
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        [alert addAction:makeAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
      
    }
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
