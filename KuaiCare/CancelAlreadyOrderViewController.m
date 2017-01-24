//
//  CancelAlreadyOrderViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CancelAlreadyOrderViewController.h"
#import "JSTextView.h"
#import "CancelAlreadyOrderTableViewCell.h"
@interface CancelAlreadyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *nameArray;
@property (nonatomic ,assign)NSInteger selectIndex;
@end

@implementation CancelAlreadyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"取消订单";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem withBarItem:@"back_btn_normal" name:@"" target:self action:@selector(leftClick)];
    self.nameArray = [[NSArray alloc] initWithObjects:@"我临时有事，不需要护理了",@"医护人员联系不上",@"其它" ,nil];
    [self initUI];

}
-(void)initUI
{
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = RGB(220, 233, 255);
    topLabel.text = @"现在已到您预约上门服务的时间，如果是您的原因，将扣除您的服务费用。如果是医护人员的原因，我们核实后会将服务费退还给您。";
    topLabel.numberOfLines = 0;
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(KCHEIGHT*0.2);
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).equalTo(10);
        make.left.right.equalTo(0);
        make.height.equalTo(44*3);
    }];
    
    JSTextView *textView = [[JSTextView alloc] init];
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.placeholder = @"输入原因";
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).equalTo(5);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(KCHEIGHT*0.2);
    }];
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor = RGB(38, 107, 255);
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"确认取消" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 20;
    cancelButton.layer.masksToBounds = YES;
    [self.view addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).equalTo(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(KCWIDTH/3);
    }];
    NSLog(@"%@",self.view.subviews);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    
    CancelAlreadyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CancelAlreadyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.selectButton setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
    [cell.selectButton setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateSelected];
    [cell.selectButton setTitle:[self.nameArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.selectButton.tag = indexPath.row+1;
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (indexPath.row == 0) {
        cell.selectButton.selected = YES;
        _selectIndex = cell.selectButton.tag;
    }
    return cell;
}
//点击了确认取消按钮
-(void)cancelButtonClick
{
    
    
}
-(void)selectButtonClick:(UIButton*)selectButton
{
    UIButton *lastButton = (UIButton*)[self.tableView viewWithTag:_selectIndex];
    lastButton.selected = NO;
    selectButton.selected = YES;
    _selectIndex = selectButton.tag;
    
    
    
    
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
