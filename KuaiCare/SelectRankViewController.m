//
//  SelectRankViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SelectRankViewController.h"
#import "RankTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
@interface SelectRankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,strong)NSArray *dataArray;


@end

@implementation SelectRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"选择等级";
    [MBProgressHUD showMessage:Net_Connecting];
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/itemClassify",KCBaseURLString];
    NSDictionary *paramters = @{@"itemId":self.rowID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",responseObject);
        
        self.dataArray = [responseObject objectForKey:@"CONTENT"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    
    
    self.imageArray = [NSArray arrayWithObjects:@"icon_severitylevel1",@"icon_severitylevel2",@"icon_severitylevel3", nil];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    cell.ranktitlelabel.text = [dict objectForKey:@"name"];
    cell.rankView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.section]];
    
    if ([[dict objectForKey:@"description"] length] == 0) {
        cell.rankIntrolabel.text = @"!无说明";
    }else
    {
        cell.rankIntrolabel.text = [dict objectForKey:@"description"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    NSString *rowid = [dict objectForKey:@"id"];
    RankTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.block1(cell.ranktitlelabel.text);
    self.block2(rowid);
    self.rowOfSelectBlock(indexPath.section);
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 55;
    }
    
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 2) {
        UIView *view1 = [self creatFootView1];
        return view1;
    }
    
    
    return nil;
    
}
-(UIView*)creatFootView1
{
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, KCWIDTH-10, 55)];
    label.text = @"说明：本平台提供褥疮的预防，以及一度褥疮和二度褥疮的护理。三度褥疮局部组织出现溃烂和坏死，建议及时就医。";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    [view1 addSubview:label];
    
    return view1;
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
