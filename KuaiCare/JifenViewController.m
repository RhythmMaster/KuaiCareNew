//
//  JifenViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "JifenViewController.h"
#import "JifenGuizeViewController.h"
#import "JifenTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "Jifen.h"
@interface JifenViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UILabel *toplinelabel;
@property (nonatomic ,assign)NSInteger selectIndex;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,strong)NSMutableArray *jifenArray;

@end

@implementation JifenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    self.navigationItem.title = @"积分";

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 100, 40);
    [button addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"积分规则" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.rightBarButtonItems = @[spaceItem, item];
    
    
    [self initUI];

}
-(void)initUI
{
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, KCWIDTH, KCHEIGHT*0.3);
    backView.backgroundColor = RGB(38, 107, 255);
    [self.view addSubview:backView];
//    UIButton *jifenButton = [[UIButton alloc] init];
//    jifenButton.frame = CGRectMake(KCWIDTH/3, 20, KCWIDTH/3, KCWIDTH/3);
//  //  jifenButton.backgroundColor = [UIColor redColor];
//    [jifenButton setBackgroundImage:[UIImage imageNamed:@"jifen_quan"] forState:UIControlStateNormal];
//    [backView addSubview:jifenButton];
    UILabel *jifenlabel = [[UILabel alloc] init];
    jifenlabel.frame = CGRectMake(KCWIDTH/3, 20, KCWIDTH/3, KCWIDTH/3);
    jifenlabel.layer.borderColor = [UIColor whiteColor].CGColor;
    jifenlabel.layer.borderWidth = 2;
    jifenlabel.layer.cornerRadius = KCWIDTH/6;
    jifenlabel.layer.masksToBounds = YES;
    [backView addSubview:jifenlabel];
    
    UILabel *jifenlabel1 = [[UILabel alloc] init];
    jifenlabel1.font = [UIFont systemFontOfSize:30];
    jifenlabel1.numberOfLines = 0;
    NSLog(@"111count %@",self.integralReserve);
    
    //富文本设置
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n个积分", self.integralReserve]];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(self.integralReserve.length + 1, 3)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment=NSTextAlignmentCenter;
    NSRange range =NSMakeRange(0,self.integralReserve.length + 4);
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    jifenlabel1.attributedText = attributeStr;
    jifenlabel1.textColor = [UIColor whiteColor];
    [jifenlabel addSubview:jifenlabel1];
    [jifenlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];

    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, KCHEIGHT*0.3, KCWIDTH, 44)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:@"全部",@"获得",@"使用", nil];
    
    for (int i = 0; i<3; i++) {
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.frame = CGRectMake(KCWIDTH/3*i, 0, KCWIDTH/3, 55);
        [topButton setTitle:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
        [topButton setTitleColor:RGB(38, 107, 255) forState:UIControlStateSelected];
        [topButton setTitleColor:RGB(171, 174, 191) forState:UIControlStateNormal];
        [topButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        topButton.tag = i+1;
        [self.topView addSubview:topButton];
        if (i == 0) {
            topButton.selected = YES;
            _selectIndex = topButton.tag;
            [MBProgressHUD showMessage:Net_Connecting];

            NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegral",KCBaseURLString];
            self.page = @"1";
            NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                [MBProgressHUD hideHUD];
              //  [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

                NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
                
               
                self.jifenArray = [[NSMutableArray alloc] init];
                for (NSDictionary *jifendict in array) {
                    Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
                    [self.jifenArray addObject:jifen];
                }
                [self.tableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                
                [MBProgressHUD showToast:Net_Connection_Error];
            }];

        }
    }
    self.toplinelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 43, KCWIDTH/3-40, 1)];
    self.toplinelabel.backgroundColor = RGB(38, 107, 255);
    [self.topView addSubview:self.toplinelabel];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(0);
    }];
    
    UITableView * weakBaseTableView = self.tableView;
    
    weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = @"1";
        NSLog(@"222%@",self.jifenArray);
        [self.jifenArray removeAllObjects];
        NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
        [self postActionWith:dict];
        
        
    }];
    weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        int i = [self.page intValue];
        i = i + 1;
        _page = [NSString stringWithFormat:@"%d",i];
        NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
        [self postActionWith:dict];
    }];
    [self.tableView.mj_header beginRefreshing];

}


- (void)topButtonClick:(UIButton*)topButton {
    UIButton *lastButton = (UIButton*)[self.topView viewWithTag:_selectIndex];
    lastButton.selected = NO;
    topButton.selected = YES;
    _selectIndex = topButton.tag;
    self.toplinelabel.frame = CGRectMake(topButton.frame.origin.x+20, 43, KCWIDTH/3-40, 1);
    if (topButton.tag == 1) {
        [MBProgressHUD showMessage:Net_Connecting];

        NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegral",KCBaseURLString];
        
        self.page = @"1";
        NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [MBProgressHUD hideHUD];
          //  [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

            NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
            self.jifenArray = [[NSMutableArray alloc] init];
            for (NSDictionary *jifendict in array) {
                Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
                [self.jifenArray addObject:jifen];
            }
               [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        UITableView * weakBaseTableView = self.tableView;
        
        weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = @"1";
            NSLog(@"222%@",self.jifenArray);
            [self.jifenArray removeAllObjects];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith:dict];
            
        }];
        weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            int i = [self.page intValue];
            i = i + 1;
            _page = [NSString stringWithFormat:@"%d",i];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith:dict];
            
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    if (topButton.tag == 2) {
        [MBProgressHUD showMessage:Net_Connecting];

        NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegraladd",KCBaseURLString];
        
        self.page = @"1";
        NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [MBProgressHUD hideHUD];
            //[MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

            NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
            self.jifenArray = [[NSMutableArray alloc] init];
            for (NSDictionary *jifendict in array) {
                Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
                [self.jifenArray addObject:jifen];
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showToast:Net_Connection_Error];
        }];

        UITableView * weakBaseTableView = self.tableView;
        
        weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = @"1";
            NSLog(@"222%@",self.jifenArray);
            [self.jifenArray removeAllObjects];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith1:dict];
            
            
        }];
        weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            int i = [self.page intValue];
            i = i + 1;
            _page = [NSString stringWithFormat:@"%d",i];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith1:dict];
            
        }];
        [self.tableView.mj_header beginRefreshing];

        
    }
    if (topButton.tag == 3) {
        [MBProgressHUD showMessage:Net_Connecting];

        NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegralout",KCBaseURLString];
        
        self.page = @"1";
        NSDictionary *paramters = @{@"page":self.page,@"rows":@"5"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [MBProgressHUD hideHUD];
           // [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

            NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
            self.jifenArray = [[NSMutableArray alloc] init];
            for (NSDictionary *jifendict in array) {
                Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
                [self.jifenArray addObject:jifen];
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
        
        UITableView * weakBaseTableView = self.tableView;
        
        weakBaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = @"1";
            NSLog(@"222%@",self.jifenArray);
            [self.jifenArray removeAllObjects];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith2:dict];
            
            
        }];
        weakBaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            int i = [self.page intValue];
            i = i + 1;
            _page = [NSString stringWithFormat:@"%d",i];
            NSDictionary *dict = @{@"page":_page,@"rows":@"5"};
            [self postActionWith2:dict];
            
        }];
        [self.tableView.mj_header beginRefreshing];
    }
}
- (void)postActionWith:(NSDictionary *)dic {
    //  加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegral",KCBaseURLString];
    [mannager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
        for (NSDictionary *jifendict in array) {
            Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
            [mutableArray addObject:jifen];
        }
        
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
        // if ([[responseObject objectForKey:@"CONTENT"] isKindOfClass:[NSMutableArray class]]) {
        
        
        if (self.jifenArray.count ==0||self.jifenArray ==nil) {
            self.jifenArray = mutableArray;
            
        }else if (self.jifenArray.count <=Allcount){
            [self.jifenArray addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
        //  }
        //        [MBProgressHUD showToast:[dic objectForKey:@"info"]];//提示获取信息成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}
- (void)postActionWith1:(NSDictionary *)dic {
    
    //  加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegraladd",KCBaseURLString];
    [mannager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
        for (NSDictionary *jifendict in array) {
            Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
            [mutableArray addObject:jifen];
        }
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
        // if ([[responseObject objectForKey:@"CONTENT"] isKindOfClass:[NSMutableArray class]]) {
        
        
        if (self.jifenArray.count ==0||self.jifenArray ==nil) {
            self.jifenArray = mutableArray;
            
        }else if (self.jifenArray.count <=Allcount){
            [self.jifenArray addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
        //  }
        //        [MBProgressHUD showToast:[dic objectForKey:@"info"]];//提示获取信息成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}
- (void)postActionWith2:(NSDictionary *)dic {
    
    //  加载控件
    [MBProgressHUD showMessage:Net_Connecting];
    /***************请求网络**********************/
    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@/app/common/myintegralout",KCBaseURLString];
    [mannager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSMutableArray *mutableArray = [NSMutableArray array];
        NSArray *array = [[responseObject objectForKey:@"CONTENT"] objectForKey:@"LIST"];
        for (NSDictionary *jifendict in array) {
            Jifen *jifen = [Jifen parseJifenWithDictionary:jifendict];
            [mutableArray addObject:jifen];
        }
        
        int Allcount = [[responseObject objectForKey:@"ALLCOUNT"] intValue];
        
        // if ([[responseObject objectForKey:@"CONTENT"] isKindOfClass:[NSMutableArray class]]) {
        
        
        if (self.jifenArray.count ==0||self.jifenArray ==nil) {
            self.jifenArray = mutableArray;
            
        }else if (self.jifenArray.count <=Allcount){
            [self.jifenArray addObjectsFromArray:mutableArray] ;
            
        }
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
        //  }
        //        [MBProgressHUD showToast:[dic objectForKey:@"info"]];//提示获取信息成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed!!!!");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jifenArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELL";
    JifenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[JifenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = RGB(242, 242, 242);
    }
    Jifen *jifen = [self.jifenArray objectAtIndex:indexPath.row];
    cell.jifentimelabel.text = jifen.create_date;
    if (jifen.integral_number.integerValue > 0) {
        cell.shumulabel.text = [NSString stringWithFormat:@"+%@",jifen.integral_number];
    } else {
        cell.shumulabel.text = [NSString stringWithFormat:@"%@",jifen.integral_number];
    }
    
    cell.statuslabel.text = jifen.change_type;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

-(void)rightClick {
    self.hidesBottomBarWhenPushed = YES;
    JifenGuizeViewController *jifenGuizeVC = [[JifenGuizeViewController alloc] init];
    [self.navigationController pushViewController:jifenGuizeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
