//
//  YuerDetailViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuerDetailViewController.h"
#import "YuerDetailTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"


#import "HZMyCashchangeViewModel.h"

@interface YuerDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,strong)NSMutableArray *array;
@property(nonatomic) HZMyCashchangeViewModel *myCashchangeVM;

@end

@implementation YuerDetailViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"余额明细";

    [self creatTableView];
    
    
    
    
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.myCashchangeVM getMyCashChangeWithVMRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            [_tableView reloadData];
        }];
        
        [_tableView.mj_header endRefreshing];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.myCashchangeVM getMyCashChangeWithVMRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
            
            [_tableView reloadData];
        }];
        if (!_myCashchangeVM.myCashChangeModel.content.count) {
            [self.view showWarning:@"没有更多消息了"];
        }
        [_tableView.mj_footer endRefreshing];
        
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    

}
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    
    
    
}

- (void)leftClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.myCashchangeVM.numberOfRow;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cell";
    YuerDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[YuerDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.namelabel.text = [self.myCashchangeVM getChangeTypeWithIndex:indexPath.row];
    cell.yuelabel.text =  [NSString stringWithFormat:@"余额: ¥%@", [self.myCashchangeVM getCashReserveWithIndex:indexPath.row]];
    cell.pricelabel.text = [self.myCashchangeVM getRealityMoneyWithIndex:indexPath.row];
    cell.timelabel.text = [self.myCashchangeVM getCreateDateWithIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark lazy 
- (HZMyCashchangeViewModel *)myCashchangeVM {
    if (!_myCashchangeVM) {
        _myCashchangeVM = [HZMyCashchangeViewModel new];
    }
    return _myCashchangeVM;
}


@end
