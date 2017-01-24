//
//  PersonalViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/25.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonfirstTableViewCell.h"
#import "PersonSecondTableViewCell.h"
#import "SettingViewController.h"
#import "SuggestViewController.h"
#import "YuerViewController.h"
#import "JifenViewController.h"
#import "PersonDetailViewController.h"
#import "HZShareViewController.h"
#import "SelectAddressViewController.h"
#import "SelectJiuzhenViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"



#import "HZMyCenterIndexNetManager.h"



#import "HZAboutUSViewController.h"



@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableDictionary *dict2;
@property (nonatomic, strong) NSTimer *timer;
@property int timerCount;
@property (nonatomic ,strong)UIButton *qiandaoButton;
@property (nonatomic ,copy)NSString *integralReserve;
@property (nonatomic ,copy)NSString *priceString;

@property(nonatomic) HZHZMyCenterIndexModel *myCenterIndexModel;


@end

@implementation PersonalViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero  style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    self.dict2 = [[NSMutableDictionary alloc] init];
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [HZMyCenterIndexNetManager getMyCenterIndexWithCompletionHandler:^(HZHZMyCenterIndexModel *model, NSError *error) {
            if (!error) {
                kAppdelegate.loginState = model.state;
                self.myCenterIndexModel = model;
                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
            
        }];
    }];
    [_tableView.mj_header beginRefreshing];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"个人中心";
    
}
- (void)leftClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return 2;
    }
    
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"CELL";
        PersonfirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[PersonfirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (_myCenterIndexModel.head) {
            [cell.personheadButton sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, _myCenterIndexModel.head].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        }
        
        [cell.qiandaoButton setImage:[UIImage imageNamed:@"qiandao2"] forState:UIControlStateNormal];
        if (_myCenterIndexModel.nickName.length == 0) {
            cell.phoneLabel.text = _myCenterIndexModel.phone;
        } else {
            cell.phoneLabel.text =_myCenterIndexModel.nickName;
        }
        
        [cell.qiandaoButton addTarget:self action:@selector(qiandaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      
        if (_myCenterIndexModel.isSign) {
            [cell.qiandaoButton setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
        }else
        {
           [cell.qiandaoButton setImage:[UIImage imageNamed:@"qiandao2"] forState:UIControlStateNormal];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *cellID = @"CELL1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"余额%@元",_myCenterIndexModel.cashReserve];
        self.priceString = _myCenterIndexModel.cashReserve;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section == 2) {
        
        static NSString *cellID = @"CELL2";
        PersonSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[PersonSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
           
        }
        [cell.customButton1 addTarget:self action:@selector(customButtonClick1) forControlEvents:UIControlEventTouchUpInside];
        [cell.customButton2 addTarget:self action:@selector(customButtonClick2) forControlEvents:UIControlEventTouchUpInside];
        [cell.customButton3 addTarget:self action:@selector(customButtonClick3) forControlEvents:UIControlEventTouchUpInside];
        [cell.customButton4 addTarget:self action:@selector(customButtonClick4) forControlEvents:UIControlEventTouchUpInside];
        
        cell.customButton1.introlabel2.text = [NSString stringWithFormat:@"%ld",_myCenterIndexModel.integralReserve];
        self.integralReserve = [NSString stringWithFormat:@"%ld",_myCenterIndexModel.integralReserve];
        return cell;

    }
    if (indexPath.section == 3 ) {
        static NSString *cellID = @"CELL3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imageView.image = [UIImage imageNamed:@"setting1"];
        cell.textLabel.text = @"设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section == 4 && indexPath.row == 0 ) {
        static NSString *cellID = @"CELL4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imageView.image = [UIImage imageNamed:@"yijian"];
        cell.textLabel.text = @"意见反馈";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section == 4 && indexPath.row == 1 ) {
        static NSString *cellID = @"CELL5";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.imageView.image = [UIImage imageNamed:@"kefu"];
        cell.textLabel.text = @"客服热线";
        cell.detailTextLabel.text = _myCenterIndexModel.serviceHotline;
        
        
        return cell;
    }
    
    
    if (indexPath.section == 5 ) {
        static NSString *cellID = @"CELL6";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imageView.image = [UIImage imageNamed:@"img_aboutus"];
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }
    static NSString *cellID = @"CELL7";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        self.hidesBottomBarWhenPushed = YES;
        PersonDetailViewController *personDetailVC = [[PersonDetailViewController alloc] init];
        personDetailVC.block = ^ {
            [_tableView.mj_header beginRefreshing];
        };
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        [self.navigationController pushViewController:personDetailVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
    if (indexPath.section == 1) {
        self.hidesBottomBarWhenPushed = YES;
        YuerViewController *yuerVC = [[YuerViewController alloc] init];
        yuerVC.price = self.priceString;
        [self.navigationController pushViewController:yuerVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
    if (indexPath.section == 3) {
        self.hidesBottomBarWhenPushed = YES;
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        [self.navigationController pushViewController:settingVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        self.hidesBottomBarWhenPushed = YES;
        SuggestViewController *suggestVC = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:suggestVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        NSInteger tel =  _myCenterIndexModel.serviceHotline.integerValue;
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:callAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
      
    }
    if (indexPath.section == 5) {
        HZAboutUSViewController *aboutUSVC = [HZAboutUSViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUSVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    
   else if (indexPath.section == 2) {
        return 140;
    }
    
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.01;
    }
    return 10;
}
//点击了签到按钮
-(void)qiandaoButtonClick:(UIButton*)qiandaobutton
{
        qiandaobutton.selected = !qiandaobutton.selected;
       [MBProgressHUD showMessage:Net_Connecting];

        NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/signIn",KCBaseURLString];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            NSLog(@"%@",responseObject);
            if ([responseObject objectForKey:@"STATE"]) {
               [qiandaobutton setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
            }
            [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            //[self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
}
//点击了积分按钮
-(void)customButtonClick1 {
    self.hidesBottomBarWhenPushed = YES;
    JifenViewController *jifenVC = [[JifenViewController alloc] init];
    jifenVC.integralReserve = self.integralReserve;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:jifenVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//点击了分享奖励按钮
-(void)customButtonClick2
{
    self.hidesBottomBarWhenPushed = YES;
    HZShareViewController *sharevc = [[HZShareViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:sharevc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//就诊人管理
- (void)customButtonClick3 {
    self.hidesBottomBarWhenPushed = YES;
    SelectJiuzhenViewController *jiuzhenVC = [[SelectJiuzhenViewController alloc] init];
    jiuzhenVC.isCenterVC = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:jiuzhenVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
//常用地址管理
- (void)customButtonClick4 {
    self.hidesBottomBarWhenPushed = YES;
    SelectAddressViewController *addressVC = [[SelectAddressViewController alloc] init];
    addressVC.isCenterVC = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:addressVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
