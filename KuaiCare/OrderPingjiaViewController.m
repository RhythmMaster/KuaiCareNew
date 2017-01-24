//
//  OrderPingjiaViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderPingjiaViewController.h"
#import "OrderPingjiaFirstTableViewCell.h"
#import "OrderPingjiaSecondTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

#import "HZOrderListOperationNetManager.h"

#import "JSTextView.h"

@interface OrderPingjiaViewController ()<UITableViewDataSource,UITableViewDelegate, UITextViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property(nonatomic) HZOrderEvaluateModel *evaluateModel;
@property(nonatomic) HZOrderEvaluateModel *haveEvaluateModel;

@property(nonatomic) NSString *onTime;
@property(nonatomic) NSString *nursingTechnique;
@property(nonatomic) NSString *serviceAttitude;

@property(nonatomic) JSTextView *textView;

@property(nonatomic) UIButton *cancelButton;
@property(nonatomic) UIButton *submitButton;


@end

@implementation OrderPingjiaViewController

    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HZOrderListOperationNetManager orderEvaluateWithOrderId:self.orderId completionHandler:^(HZOrderEvaluateModel *model, NSError *error) {
        if (!error) {
            self.evaluateModel = model;
            [_tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    
    
    
    [HZOrderListOperationNetManager evaluateDisplayWithOrderId:self.orderId completionHandler:^(HZOrderEvaluateModel *model, NSError *error) {
        if (!error) {
            self.haveEvaluateModel = model;
            [_tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        
    }];

}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"服务评价";
    
    [self tableView];
    
    
    
    
    
    //增加对键盘的监听,当键盘出现或改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加对键盘的监听,当键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}


#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 3;
    }
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"CELL1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
            cell.imageView.image = [UIImage imageNamed:@"icon_l_fwxm"];
            cell.textLabel.text = @"服务项目";
            cell.textLabel.textColor = kBlueColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *cellID = @"CELL2";
        OrderPingjiaFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[OrderPingjiaFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
        }
        
        [cell.titleView1 sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, self.evaluateModel.ifile].tzl_URL];
        cell.titlelabel.text = self.evaluateModel.itemName;
        cell.introlabel.text = self.evaluateModel.classifyName;
        cell.timelabel.text = self.evaluateModel.classifyTime;
        if (self.evaluateModel.file_0.length) {
            cell.titleView2.hidden = NO;
            cell.plusView1.hidden = NO;
            [cell.titleView2 sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, self.evaluateModel.file_0].tzl_URL];
        } else {
            cell.titleView2.hidden = YES;
            cell.plusView1.hidden = YES;
        }
        if (self.evaluateModel.file_1.length) {
            cell.plusView2.hidden = NO;
            cell.titleView3.hidden = NO;
            [cell.titleView3 sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, self.evaluateModel.file_1].tzl_URL];
        } else {
            cell.plusView2.hidden = YES;
            cell.titleView3.hidden = YES;
        }
        
        cell.pricelabel.text = [NSString stringWithFormat:@"¥%.2f", self.evaluateModel.payMoney.floatValue];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }else if (indexPath.section == 2) {
        static NSString *cellID = @"CELL3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"康复师: %@", self.evaluateModel.medicName];
        return cell;
        
        
    }else if (indexPath.section == 3) {
        NSArray *nameArray = [NSArray arrayWithObjects:@"上门准时：",@"护理技术：",@"服务态度：", nil];
        static NSString *cellID = @"CELL3";
        OrderPingjiaSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[OrderPingjiaSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.namelabel.text = [nameArray objectAtIndex:indexPath.row];
        cell.starRatingView.tag = indexPath.row + 444;
        if (self.isEvaluate) {
            cell.starRatingView.allowClick = NO;
        } else {
            cell.starRatingView.allowClick = YES;
        }
        [cell.starRatingView addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventValueChanged];
        
        if (indexPath.row == 0) {
            if (self.haveEvaluateModel.onTime > 0) {
                cell.starRatingView.value = self.haveEvaluateModel.onTime;
            } else {
                cell.starRatingView.value = 5;
            }
            self.onTime = [NSString stringWithFormat:@"%f", cell.starRatingView.value];
        } else if (indexPath.row == 1) {
            if (self.haveEvaluateModel.nursingTechnique > 0) {
                cell.starRatingView.value = self.haveEvaluateModel.nursingTechnique;
            } else {
                cell.starRatingView.value = 5;
            }
            self.nursingTechnique = [NSString stringWithFormat:@"%f", cell.starRatingView.value];
        } else {
            if (self.haveEvaluateModel.serviceAttitude > 0) {
                cell.starRatingView.value = self.haveEvaluateModel.serviceAttitude;
            } else {
                cell.starRatingView.value = 5;
            }
            self.serviceAttitude = [NSString stringWithFormat:@"%f", cell.starRatingView.value];
        }
        
        
        return cell;
    }

    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
        
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        UIView *view1 = [self creatFootView1];
        return view1;
    }
   
    
    return nil;
    
}
- (UIView*)creatFootView1 {
    UIView *view1 = [UIView new];
    _textView = [[JSTextView alloc] initWithFrame:CGRectMake(20, 20, KCWIDTH-40, 100)];
    [_textView.layer setCornerRadius:5];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.placeholder = @"写下您的评价。。。";
    
    if (self.haveEvaluateModel.evaluateReason.length) {
        _textView.text = self.haveEvaluateModel.evaluateReason;
        _textView.placeLabel.hidden = YES;
    } else {
        _textView.placeLabel.hidden = NO;
    }
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton.frame = CGRectMake(40, 140, KCWIDTH/2-60, 40);
    [_cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitle:@"取消评价" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
    _cancelButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    _cancelButton.layer.cornerRadius = 6;
    _cancelButton.clipsToBounds = YES;
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitButton.frame = CGRectMake(20+KCWIDTH/2, 140, KCWIDTH/2-60, 40);
    [_submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"提交评价" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _submitButton.layer.borderWidth = 1;
    _submitButton.layer.borderColor = [UIColor blueColor].CGColor;
    _submitButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    _submitButton.layer.cornerRadius = 6;
    _submitButton.clipsToBounds = YES;
    
    if (self.isEvaluate) {
        self.cancelButton.hidden = YES;
        self.submitButton.hidden = YES;
        self.textView.editable = NO;
    } else {
        self.cancelButton.hidden = NO;
        self.submitButton.hidden = NO;
        self.textView.editable = YES;
    }
    
    [view1 addSubview:_cancelButton];
    [view1 addSubview:_submitButton];
    [view1 addSubview:_textView];
    return view1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 75;
    }
    
    return 38;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 200;
    }
    
    return 0.1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete text

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;    
    
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    [_textView resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}



#pragma mark method
//点击星星赋值
- (void)starClick:(HCSStarRatingView *)sender {
    
    if ((sender.tag - 444) == 0) {
        self.onTime = [NSString stringWithFormat:@"%f", sender.value];
        NSLog(@"%@", self.onTime);
    } else if ((sender.tag - 444) == 1) {
        self.nursingTechnique = [NSString stringWithFormat:@"%f", sender.value];
    } else {
        self.serviceAttitude = [NSString stringWithFormat:@"%f", sender.value];
    }
    
}
- (void)cancelClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)submitClick:(UIButton *)sender {
 
    
    [self.view showBusyHUD];
    [HZOrderListOperationNetManager evaluateSaveWithOrderId:self.orderId onTime:self.onTime nursingTechnique:self.nursingTechnique serviceAttitude:self.serviceAttitude evaluateReason:self.textView.text completionHandler:^(HZOrderEvaluateModel *model, NSError *error) {
        if (model.state) {
            [self.view showWarning:model.msg];
            self.block();
            self.isEvaluate = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
}

//算键盘
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"height:%f", height);
    
    
    
    CGFloat btnHeight = kScreenH - 445;
    NSLog(@"btnHeight:%f", btnHeight);
    
    
    if (btnHeight < height) {
        
        [self moveUpKeyBoard:(height - btnHeight)];
    }
    
    
    
    
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    if (self.view.frame.origin.y < 0) {
        
        [self moveDownKeyBoard];
    }
    
    
}

- (void)moveDownKeyBoard {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //64 是44的导航栏高度和导航栏Y坐标,打印可知,后期重做
    self.view.frame = CGRectMake(0.0f, 64, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)moveUpKeyBoard:(CGFloat)offset{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
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

@end
