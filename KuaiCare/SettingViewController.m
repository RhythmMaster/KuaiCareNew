//
//  SettingViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"

#import "HZWMChangePasswordViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,strong)NSArray *nameArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"更多";

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KCWIDTH, KCHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.nameArray = [NSArray arrayWithObjects:@"修改密码",@"服务条款", @"版本中心",nil];
    self.imageArray = [NSArray arrayWithObjects:@"xiugaimima",@"service",@"banben", nil];
    UIButton *signoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signoutButton.backgroundColor = [UIColor whiteColor];
    signoutButton.frame = CGRectMake(0, KCHEIGHT-200, KCWIDTH, 40);
    [signoutButton setTitle:@"退出当前帐户" forState:UIControlStateNormal];
    [signoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [signoutButton addTarget:self action:@selector(signoutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:signoutButton];
    
    
}
-(void)signoutClick {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出该账号" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [MBProgressHUD showMessage:Net_Connecting];
        NSString *urlString = [NSString stringWithFormat:@"%@/app/common/loginOut",KCBaseURLString];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
              [MBProgressHUD hideHUD];
              [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"已退出"]) {
                kAppdelegate.haveLogin = NO;
                self.hidesBottomBarWhenPushed = YES;
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:tureAction];
  
    [self presentViewController:alertViewController animated:YES completion:nil];
 
}
-(void)leftClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        HZWMChangePasswordViewController *changePasswordVC = [HZWMChangePasswordViewController new];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
