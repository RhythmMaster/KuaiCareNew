//
//  MainWeiViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/28.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MainWeiViewController.h"
#import "SDCycleScrollView.h"
#import "WeiyuFirstTableViewCell.h"
#import "WeiyuSecondTableViewCell.h"
#import "WeiyuThirdTableViewCell.h"
#import "ChooseCityViewController.h"
#import "MainWeiPromotViewController.h"
#import "CustomBtn2.h"
#import "LoginViewController.h"
#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"


#import "HZIndexViewModel.h"

#import "HuliViewController.h"



@interface MainWeiViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate, GYZChooseCityDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,assign)CGFloat height;
@property (nonatomic ,strong)NSDictionary *dict;

@property(nonatomic) UIButton *button;

@property(nonatomic) HZIndexViewModel *indexVM;

@end

@implementation MainWeiViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"快护理";
    _button = [[CustomBtn2 alloc] init];
    [_button addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    _button.frame = CGRectMake(0, 0, 100, 50);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *city = [ud objectForKey:@"citys"];
    [_button setTitle:city forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"message_title" name:@"" target:self action:@selector(rightClick)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self loadCycleScrollView];
    [self getWeiduMessage];
    
    
    [self.indexVM getIndexModelWithCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            
            kAppdelegate.loginState = 1;
            [_tableView reloadData];
        }
    }];
    
}
-(void)loadCycleScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *imageNames = @[@"pic_show",
                            @"pic_show2",
                            @"pic_show3",
                            @"pic_show4",
                            // 本地图片请填写全名
                            ];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KCWIDTH, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.tableView.tableHeaderView = cycleScrollView;//把滑动视图当作表头
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"CELL1";
        WeiyuFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[WeiyuFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.priclabel.text = [NSString stringWithFormat:@"¥%@", self.indexVM.indexModel.servicePrice];
        cell.namelabel.text = self.indexVM.indexModel.name;
        cell.introlabel.text = self.indexVM.indexModel.desc;
        [cell.orderButton addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else if (indexPath.section == 1)
    {
        static NSString *cellID = @"CELL1";
        WeiyuSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[WeiyuSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.timelabel.text = [NSString stringWithFormat:@"理疗时间: %@", self.indexVM.indexModel.theranyTime];
        cell.fuhulabel.text = [NSString stringWithFormat:@"服务内容: %@", self.indexVM.indexModel.serviceContent];
        cell.shoufalabel.text = [NSString stringWithFormat:@"护理手法: %@", self.indexVM.indexModel.name];
        
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *cellID = @"CELL2";
        WeiyuThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[WeiyuThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                   }
        cell.messagelabel.text = [NSString stringWithFormat:@"%@", self.indexVM.indexModel.userNotice];
        CGFloat height = [Utils getTextHeightWithFont:cell.messagelabel.text withWidth:KCWIDTH-10 withFont:[UIFont systemFontOfSize:14]];
        self.height = height;
        return cell;
    }
    
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = @"下单提示";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 185;
    }else if (indexPath.section == 1)
    {
        return 150;
    }else if (indexPath.section == 2)
    {
        return self.height + 80;
    }
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        self.hidesBottomBarWhenPushed = YES;
        MainWeiPromotViewController *promotVC = [[MainWeiPromotViewController alloc] init];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        [self.navigationController pushViewController:promotVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    
}


#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city {
    [_button setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController {
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)getWeiduMessage
{
    
    
    
    
}
- (void)orderButtonClick {

            self.hidesBottomBarWhenPushed = YES;
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
//    self.hidesBottomBarWhenPushed = YES;
//    HuliViewController *huliVC = [HuliViewController new];
//    [self.navigationController pushViewController:huliVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
    
    

}
-(void)leftClick {
    self.hidesBottomBarWhenPushed = YES;
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)rightClick {
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (HZIndexViewModel *)indexVM {
    if (!_indexVM) {
        _indexVM = [HZIndexViewModel new];
    }
    return _indexVM;
}

@end
