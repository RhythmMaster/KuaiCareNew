//
//  MainWeiPromotViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/12/6.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MainWeiPromotViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MainWeiPromotTableViewCell.h"
#import "Utils.h"
#import "UIBarButtonItem+KCBarButtonItem.h"
@interface MainWeiPromotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSString *intro;
@property (nonatomic )CGFloat height;
@end

@implementation MainWeiPromotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    self.navigationItem.title = @"下单提示";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    
    
    [MBProgressHUD showMessage:Net_Connecting];
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/orderInformation",KCBaseURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",responseObject);
        self.intro = [responseObject objectForKey:@"CONTENT"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    MainWeiPromotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell= [[MainWeiPromotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.introlab.text = self.intro;
    self.height = [Utils getTextHeightWithFont:cell.introlab.text withWidth:KCWIDTH-30 withFont:[UIFont systemFontOfSize:14]];
    NSLog(@"%f",self.height);
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.height+20;
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
