//
//  JifenGuizeViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/17.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "JifenGuizeViewController.h"
#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
@interface JifenGuizeViewController ()
@property (nonatomic ,strong)UILabel *messagelabel;
@property (nonatomic ,copy)NSString *messageString;
@property (nonatomic ,assign)CGFloat height;
@end

@implementation JifenGuizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD showMessage:Net_Connecting];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"积分规则";
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/integrationRule",KCBaseURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

        self.messagelabel.text = [responseObject objectForKey:@"CONTENT"];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (UILabel *)messagelabel {
    if (!_messagelabel) {
        _messagelabel = [UILabel new];
        [self.view addSubview:_messagelabel];
        [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(10);
            make.right.equalTo(-10);
        }];
        _messagelabel.numberOfLines = 0;
        _messagelabel.font = [UIFont systemFontOfSize:16];
    }
    return _messagelabel;
}

-(void)leftClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
