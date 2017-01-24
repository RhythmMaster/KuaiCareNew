//
//  SelectdoctorViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SelectdoctorViewController.h"
#import "PYSearchViewController.h"
#import "YihuIntroduceViewController.h"
#import "SelectdoctorTableViewCell.h"
#import "AppDelegate.h"
#import "CustomBtn.h"
#import "CustomTableViewCell.h"
#import "CellBtn.h"
#import "UIView+Frame.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "North.h"
#import "South.h"

#import "HZHealthCareViewModel.h"

#import "HZMedicDisplayViewController.h"


@interface SelectdoctorViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UITextFieldDelegate>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UISearchController *searchVC;
@property (nonatomic ,strong)NSMutableArray *dataArr1;
@property (nonatomic ,strong)NSMutableArray *dataArr2;
@property (nonatomic ,strong)NSMutableArray *searchArr;
@property (nonatomic ,strong)UITextField *textfield;


@property(nonatomic) UIView *selectView;
@property(nonatomic) UIButton *sortBtn;
@property(nonatomic) UIButton *filtrateBtn;
@property(nonatomic) UIView *sortView;
@property(nonatomic) UIView *filtrateView;

@property(nonatomic) HZHealthCareViewModel *healthCareVM;
@end

@implementation SelectdoctorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.datetimestr);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(60);
        make.right.left.bottom.equalTo(0);
    }];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
   
    [self.healthCareVM getHealtherWithTime:self.datetimestr name:@"" completonHandler:^(NSError *error) {
        if (!error) {
 
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *itemview = [[UIView alloc] init];
    itemview.frame =CGRectMake(10, 20, KCWIDTH-60, 30);
    self.navigationItem.titleView = itemview;
    
    UIImageView *itemimage = [[UIImageView alloc] init];
    itemimage.contentMode = UIViewContentModeScaleAspectFit;
    itemimage.image = [UIImage imageNamed:@"icon_l_serch_bg"];
    [itemview addSubview:itemimage];
    [itemimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    UIButton *searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"icon_l_serch_logo"] forState:UIControlStateNormal];
    [itemview addSubview:searchbtn];
    [searchbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(itemimage.mas_centerY);
        make.height.equalTo(18);
        make.width.equalTo(18);
    }];
    
    self.textfield = [[UITextField alloc] init];
    self.textfield.delegate = self;
    self.textfield.returnKeyType = UIReturnKeySearch;
    [itemview addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchbtn.mas_right).offset(5);
        make.right.equalTo(0);
        make.centerY.equalTo(itemimage.mas_centerY);
        make.height.equalTo(20);
    }];

    [self tableView];
    [self sortBtn];
    [self filtrateBtn];
    
    
}


-(void)leftClick {
   
    YihuIntroduceViewController *yihuVC = [[YihuIntroduceViewController alloc] init];
    [self.navigationController pushViewController:yihuVC animated:YES];
    
}
#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //return self.dataArr1.count;
        NSLog(@"111111%ld", self.healthCareVM.northNumberOfRow);
        return self.healthCareVM.northNumberOfRow;
        
    } else {
        //return self.dataArr2.count;
        NSLog(@"111111%ld", self.healthCareVM.southNumberOfRow);
        return self.healthCareVM.southNumberOfRow;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellid = @"cell";
        SelectdoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell = nil;
        if (cell == nil) {
            cell = [[SelectdoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell.headbtn sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [self.healthCareVM getNorthHeadWithIndex:indexPath.row]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        cell.starRatingView.value = [self.healthCareVM getNorthScoreWithIndex:indexPath.row].floatValue;
        cell.namelab.text = [self.healthCareVM getNorthNameWithIndex:indexPath.row];
        cell.agelab.text = [NSString stringWithFormat:@"%@:%ld岁",[self.healthCareVM getNorthSexWithIndex:indexPath.row],[self.healthCareVM getNorthAgeWithIndex:indexPath.row]];
        cell.numlab.text = [NSString stringWithFormat:@"服务%@次",[self.healthCareVM getNorthCountWithIndex:indexPath.row]];
        cell.hospitalab.text = @"";
        [cell.selectbtn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectbtn.tag = indexPath.row +100;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *cellid = @"cell";
        SelectdoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell = nil;
        if (cell == nil) {
            cell = [[SelectdoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell.headbtn sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [self.healthCareVM getSouthHeadWithIndex:indexPath.row]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        cell.starRatingView.value = [self.healthCareVM getSouthScoreWithIndex:indexPath.row].floatValue;
        cell.namelab.text = [self.healthCareVM getSouthNameWithIndex:indexPath.row];
        cell.agelab.text = [NSString stringWithFormat:@"%@:%ld岁",[self.healthCareVM getSouthSexWithIndex:indexPath.row],[self.healthCareVM getSouthAgeWithIndex:indexPath.row]];
        cell.numlab.text = [NSString stringWithFormat:@"服务%@次",[self.healthCareVM getSouthCountWithIndex:indexPath.row]];
        cell.hospitalab.text = @"";
        [cell.selectbtn addTarget:self action:@selector(daySelectbtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectbtn.tag = indexPath.row +1111;
        return cell;
    }
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return cell;
}
-(void)selectbtn:(UIButton*)selectbtn {
    NSString *nameStr = nil;
    NSString *hospitalStr = nil;
    if ([self.healthCareVM getNorthNameWithIndex:selectbtn.tag - 100].length == 0) {
        nameStr = @"暂无";
    } else {
    nameStr = [self.healthCareVM getNorthNameWithIndex:selectbtn.tag - 100];
    }
    if ([self.healthCareVM getNorthHospitalWithIndex:selectbtn.tag - 100].length == 0) {
        hospitalStr = @"暂无";
    } else {
    hospitalStr = [self.healthCareVM getNorthHospitalWithIndex:selectbtn.tag - 100];
    }
    
    NSString *str1 = [NSString stringWithFormat:@"%@(%@)",nameStr, hospitalStr];
    NSString *str2 = [self.healthCareVM getNorthIDWithIndex:selectbtn.tag - 100];
    NSString *str3 = [self.healthCareVM getNorthNameWithIndex:selectbtn.tag - 100];
    NSString *str4 = [self.healthCareVM getNorthPhoneWithIndex:selectbtn.tag - 100];
    
     self.block1(str1);
     self.block2(str2);
     self.block3(str3);
     self.block4(str4);
 
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)daySelectbtn:(UIButton *)selectbtn {
    
    NSString *nameStr = nil;
    NSString *hospitalStr = nil;
    if ([self.healthCareVM getSouthNameWithIndex:selectbtn.tag - +1111].length == 0) {
        nameStr = @"暂无";
    } else {
        nameStr = [self.healthCareVM getSouthNameWithIndex:selectbtn.tag - +1111];
    }
    if ([self.healthCareVM getSouthHospitalWithIndex:selectbtn.tag - +1111].length == 0) {
        hospitalStr = @"暂无";
    } else {
        hospitalStr = [self.healthCareVM getSouthHospitalWithIndex:selectbtn.tag - +1111];
    }
    
    NSString *str1 = [NSString stringWithFormat:@"%@(%@)",nameStr, hospitalStr];
    NSString *str2 = [self.healthCareVM getSouthIDWithIndex:selectbtn.tag - +1111];
    NSString *str3 = [self.healthCareVM getSouthNameWithIndex:selectbtn.tag - +1111];
    NSString *str4 = [self.healthCareVM getSouthPhoneWithIndex:selectbtn.tag - +1111];
    
    self.block1(str1);
    self.block2(str2);
    self.block3(str3);
    self.block4(str4);
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view1 = [self creatFootView];
        return view1;
        
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    HZMedicDisplayViewController *medicDisplayVC = [HZMedicDisplayViewController new];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    if (indexPath.section) {
        medicDisplayVC.medicId = [self.healthCareVM getSouthIDWithIndex:indexPath.row];
    } else {
        medicDisplayVC.medicId = [self.healthCareVM getNorthIDWithIndex:indexPath.row];
    }
    
    [self.navigationController pushViewController:medicDisplayVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
}



- (UIView*)creatFootView {
    UIView *view1 = [UIView new];
    UILabel *textlab = [[UILabel alloc] init];
    textlab.frame = CGRectMake(10, 10, KCWIDTH*0.7, 30);
    textlab.text = @"当日有时间";
    textlab.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:textlab];
    return view1;
}
#pragma mark delete search
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searhStr = [self.searchVC.searchBar text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searhStr];
    if (self.searchArr!= nil) {
        [self.searchArr removeAllObjects];
    }
    //过滤数据
    self.searchArr= [NSMutableArray arrayWithArray:[_dataArr1 filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark lazy

- (UISearchController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchVC.searchResultsUpdater = self;
        
        _searchVC.dimsBackgroundDuringPresentation = NO;
        
        _searchVC.hidesNavigationBarDuringPresentation = NO;
        
        _searchVC.searchBar.frame = CGRectMake(10, 8, self.view.width - 30, 50.0);
        self.navigationItem.titleView = _searchVC.searchBar;
    }
    return _searchVC;
}
- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [UIView new];
        [self.view addSubview:_selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(50);
        }];
        UIView *lineView = [UIView new];
        [_selectView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.bottom.equalTo(-5);
            make.width.equalTo(1);
            make.centerX.equalTo(0);
        }];
        lineView.backgroundColor = kGrayColor;
     
    }
    return _selectView;
}

- (UIView *)sortView {
    if (!_sortView) {
        _sortView = [UIView new];
        [self.selectView addSubview:_sortView];
        [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(self.view.width * 0.5);
        }];
    }
    return _sortView;
}
- (UIView *)filtrateView {
    if (!_filtrateView) {
        _filtrateView = [UIView new];
        [self.selectView addSubview:_filtrateView];
        [_filtrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(0);
            make.left.equalTo(self.sortView.mas_right);
        }];
    }
    return _filtrateView;
}

- (UIButton *)sortBtn {
    if (!_sortBtn) {
        _sortBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sortView addSubview:_sortBtn];
        [_sortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        [_sortBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    }
    return _sortBtn;
}
- (UIButton *)filtrateBtn {
    if (!_filtrateBtn) {
        _filtrateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.filtrateView addSubview:_filtrateBtn];
        [_filtrateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        [_filtrateBtn setTitle:@"筛选" forState:UIControlStateNormal];
    }
    return _filtrateBtn;
}

- (HZHealthCareViewModel *)healthCareVM {
    if (!_healthCareVM) {
        _healthCareVM = [HZHealthCareViewModel new];
    }
    return _healthCareVM;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textfield resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textfield resignFirstResponder];
    
    
    [self.healthCareVM getHealtherWithTime:self.datetimestr name:textField.text completonHandler:^(NSError *error) {
        if (!error) {
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    return YES;
    
    
}

@end
