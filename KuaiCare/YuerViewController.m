//
//  YuerViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuerViewController.h"
#import "YuerDetailViewController.h"
#import "YuechongzhiViewController.h"
#import "YuetixianViewController.h"
@interface YuerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *nameArray;
@property (nonatomic ,strong)NSArray *imageArray;
@end

@implementation YuerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去掉背景图片
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"余额";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"" name:@"明细" target:self action:@selector(rightClick)];
    [self initUI];
    self.imageArray = [NSArray arrayWithObjects:@"setting",@"moenye", nil];
   
    self.nameArray = [[NSArray alloc] initWithObjects:@"充值",@"提现", nil];

}
- (void)initUI {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = RGB(38, 107, 255);
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(KCHEIGHT*0.25);
    }];
    UILabel *priceNamelabel = [[UILabel alloc] init];
    priceNamelabel.frame = CGRectMake(10, 20, KCWIDTH*0.5, 60);
    priceNamelabel.text = @"余额账户（元）";
    priceNamelabel.font = [UIFont systemFontOfSize:20];
    priceNamelabel.textColor = RGB(175, 200, 245);
    [backView addSubview:priceNamelabel];
    UILabel *pricelabel = [[UILabel alloc] init];
    pricelabel.frame = CGRectMake(10, 60, KCWIDTH*0.8, 80);
    pricelabel.text = self.price;
    pricelabel.textColor = [UIColor whiteColor];
    pricelabel.font = [UIFont systemFontOfSize:40];
    
    [backView addSubview:pricelabel];
    
    UIButton *detailbutton = [[UIButton alloc] init];
    [detailbutton addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    detailbutton.frame = CGRectMake(KCWIDTH - 50, 35, 20, 20);
    detailbutton.layer.cornerRadius = 10;
    detailbutton.clipsToBounds = YES;
    [detailbutton setTitle:@"?" forState:UIControlStateNormal];
    [detailbutton setTitleColor:kBlueColor forState:UIControlStateNormal];
    [detailbutton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    detailbutton.backgroundColor = [UIColor whiteColor];
    [backView addSubview:detailbutton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KCHEIGHT*0.25, KCWIDTH, KCHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(44*2);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        self.hidesBottomBarWhenPushed = YES;
        YuechongzhiViewController *chongzhiVC = [[YuechongzhiViewController alloc] init];
        [self.navigationController pushViewController:chongzhiVC animated:YES];
    }else {
        self.hidesBottomBarWhenPushed = YES;
        YuetixianViewController *tixianVC = [[YuetixianViewController alloc] init];
        [self.navigationController pushViewController:tixianVC animated:YES];
        
    }
    
}
- (void)detailClick {
    
    
    
}
- (void)leftClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightClick {
    self.hidesBottomBarWhenPushed = YES;
    YuerDetailViewController *detaiVC = [[YuerDetailViewController alloc] init];
    [self.navigationController pushViewController:detaiVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
