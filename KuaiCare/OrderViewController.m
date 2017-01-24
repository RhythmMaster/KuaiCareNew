//
//  OrderViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/25.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderViewController.h"
#import "FuwuInfoTableViewCell.h"
#import "ChooseCityViewController.h"
#import "OrderDetailViewController.h"
#import "CustomBtn2.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "CancelWeiJiedanViewController.h"

#import "ZhifuViewController.h"
#import "HZOrderListViewModel.h"
#import "HZOrderListOperationNetManager.h"
#import "OrderPingjiaViewController.h"

#import "XWLocationManager.h"


@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UILabel *toplinelabel;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,assign)NSInteger selectIndex;
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic)NSString *page;
@property (nonatomic)NSMutableArray *array;
@property (nonatomic)NSString *rowid;



@property(nonatomic) NSString *gpsaddress;
@property(nonatomic) NSString *addressXY;

@property(nonatomic) HZOrderListViewModel *orderListVM;

@end

@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getCurrentLocation];
    //[self loadData];
}
- (void)loadData {
    [self tableView];
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/lstOrder",KCBaseURLString];
    self.page = @"1";
    self.array = [[NSMutableArray alloc] init];
    if ([self.orderindex isEqualToString:@"0"]) {
        NSDictionary *dict = @{@"page":self.page,@"rows":@"20"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"ddada%@",responseObject);
            self.array = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"]];
            [self.tableView reloadData];
            UITableView * weakBaseTableView = self.tableView;
            
            weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _page = @"1";
                NSLog(@"222%@",self.array);
                [self.array removeAllObjects];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20"};
                [self postActionWith:dict];
            }];
            weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                int i = [self.page intValue];
                i = i + 1;
                _page = [NSString stringWithFormat:@"%d",i];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20"};
                [self postActionWith:dict];
                
            }];
            [self.tableView.mj_header beginRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        

        
        
        
    }
    else if ([self.orderindex isEqualToString:@"1"]) {
        NSDictionary *dict = @{@"page":self.page,@"rows":@"20",@"order_status":@"1"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.array = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"]];
            [self.tableView reloadData];
            UITableView * weakBaseTableView = self.tableView;
            
            weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _page = @"1";
                NSLog(@"222%@",self.array);
                [self.array removeAllObjects];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20",@"order_status":@"1"};
                [self postActionWith:dict];
                
                
            }];
            weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                int i = [self.page intValue];
                i = i + 1;
                _page = [NSString stringWithFormat:@"%d",i];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20",@"order_status":@"1"};
                [self postActionWith:dict];
                
            }];
            [self.tableView.mj_header beginRefreshing];
            
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
    }
    else  {
        NSDictionary *dict = @{@"page":self.page,@"rows":@"20",@"order_status":@"2"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"vbvbvbv%@",responseObject);
            self.array = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"]];
            [self.tableView reloadData];
            UITableView * weakBaseTableView = self.tableView;
            
            weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _page = @"1";
                NSLog(@"222%@",self.array);
                [self.array removeAllObjects];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20",@"order_status":@"2"};
                [self postActionWith:dict];
                
                
            }];
            weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                int i = [self.page intValue];
                i = i + 1;
                _page = [NSString stringWithFormat:@"%d",i];
                NSDictionary *dict = @{@"page":_page,@"rows":@"20",@"order_status":@"2"};
                [self postActionWith:dict];
                
            }];
            [self.tableView.mj_header beginRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    }

}
- (void)postActionWith:(NSDictionary *)dic {
    
    //加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@/app/patient/order/lstOrder",KCBaseURLString];
    [mannager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        mutableArray = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
        if (self.array.count ==0||self.array ==nil) {
            self.array = [NSMutableArray arrayWithArray:[[responseObject  objectForKey:@"CONTENT"] objectForKey:@"LIST"]];
            
        }else if (self.array.count <=Allcount){
            [self.array addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.orderListVM getContentWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                //记得写啊,不然没法利用kAppdelegate的全局性了
                kAppdelegate.loginState =  _orderListVM.orderModel.state;
                [_tableView reloadData];
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
    
}
#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderListVM.rowNumber;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    NSInteger index = indexPath.section;
    FuwuInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FuwuInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell.touxiangView sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [_orderListVM getFileWithRow:index]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"医护人员: %@",[_orderListVM getMedicNameWithRow:indexPath.section]];
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
        if ([_orderListVM isEvaluateWithRow:index]) {
            [cell.dingdanButton setTitle:@"查看评价" forState:UIControlStateNormal];
        } else {
            [cell.dingdanButton setTitle:@"评价医护" forState:UIControlStateNormal];
        }
        
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
#pragma mark method 
- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [kAppdelegate.window showWarning:@"定位失败"];
        }else{

            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            self.gpsaddress = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
            
        }
    } onViewController:self];
    
}

- (void)leftClick:(UIButton *)sender {

    NSInteger index = sender.tag - 200;
    NSString *orderId = [_orderListVM getIdWithRow:sender.tag - 200];
    
    //获取当前的cell, 然后做坏事
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    FuwuInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([_orderListVM getOrderStatusWithRow:index] == 1 || [_orderListVM getOrderStatusWithRow:index] == 3) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            CancelWeiJiedanViewController *cancelVC = [CancelWeiJiedanViewController new];
            cancelVC.rowid = orderId;
            self.hidesBottomBarWhenPushed = YES;
            //返回去除文字
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            
            [self.navigationController pushViewController:cancelVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } if ([_orderListVM getOrderStatusWithRow:index] == 5) {//确认服务
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"是否确认服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.view showBusyHUD];
            [HZOrderListOperationNetManager confirmServiceWithOrderId:orderId address:self.gpsaddress addressXY:self.addressXY completionHandler:^(id model, NSError *error) {
                if (!error) {
                    
                    //想想: 完成服务需要将state改为6, 同时改变按钮
                    self.orderListVM.orderList[index].orderStatus = 6;
                    cell.dingdanButton.hidden = NO;
                    cell.zhifuButton.hidden = NO;
                    cell.zhifustatusLabel.text = @"交易完成";
                    [cell.dingdanButton setTitle:@"评价医护" forState:UIControlStateNormal];
                    [cell.zhifuButton setTitle:@"删除订单" forState:UIControlStateNormal];
                    [self.view showWarning:@"确认服务成功"];
                    
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
        if ([cell.dingdanButton.titleLabel.text isEqualToString:@"查看评价"]) {
            evaluateVC.isEvaluate = YES;
        } else {
            evaluateVC.isEvaluate = [_orderListVM isEvaluateWithRow:index];
        }
        evaluateVC.orderId = [self.orderListVM getIdWithRow:index];
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
        orderDetailVC.gpsaddress = self.gpsaddress;
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
                [_tableView reloadData];
                [self.view showWarning:[model objectForKey:@"MSG"]];
                
            }];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;

        
    } else if ([_orderListVM getOrderStatusWithRow:index] == 2) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
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
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
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




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] init];
    orderDetailVC.orderId = [self.orderListVM getIdWithRow:indexPath.section];
    orderDetailVC.refundMode = [self.orderListVM getRefundStatusWithRow:indexPath.section];
    orderDetailVC.addressXY = self.addressXY;
    orderDetailVC.gpsaddress = self.gpsaddress;
    orderDetailVC.block = ^ {
        [_tableView.mj_header beginRefreshing];
    };
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 0.1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 266;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (HZOrderListViewModel *)orderListVM {
    if (!_orderListVM) {
        _orderListVM = [[HZOrderListViewModel alloc] initWithOrderType:self.orderIndex];
    }
    return _orderListVM;
}






@end
