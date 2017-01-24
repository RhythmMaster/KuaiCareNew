//
//  YihuIntroduceViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YihuIntroduceViewController.h"
#import "PingjiaViewController.h"
#import "YihuFirstTableViewCell.h"
#import "YihuSecondTableViewCell.h"
#import "YihuThirdTableViewCell.h"
@interface YihuIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation YihuIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"医护介绍";
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 100, 40);
    [button addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确定医护" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;

    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem withBarItem:@"back_btn_normal" name:@"" target:self action:@selector(leftClick)];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 5;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *cellID = @"CELL1";
        YihuFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (self) {
            cell = [[YihuFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *cellID = @"CELL2";
        YihuSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (self) {
            cell = [[YihuSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        return cell;

    }else if (indexPath.section == 2)
    {
        static NSString *cellID = @"CELL3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (self) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"用户评价（6）";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
    }else if (indexPath.section == 3)
    {
        static NSString *cellID = @"CELL4";
        YihuThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (self) {
            cell = [[YihuThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        PingjiaViewController *pingjiaVC = [[PingjiaViewController alloc] init];
        [self.navigationController pushViewController:pingjiaVC animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return 10;
    }
    
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 95;
    }else if (indexPath.section == 1)
    {
        return 160;
    }else if (indexPath.section == 2)
    {
        return 44;
    }
    return 90;
    
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
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
