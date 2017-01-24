//
//  HZMessageViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMessageViewController.h"
#import "HZMessageCell.h"

#import "HuliViewMessageViewController.h"


@interface HZMessageViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) UITableView *tableView;
@property(nonatomic) HZMsgViewModel *msgVM;

@end

@implementation HZMessageViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"消息中心";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.msgVM getMsgWithRequestMode:VMMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.tableView reloadData];
            }
            [self.tableView.mj_header endRefreshing];
        }];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.msgVM getMsgWithRequestMode:VMMRequestModeMore completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.tableView reloadData];
            }
            [self.tableView.mj_footer endRefreshing];
            
            if (!_msgVM.msgModel.content.count) {
                [self.view showWarning:@"没有更多消息了"];
            }
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    if ([[self.msgVM getMsgTypeForRow:indexPath.row] integerValue] == 1) {
        cell.iconImg.image = [UIImage imageNamed:@"img_inbite"];
    }
    if ([[self.msgVM getMsgTypeForRow:indexPath.row] integerValue] == 2) {
        cell.iconImg.image = [UIImage imageNamed:@"service"];
    }
    if ([[self.msgVM getMsgTypeForRow:indexPath.row] integerValue] == 3) {
        cell.iconImg.image = [UIImage imageNamed:@"icon_l_none_address"];
    }
    cell.titleLb.text = [self.msgVM getMsgTypeNameForRow:indexPath.row];
    cell.detailLb.text = [self.msgVM getMsgContentForRow:indexPath.row];
    cell.timeLb.text = [self.msgVM getCreateTimeForRow:indexPath.row];
    if ([self.msgVM getIsReadForRow:indexPath.row]) {
        cell.dianImg.hidden = YES;
    } else {
        cell.dianImg.hidden = NO;
    }
    
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HuliViewMessageViewController *viewMsgVC = [HuliViewMessageViewController new];
    viewMsgVC.messageID = [self.msgVM getIDWithIndex:indexPath.row];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewMsgVC animated:YES];
    HZMessageCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.dianImg.hidden = YES;
    self.block();
}


#pragma mark -懒加栽
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZMessageCell class] forCellReuseIdentifier:@"messageCell"];
    }
    return _tableView;
}

- (HZMsgViewModel *)msgVM {
    if (!_msgVM) {
        _msgVM = [HZMsgViewModel new];
    }
    return _msgVM;
}


















@end
