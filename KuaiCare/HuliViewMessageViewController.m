//
//  HuliViewMessageViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/18.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliViewMessageViewController.h"
#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
@interface HuliViewMessageViewController ()
@property (nonatomic ,strong)UILabel *messagelabel;
@property (nonatomic ,copy)NSString *messageString;
@property (nonatomic ,assign)CGFloat height;
@end

@implementation HuliViewMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *urlString = [NSString stringWithFormat:@"%@/app/common/viewMsg",KCBaseURLString];
    NSDictionary *paramters = @{@"id":self.messageID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
       // [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

        self.messageString = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"msg_content"];
        self.messagelabel.text = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"msg_content"];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"消息内容";
   
    [self initUI];
    
    
    
}
-(void)initUI
{
    self.messagelabel = [[UILabel alloc] init];
    [self.view addSubview:self.messagelabel];
    [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(10);
        make.right.equalTo(-10);
    }];
    self.messagelabel.numberOfLines = 0;
    self.messagelabel.font = [UIFont systemFontOfSize:16];
  
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
