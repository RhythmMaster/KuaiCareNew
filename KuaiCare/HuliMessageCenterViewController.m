//
//  HuliMessageCenterViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/10.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliMessageCenterViewController.h"
#import "HuliViewMessageViewController.h"
#import "HuliMessageCenterTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"


#import "HZMsgViewModel.h"



@interface HuliMessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,strong)NSMutableArray *array;



@end

@implementation HuliMessageCenterViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *url = [NSString stringWithFormat:@"%@/app/common/myMsg",KCBaseURLString];
    self.page = @"1";
    NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.array = [[NSMutableArray alloc] init];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
       // [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

        NSLog(@"%@",responseObject);
        self.array =  [NSMutableArray arrayWithArray:[responseObject  objectForKey:@"CONTENT"]];
        [self.tableView reloadData];
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"消息中心";
    
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.bottom.equalTo(0);
    }];
    UITableView * weakBaseTableView = self.tableView;
    
    weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = @"1";
        NSLog(@"222%@",self.array);
        [self.array removeAllObjects];
        NSDictionary *dict = @{@"page":_page,@"rows":@"10"};
        [self postActionWith:dict];
        
        
    }];
    weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        int i = [self.page intValue];
        i = i + 1;
        _page = [NSString stringWithFormat:@"%d",i];
        NSDictionary *dict = @{@"page":_page,@"rows":@"10"};
        [self postActionWith:dict];
        
    }];
    [self.tableView.mj_header beginRefreshing];

    
}
- (void)postActionWith:(NSDictionary *)dic {
    
    //加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/app/common/myMsg",KCBaseURLString];
    [mannager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        mutableArray = [responseObject objectForKey:@"CONTENT"];
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
        // if ([[responseObject objectForKey:@"CONTENT"] isKindOfClass:[NSMutableArray class]]) {
        
        
        if (self.array.count ==0||self.array ==nil) {
            self.array = [NSMutableArray arrayWithArray:[responseObject  objectForKey:@"CONTENT"]];
            
        }else if (self.array.count <=Allcount){
            [self.array addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
        //  }
        //        [MBProgressHUD showToast:[dic objectForKey:@"info"]];//提示获取信息成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    HuliMessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HuliMessageCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.titlelabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"msg_type_name"];
    cell.messagelabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"msg_content"];
    cell.timelabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"create_time"];
    
    if ([[[self.array objectAtIndex:indexPath.row] objectForKey:@"is_read"] isEqualToString:@"1"]) {
        cell.dianView.image = [UIImage imageNamed:@""];
    }else
    {
        cell.dianView.image = [UIImage imageNamed:@"tishipao"];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *messageID = [[self.array objectAtIndex:indexPath.row] objectForKey:@"id"];
    self.hidesBottomBarWhenPushed = YES;
    HuliViewMessageViewController *viewVC = [[HuliViewMessageViewController alloc] init];
    viewVC.messageID = messageID;
    [self.navigationController pushViewController:viewVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)leftClick {
    
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
