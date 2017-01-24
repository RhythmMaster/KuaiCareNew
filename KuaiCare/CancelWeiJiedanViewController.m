//
//  CancelWeiJiedanViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CancelWeiJiedanViewController.h"
#import "JSTextView.h"
#import "CancelAlreadyOrderTableViewCell.h"
#import "XWLocationManager.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
@interface CancelWeiJiedanViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *nameArray;
@property (nonatomic ,assign)NSInteger selectIndex;
@property (nonatomic)JSTextView *textView;
@property (nonatomic)NSString *count;
@property (nonatomic)NSString *code;


@property(nonatomic) UIButton *loationBtn;
//地图定位

@end

@implementation CancelWeiJiedanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/cancelReason",KCBaseURLString];
    NSDictionary *dict = @{@"orderId":self.rowid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"aaaga%@, %@",responseObject, [responseObject objectForKey:@"MSG"]);
        if ([[responseObject objectForKey:@"STATE"] integerValue] == 0) {
            [kAppdelegate.window showWarning:@"订单信息不存在,或获取错误,无法取消!"];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        self.nameArray = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
        self.count = [[[responseObject objectForKey:@"CONTENT"] objectForKey:@"INFO"] objectForKey:@"count"];
        NSLog(@"self.count%@", self.count);
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(44*self.nameArray.count);
        }];
        [self.tableView reloadData];
        self.textView = [[JSTextView alloc] init];
        self.textView .layer.cornerRadius = 5;
        self.textView.delegate = self;
        self.textView .layer.masksToBounds = YES;
        self.textView .layer.borderWidth = 1.0;
        self.textView .layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.textView .placeholder = @"输入原因";
        [self.view addSubview:self.textView ];
        [self.textView  mas_makeConstraints:^(MASConstraintMaker *make) {
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
        [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelButton.layer.masksToBounds = YES;
        [self.view addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).equalTo(10);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.equalTo(KCWIDTH/3);
            make.height.equalTo(40);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [kAppdelegate.window showWarning:@"定位失败"];
        }else{
            
            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            [self.loationBtn setTitle:placeMark.locality forState:UIControlStateNormal];
            self.gpsaddress = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
            
            
            //数据持久化
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:self.address forKey:@"address"];
//            [defaults setObject:self.addressXY forKey:@"addressXY"];
//            [defaults synchronize];
            
        }
    } onViewController:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self getCurrentLocation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"取消订单";
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.block();
}

#pragma mark delete tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    
    CancelAlreadyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CancelAlreadyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.selectButton setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
    [cell.selectButton setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateSelected];
    
    NSString *name = [[self.nameArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    [cell.selectButton setTitle:name forState:UIControlStateNormal];
    [cell.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.selectButton.tag = indexPath.row+1;
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (indexPath.row == 0) {
        cell.selectButton.selected = YES;
        _selectIndex = cell.selectButton.tag;
        self.code =  [[self.nameArray objectAtIndex:cell.selectButton.tag] objectForKey:@"code"];
    }
    return cell;
}
-(void)selectButtonClick:(UIButton*)selectButton
{
    self.code =  [[self.nameArray objectAtIndex:selectButton.tag-1] objectForKey:@"code"];
    
    UIButton *lastButton = (UIButton*)[self.tableView viewWithTag:_selectIndex];
    lastButton.selected = NO;
    selectButton.selected = YES;
    _selectIndex = selectButton.tag;
    
}
//点击了确认取消按钮
- (void)cancelButtonClick {
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/orderCancel",KCBaseURLString];
    if (self.textView.text.length == 0) {
        if (self.gpsaddress.length == 0) {
            [self.view showWarning:@"定位失败"];
            return;
        }
        if (self.addressXY.length == 0) {
            [self.view showWarning:@"定位失败"];
            return;
        }
        if (self.count == nil) {
            self.count = @"";
        }
        NSDictionary *dict = @{@"orderId":self.rowid,@"code":self.code,@"address":self.gpsaddress,@"addressXY":self.addressXY, @"count": self.count};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [self.view showBusyHUD];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *msg = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [MBProgressHUD showToast:msg];
            self.block();
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else {
        NSDictionary *dict = @{@"orderId":self.rowid,@"code":self.code,@"reason":self.textView.text,@"address":self.gpsaddress,@"addressXY":self.addressXY, @"count": self.count};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *msg = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"dadavv%@",msg);
            [MBProgressHUD showToast:msg];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
 
    
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textView resignFirstResponder];
}
- (void)leaveEditMode {
    
    [self.textView resignFirstResponder];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
