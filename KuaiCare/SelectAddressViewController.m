//
//  SelectAddressViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "EditViewController.h"
#import "EditChangeAddressViewController.h"
#import "SelectAddressTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
@interface SelectAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,strong)NSMutableArray *array;
@end

@implementation SelectAddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
 //   [MBProgressHUD showMessage:Net_Connecting];

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddresslist",KCBaseURLString];
    self.page = @"1";
    NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.array = [[NSMutableArray alloc] init];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"无消息"]) {
            [self initUI];
        }
        if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"成功"]) {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectZero  style:UITableViewStyleGrouped];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            [self.view addSubview:self.tableView];
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.offset(0);
            }];
            self.array =  [NSMutableArray arrayWithArray:[responseObject  objectForKey:@"CONTENT"]];
            
            [self.tableView reloadData];
            
            
            UITableView * weakBaseTableView = self.tableView;
            
            weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _page = @"1";
                NSLog(@"222%@",self.array);
                [self.array removeAllObjects];
                NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
                [self postActionWith:dict];
                
                
            }];
            weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                int i = [self.page intValue];
                i = i + 1;
                _page = [NSString stringWithFormat:@"%d",i];
                NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
                [self postActionWith:dict];
                
            }];
            [self.tableView.mj_header beginRefreshing];
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"常用地址";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"" name:@"添加" target:self action:@selector(rightClick)];
    
    //  [self.tableView headerBeginRefreshing ];
    
}
- (void)postActionWith:(NSDictionary *)dic {
    
    //加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddresslist",KCBaseURLString];
    [mannager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        mutableArray = [responseObject objectForKey:@"CONTENT"];
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
      
        
        
        if (self.array.count ==0||self.array ==nil) {
            self.array = [NSMutableArray arrayWithArray:[responseObject  objectForKey:@"CONTENT"]];
            
        }else if (self.array.count <=Allcount){
            [self.array addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}

-(void)initUI
{
    UIButton *headButton = [[UIButton alloc] init];
    [headButton setBackgroundImage:[UIImage imageNamed:@"icon_l_none_address"] forState:UIControlStateNormal];
    [self.view addSubview:headButton];
    UILabel *messagelabel = [[UILabel alloc] init];
    messagelabel.textAlignment = NSTextAlignmentCenter;
    messagelabel.text = @"当前没有任何就诊人信息";
    messagelabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:messagelabel];
    UIButton *jiuzhenButton = [[UIButton alloc] init];
    [jiuzhenButton setBackgroundColor:RGB(38, 107, 255)];
    [jiuzhenButton setTitle:@"添加就诊人" forState:UIControlStateNormal];
    [jiuzhenButton addTarget:self action:@selector(jiuzhenClick) forControlEvents:UIControlEventTouchUpInside];
    jiuzhenButton.layer.cornerRadius = 20;
    jiuzhenButton.layer.masksToBounds = YES;
    [self.view addSubview:jiuzhenButton];
    
    [headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.offset(114);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.25);
    }];
    [messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headButton.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.1);
    }];
    [jiuzhenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messagelabel.mas_bottom).offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.4);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.15);
    }];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    SelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[SelectAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.selectButton setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
    [cell.selectButton setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateSelected];
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectButton.tag = indexPath.section +1;
    [cell.selectButton setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [cell.selectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.selectButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cell.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *is_default = [[self.array objectAtIndex:indexPath.section] objectForKey:@"is_default"];
    NSLog(@"2222%@",is_default);
    if ([is_default isEqualToString:@"0"]) {
        cell.selectButton.selected = NO;
    }else
    {
        cell.selectButton.selected = YES;
    }
    
    [cell.editButton setImage:[UIImage imageNamed:@"editor"] forState:UIControlStateNormal];
    [cell.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [cell.editButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    cell.editButton.tag = indexPath.section+1;
    [cell.editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cell.editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [cell.removeButton setImage:[UIImage imageNamed:@"delector"] forState:UIControlStateNormal];
    [cell.removeButton setTitle:@"删除" forState:UIControlStateNormal];
    [cell.removeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    cell.removeButton.tag = indexPath.section+1;
    [cell.removeButton addTarget:self action:@selector(removeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.removeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cell.removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.namelabel.text  = [[self.array objectAtIndex:indexPath.section] objectForKey:@"name"];
    cell.phonelabel.text = [[self.array objectAtIndex:indexPath.section] objectForKey:@"tel"];
    cell.addresslabel.text = [[self.array objectAtIndex:indexPath.section] objectForKey:@"address_info"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *str = [[self.array objectAtIndex:indexPath.section] objectForKey:@"address_info"];
    NSString *str2 = [NSString stringWithString:[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *str3 = [[self.array objectAtIndex:indexPath.section] objectForKey:@"tel"];
    NSString *str4 = [[self.array objectAtIndex:indexPath.section] objectForKey:@"name"];
    if (!self.isCenterVC) {
        self.block1(str);
        self.block2(str2);
        self.block3(str3);
        self.block4(str4);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSString *editID = [[self.array  objectAtIndex:indexPath.section] objectForKey:@"id"];
        self.hidesBottomBarWhenPushed = YES;
        EditChangeAddressViewController *editchangeVC  = [[EditChangeAddressViewController alloc] init];
        editchangeVC.editID = editID;
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:editchangeVC animated:YES];
    }
    
    
    
    
}
- (void)selectButtonClick:(UIButton*)selectButton {
    //[MBProgressHUD showMessage:Net_Connecting];

    NSString *personID =[[self.array  objectAtIndex:selectButton.tag-1] objectForKey:@"id"];
    selectButton.selected = !selectButton.selected;
    if (selectButton.selected == YES) {
        NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/seedoctorpersondefault",KCBaseURLString];
        NSDictionary *dict = @{@"id":personID};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
           // [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
    }else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)rightClick {
    self.hidesBottomBarWhenPushed = YES;
    EditViewController *editVC = [[EditViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
    
    
}
- (void)removeButtonClick:(UIButton*)removeButton {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showMessage:Net_Connecting];
        
        NSString *removeID = [[self.array  objectAtIndex:removeButton.tag-1] objectForKey:@"id"];
        NSDictionary *paramters = @{@"id":removeID};
        NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddressdelete",KCBaseURLString];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            [self remove];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:sureAction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
    

}
- (void)remove {
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddresslist",KCBaseURLString];
    
    NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        
        [self.array removeAllObjects];
        if (![[responseObject  objectForKey:@"MSG"] isEqualToString:@"无消息"]) {
            [self.array addObjectsFromArray:(NSArray*)[responseObject  objectForKey:@"CONTENT"]] ;
        }
        [self.tableView reloadData];
        if ([[responseObject  objectForKey:@"MSG"] isEqualToString:@"无消息"])
        {
            [self.tableView removeFromSuperview];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}
//点击了编辑按钮
-(void)editButtonClick:(UIButton*)editButton
{
    NSString *editID = [[self.array objectAtIndex:editButton.tag-1] objectForKey:@"id"];
    self.hidesBottomBarWhenPushed = YES;
    EditChangeAddressViewController *addressVC = [[EditChangeAddressViewController alloc] init];
    addressVC.editID = editID;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:addressVC animated:YES];
    
    
    
}
-(void)jiuzhenClick
{
    
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
