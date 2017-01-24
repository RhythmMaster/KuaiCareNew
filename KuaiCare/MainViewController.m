//
//  MainViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "YuYueTableViewCell.h"
#import "FuwuInfoTableViewCell.h"
#import "HuliViewController.h"
#import "ChooseCityViewController.h"
#import "HuliMessageCenterViewController.h"
#import "CustomBtn2.h"
#import "UIBarButtonItem+Badge.h"
#import "HZHomeNetManager.h"


#import "OrderDetailViewController.h"
#import "ZhifuViewController.h"
#import "HZOrderListViewModel.h"
#import "HZOrderListOperationNetManager.h"
#import "OrderPingjiaViewController.h"
#import "CancelWeiJiedanViewController.h"


#import "WeiyuFirstTableViewCell.h"
#import "WeiyuSecondTableViewCell.h"
#import "WeiyuThirdTableViewCell.h"
#import "Utils.h"


#import "XWLocationManager.h"

#import "HZIndexViewModel.h"
#import "HZMessageViewController.h"


#import "GYZChooseCityController.h"
#import "MainWeiPromotViewController.h"

@interface MainViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource, GYZChooseCityDelegate>
@property (nonatomic ,strong) UITableView *tableView ;
@property (nonatomic ,copy)NSString *city;
@property (nonatomic ,strong) CustomBtn2 *button;
@property (nonatomic ,copy)NSString *cityString;

@property (nonatomic ,assign)CGFloat height;
@property(nonatomic) UIButton *loationBtn;
//地图定位
@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressXY;


@property(nonatomic) HZOrderListViewModel *orderListVM;

@property(nonatomic) HZIndexViewModel *indexVM;

@property(nonatomic) UITableView *tableForNoOrder;


@end
@implementation MainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView.mj_header beginRefreshing];
}
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCurrentLocation];
    
    
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"快护理";
    _button = [[CustomBtn2 alloc] init];
    _button.frame = CGRectMake(0, 0, 80, 40);
    [_button addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *city = [ud objectForKey:@"citys"];
    NSString *str = [ud objectForKey:@"是"];
    if ([str isEqualToString:@"第一次"]) {
        [_button setTitle:city forState:UIControlStateNormal];

    }
    if ([str isEqualToString:@"第二次"]) {
         [_button setTitle:self.cityString forState:UIControlStateNormal];
    }
    
    
    [_button setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
    self.button = _button;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.leftBarButtonItem = item;

    UIImage *image = [UIImage imageNamed:@"message_title"];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,0,image.size.width, image.size.height);
    [button1 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchDown];
    [button1 setBackgroundImage:image forState:UIControlStateNormal];
    
    // Make BarButton Item
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"1";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor redColor];
    [self tableForNoOrder];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];

    [self loadCycleScrollView];
    [self getWeiduMessage];
    

    
    
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.orderListVM getContentWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                //记得写啊,不然没法利用kAppdelegate的全局性了
                kAppdelegate.loginState =  _orderListVM.orderModel.state;
                [_tableView reloadData];
                self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%ld", _orderListVM.orderModel.msgCount];
            }
            [_tableView.mj_header endRefreshing];
        }];
        
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self.orderListVM getContentWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                //记得写啊,不然没法利用kAppdelegate的全局性了
                kAppdelegate.loginState =  _orderListVM.orderModel.state;
                [_tableView reloadData];
            }
            [_tableView.mj_footer endRefreshing];
            if (!_orderListVM.orderModel.orderList.count) {
                [self.view showWarning:@"没有更多订单信息了"];
            }
        }];
        
    }];
    [_tableView.mj_header beginRefreshing];
    
    self.tableForNoOrder.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.indexVM getIndexModelWithCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            } else {
                
                kAppdelegate.loginState = 1;
                [_tableForNoOrder reloadData];
            }
            [_tableForNoOrder.mj_header endRefreshing];
        }];

        
    }];
    
    [_tableForNoOrder.mj_header beginRefreshing];
    
    
    
}


#pragma mark method 
#pragma mark
- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [kAppdelegate.window showWarning:@"定位失败"];
        }else{
            [kAppdelegate.window showWarning:@"定位成功"];
            
            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            [self.loationBtn setTitle:placeMark.locality forState:UIControlStateNormal];
            self.address = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
            
            
            //数据持久化
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.address forKey:@"address"];
            [defaults setObject:self.addressXY forKey:@"addressXY"];
            [defaults synchronize];
            
        }
    } onViewController:self];
    
}




- (void)tongzhi:(NSNotification *)text{
    
    self.cityString = [text.userInfo objectForKey:@"text"];
    [self.button setTitle:[text.userInfo objectForKey:@"text"]forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
    NSLog(@"44444%@",[text.userInfo objectForKey:@"text"]);

    
}

- (void)loadCycleScrollView {
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
    
    SDCycleScrollView *cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KCWIDTH, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView1.delegate = self;
    cycleScrollView1.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.tableView.tableHeaderView = cycleScrollView;//把滑动视图当作表头
    self.tableForNoOrder.tableHeaderView = cycleScrollView1;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 2;
    cycleScrollView1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView1.autoScrollTimeInterval = 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_orderListVM.rowNumber > 0) {
        return _orderListVM.rowNumber + 1;
    }
    return 4;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_orderListVM.rowNumber > 0) {
        
        if (indexPath.section == 0) {
            static NSString *cellID = @"CELL1";
            YuYueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            //这里有个坑,cell重用的坑,不信把这个if删了试试,我想了两个小时才找到原因并解决的(重用这块遇到好几个坑了,找个时间总结一下)
            if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
                cell = nil;
            }
            if (cell == nil) {
                cell = [[YuYueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
            
        } else {
            NSInteger index = indexPath.section - 1;
            static NSString *cellID = @"CELL2";
            FuwuInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
                cell = nil;
            }
            if (cell == nil) {
                cell = [[FuwuInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            
            
            [cell.touxiangView sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [_orderListVM getFileWithRow:index]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
            cell.nameLabel.text = [NSString stringWithFormat:@"医护人员: %@",[_orderListVM getMedicNameWithRow:index]];
            cell.hospitalabel.text = [NSString stringWithFormat:@" (%@)",[_orderListVM getHospitalWithRow:index]];
            cell.xiangmuLabel.text = [NSString stringWithFormat:@"服务项目: 服务+%@",[_orderListVM getServiceNameWithRow:index]];
            cell.pricelabel.text = [NSString stringWithFormat:@"¥%@",[_orderListVM getOrderMoneyWithRow:index]];
            cell.jiuzhenlabel.text = [NSString stringWithFormat:@"就诊人员: %@",[_orderListVM getPersonNameWithRow:index]];
            cell.addresslabel.text = [NSString stringWithFormat:@"服务地址: %@",[_orderListVM getAddressWithRow:index]];
            cell.xiadantimelabel.text = [NSString stringWithFormat:@"下单时间: %@",[_orderListVM getCreateTimeWithRow:index]];
            cell.fuwutimelabel.text = [NSString stringWithFormat:@"服务时间: %@",[_orderListVM getAppointmentTimeWithRow:index]];
            
            if ([_orderListVM getOrderStatusWithRow:index] == 1) {
                
                cell.dingdanButton.hidden = NO;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"待支付";
                [cell.dingdanButton setTitle:@"取消订单"  forState:UIControlStateNormal];
                [cell.zhifuButton setTitle:@"确认支付" forState:UIControlStateNormal];
                
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 2) {
                cell.dingdanButton.hidden = YES;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"待接单";
                [cell.zhifuButton setTitle:@"取消订单" forState:UIControlStateNormal];
                
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 3) {
                
                cell.dingdanButton.hidden = NO;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"待服务";
                [cell.dingdanButton setTitle:@"取消订单" forState:UIControlStateNormal];
                [cell.zhifuButton setTitle:@"联系医护" forState:UIControlStateNormal];
                
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 4) {
                cell.zhifustatusLabel.text = @"正在服务";
                cell.dingdanButton.hidden = YES;
                cell.zhifuButton.hidden = NO;
                [cell.zhifuButton setTitle:@"联系医护" forState:UIControlStateNormal];
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 5) {
                
                cell.dingdanButton.hidden = NO;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"待确认";
                [cell.dingdanButton setTitle:@"确认服务" forState:UIControlStateNormal];
                [cell.zhifuButton setTitle:@"联系医护" forState:UIControlStateNormal];
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 6) {
                
                cell.dingdanButton.hidden = NO;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"交易完成";
                [cell.dingdanButton setTitle:@"评价医护" forState:UIControlStateNormal];
                [cell.zhifuButton setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 7) {
                
                cell.dingdanButton.hidden = YES;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"已拒单";
                [cell.zhifuButton setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            if ([_orderListVM getOrderStatusWithRow:index] == 8) {
                
                cell.dingdanButton.hidden = YES;
                cell.zhifuButton.hidden = NO;
                
                cell.zhifustatusLabel.text = @"已取消";
                [cell.zhifuButton setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            
            
            cell.dingdanButton.tag = 200 + index;
            cell.zhifuButton.tag = 300 + index;
            
            [cell.dingdanButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.zhifuButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
            
            
        }
        
    } else {
        
        if (indexPath.section == 0) {
            static NSString *cellID = @"CELL1";
            WeiyuFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
                cell = nil;
            }
            if (cell == nil) {
                cell = [[WeiyuFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.priclabel.text = [NSString stringWithFormat:@"¥%@", self.indexVM.indexModel.servicePrice];
            cell.namelabel.text = self.indexVM.indexModel.name;
            cell.introlabel.text = self.indexVM.indexModel.desc;
            [cell.orderButton addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.section == 1) {
            static NSString *cellID = @"CELL1";
            WeiyuSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
                cell = nil;
            }
            if (cell == nil) {
                cell = [[WeiyuSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.timelabel.text = [NSString stringWithFormat:@"理疗时间: %@", self.indexVM.indexModel.theranyTime];
            cell.fuhulabel.text = [NSString stringWithFormat:@"服务内容: %@", self.indexVM.indexModel.serviceContent];
            cell.shoufalabel.text = [NSString stringWithFormat:@"护理手法: %@", self.indexVM.indexModel.name];
            
            return cell;
        }else if (indexPath.section == 2) {
            static NSString *cellID = @"CELL2";
            WeiyuThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
                cell = nil;
            }
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
        if ([self.tableView cellForRowAtIndexPath:indexPath].class != cell.class) {
            cell = nil;
        }
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"下单提示";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_orderListVM.rowNumber > 0) {
        if (indexPath.section == 0) {
            return 80;
        } else {
            return 266;
        }
    } else {
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
    
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_orderListVM.rowNumber > 0) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0) {
            self.hidesBottomBarWhenPushed = YES;
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            HuliViewController *huliVC = [[HuliViewController alloc] init];
            [self.navigationController pushViewController:huliVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else {
            OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] init];
            orderDetailVC.orderId = [self.orderListVM getIdWithRow:indexPath.section - 1];
            orderDetailVC.refundMode = [self.orderListVM getRefundStatusWithRow:indexPath.section - 1];
            orderDetailVC.addressXY = self.addressXY;
            orderDetailVC.gpsaddress = self.address;
            orderDetailVC.block = ^ {
                [_tableView.mj_header beginRefreshing];
            };
            
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderDetailVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
            
            
        }
    } else {
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


- (void)orderButtonClick {
    
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    HuliViewController *huliVC = [[HuliViewController alloc] init];
    [self.navigationController pushViewController:huliVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


//点击左边导航按钮
-(void)leftClick {
    self.hidesBottomBarWhenPushed = YES;
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
    self.hidesBottomBarWhenPushed = NO;
}
//点击右边导航按钮
- (void)rightClick {
    self.hidesBottomBarWhenPushed = YES;
    HZMessageViewController *messageVC = [[HZMessageViewController alloc] init];
    messageVC.block = ^ {
        [_tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:messageVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


#pragma mark method 订单状态
- (void)leftClick:(UIButton *)sender {
    
    NSInteger index = sender.tag - 200;
    NSString *orderId = [_orderListVM getIdWithRow:sender.tag - 200];
    
    //获取当前的cell, 然后做坏事
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index + 1];
    FuwuInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([_orderListVM getOrderStatusWithRow:index] == 1 || [_orderListVM getOrderStatusWithRow:index] == 3) {
        
        CancelWeiJiedanViewController *cancelVC = [CancelWeiJiedanViewController new];
        cancelVC.rowid = orderId;
        cancelVC.block = ^ {
            [_tableView.mj_header beginRefreshing];
        };
        self.hidesBottomBarWhenPushed = YES;
        //返回去除文字
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:cancelVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    } if ([_orderListVM getOrderStatusWithRow:index] == 5) {//确认服务
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"是否确认服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.view showBusyHUD];
            [HZOrderListOperationNetManager confirmServiceWithOrderId:orderId address:self.address addressXY:self.addressXY completionHandler:^(id model, NSError *error) {
                if (!error) {
                    
                    //想想: 完成服务需要将state改为6, 同时改变按钮
                    self.orderListVM.orderList[index].orderStatus = 6;
                    cell.dingdanButton.hidden = NO;
                    cell.zhifuButton.hidden = NO;
                    cell.zhifustatusLabel.text = @"交易完成";
                    [cell.dingdanButton setTitle:@"评价医护" forState:UIControlStateNormal];
                    [cell.zhifuButton setTitle:@"删除订单" forState:UIControlStateNormal];
                    [self.view showWarning:@"确认服务成功"];
                    [_tableView.mj_header beginRefreshing];
                }
            }];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } if ([_orderListVM getOrderStatusWithRow:index] == 6) {//服务评价
    
        OrderPingjiaViewController *evaluateVC = [OrderPingjiaViewController new];
        evaluateVC.orderId = [self.orderListVM getIdWithRow:index];
        if ([cell.dingdanButton.titleLabel.text isEqualToString:@"查看评价"]) {
            evaluateVC.isEvaluate = YES;
        } else {
            evaluateVC.isEvaluate = [_orderListVM isEvaluateWithRow:index];
        }
        evaluateVC.block = ^ {
            [cell.dingdanButton setTitle:@"查看评价" forState:UIControlStateNormal];
        };
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:evaluateVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
        return;
        
    }
    
}
- (void)rightClick:(UIButton *)sender {
    
    NSInteger index = sender.tag - 300;
    NSString *orderId = [_orderListVM getIdWithRow:sender.tag - 300];
    
    if ([_orderListVM getOrderStatusWithRow:index] == 1) {
        
        OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] init];
        orderDetailVC.orderId = [self.orderListVM getIdWithRow:index];
        orderDetailVC.refundMode = [self.orderListVM getRefundStatusWithRow:index];
        orderDetailVC.addressXY = self.addressXY;
        orderDetailVC.gpsaddress = self.address;
        orderDetailVC.block = ^ {
            [_tableView.mj_header beginRefreshing];
        };
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
        
    } else if ([_orderListVM getOrderStatusWithRow:index] == 6 || [_orderListVM getOrderStatusWithRow:index] == 7 || [_orderListVM getOrderStatusWithRow:index] == 8) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderListOperationNetManager deleteOrderWithOrderId:orderId completionHandler:^(id model, NSError *error) {
                
                
                [_orderListVM.orderList removeObjectAtIndex:index];
                [_tableView deleteSection:index withRowAnimation:(UITableViewRowAnimationRight)];
                [self.view showWarning:[model objectForKey:@"MSG"]];
                
            }];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
        
        
    } else if ([_orderListVM getOrderStatusWithRow:index] == 2) {
        CancelWeiJiedanViewController *cancelVC = [CancelWeiJiedanViewController new];
        cancelVC.rowid = orderId;
        cancelVC.block = ^ {
            [_tableView.mj_header beginRefreshing];
        };
        self.hidesBottomBarWhenPushed = YES;
        //返回去除文字
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:cancelVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    } else if ([_orderListVM getOrderStatusWithRow:index] == 3 || [_orderListVM getOrderStatusWithRow:index] == 4 || [_orderListVM getOrderStatusWithRow:index] == 5) {
        
        NSInteger tel =  [self.orderListVM getMedicPhoneWithPhone:index].integerValue;
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:callAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
        
    } else if ([_orderListVM getOrderStatusWithRow:index] == 6) {
        
        
    }
    
    
}






//获取未读消息
-(void)getWeiduMessage
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (HZOrderListViewModel *)orderListVM {
    if (!_orderListVM) {
        _orderListVM = [[HZOrderListViewModel alloc] initWithOrderType:1];
    }
    return _orderListVM;
}

- (HZIndexViewModel *)indexVM {
    if (!_indexVM) {
        _indexVM = [HZIndexViewModel new];
    }
    return _indexVM;
}

- (UITableView *)tableForNoOrder {
    if (!_tableForNoOrder) {
        _tableForNoOrder = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableForNoOrder.delegate = self;
        _tableForNoOrder.dataSource = self;
        [self.view addSubview:_tableForNoOrder];
        [_tableForNoOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableForNoOrder.hidden = YES;
    }
    return _tableForNoOrder;
}

@end
