//
//  HZPatientViewController.m
//  KuaiCare
//
//  Created by tang on 17/1/13.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZPatientViewController.h"
#import "HcdDateTimePickerView.h"

#import "HZEditPatientNetManager.h"

@interface HZPatientViewController ()<UITextFieldDelegate, ChangeStatus>

@property(nonatomic) UIView *oneView;
@property(nonatomic) UIButton *oneBtn;

@property(nonatomic) UIView *twoView;
@property(nonatomic) UILabel *nameLb;
@property(nonatomic) UITextField *nameTextField;
@property(nonatomic) UIButton *contanceBtn;


@property(nonatomic) UIView *threeView;
@property(nonatomic) UILabel *phoneLb;
@property(nonatomic) UITextField *phoneTextField;


@property(nonatomic) UIView *fourView;
@property(nonatomic) UILabel *sexLb;
@property(nonatomic) HZIsClickBtn *manBtn;
@property(nonatomic) HZIsClickBtn *womanBtn;

@property(nonatomic) UIView *fiveView;
@property(nonatomic) UILabel *birthLb;
@property(nonatomic) UIButton *timeBtn;
@property(nonatomic) UITextField *timeField;

@property(nonatomic) UIView *sixView;
@property(nonatomic) UILabel *IDLb;
@property(nonatomic) UITextField *IDTextField;



@property(nonatomic) UIView *sevenView;
@property(nonatomic) UILabel *healthIDLb;
@property(nonatomic) UITextField *healthIDTextField;

@property(nonatomic) NSString *sexStr;


@property(nonatomic) HZSeePatientInfoModel *patientInfoModel;

@end

@implementation HZPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑就诊人";
    
    [self oneBtn];
    [self nameTextField];
    [self phoneTextField];
    [self manBtn];
    [self timeField];
    [self IDTextField];
    [self healthIDTextField];
    
    //默认
    if (_womanBtn.isClick) {
        self.sexStr = @"1";
    }
    if (_manBtn.isClick) {
        self.sexStr = @"0";
    }
    
    UIBarButtonItem *saveRightBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    
    self.navigationItem.rightBarButtonItems = @[spaceItem, saveRightBtn];
    
    
    
    if (self.editID.length) {
        [HZEditPatientNetManager modifyPatientWithID:self.editID completionHandler:^(HZSeePatientInfoModel *model, NSError *error) {
            if (!error) {
                self.patientInfoModel = model;
                
                _nameTextField.text = model.name;
                _phoneTextField.text = model.tel;
                if (model.sex.integerValue) {
                    [_manBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
                    [_womanBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
                } else {
                    [_womanBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
                    [_manBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
                }
                _timeField.text = model.birthday;
                _IDTextField.text = model.idCard;
                _healthIDTextField.text = model.medicareCard;
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }
    
    
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _timeField) {
        [self setBirthClick:_timeField];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
}


#pragma mark method AddressBookViewController
- (void)changeStatus:(NSString *)isOn phone:(NSString *)phone {
    _nameTextField.text = isOn;
    _phoneTextField.text = phone;
    
}


#pragma mark method moveKeyboard

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
   
    CGFloat offset = height - (kScreenH - (self.sixView.height + self.sixView.y) - 64);
    
    if (offset > 0) {
        [self moveUpKeyBoard:offset];
        
    }

    offset = height - (kScreenH - (self.sevenView.height + self.sevenView.y) - 64);
    
    if (offset > 0) {
        
        [self moveUpKeyBoard:offset];
    }
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [self moveDownKeyBoard];
}


- (void)moveUpKeyBoard:(CGFloat)offset{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}
- (void)moveDownKeyBoard{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark method 
- (void)setBirthClick:(UITextField *)sender {
    HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    [dateTimePickerView setMinYear:1890];
    [dateTimePickerView setMaxYear:2100];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSLog(@"%@", datetimeStr);
        _timeField.text = datetimeStr;
    };
    if (dateTimePickerView) {
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
}

//通讯录
- (void)contactButtonClick:(UIButton *)sender {
    AddressBookViewController *bookVC = [[AddressBookViewController alloc] init];
    bookVC.delegate = self;
    [self.navigationController pushViewController:bookVC animated:YES];
}

//性别选取
- (void)sexSelectClick:(UIButton *)sender {
    if (sender.tag - 1000) {//女
        self.sexStr = @"1";
        [_manBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
    } else {
        self.sexStr = @"0";
        [_womanBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        [_manBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
    }
}

//保存
- (void)saveClick:(UIBarButtonItem *)sender {
    if (kAppdelegate.haveLogin) {
        if (_nameTextField.text.length == 0) {
            [self.view showWarning:_nameTextField.placeholder];
            return;
        }
        if(![Utils isInvalidPhoneNumber:_phoneTextField.text]){
            
            [MBProgressHUD showToast:_phoneTextField.placeholder];
            return;
        }
        if ([Utils isEmptyString:_timeField.text]) {
            [MBProgressHUD showToast:_timeField.placeholder];
            return;
        }
        if (_IDTextField.text.length == 0) {
            _IDTextField.text = @"";
        }
        if (_healthIDTextField.text.length == 0) {
            _healthIDTextField.text = @"";
        }
        
        [self.view showBusyHUD];
        [HZEditPatientNetManager savePatientInfoWithName:_nameTextField.text tel:_phoneTextField.text sex:self.sexStr birthday:_timeField.text IdCard:_IDTextField.text mediCcareCard:_healthIDTextField.text completionHandler:^(id model, NSError *error) {
    
            if (!error) {
                if ([[model objectForKey:@"STATE"] integerValue]) {
                    [kAppdelegate.window showWarning:@"保存成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self.view showWarning:@"保存失败"];
                }
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
            
            
        }];
        
    } else {
        
    }
    
    
}





#pragma  mark lazy
- (UIView *)oneView {
    if (!_oneView) {
        _oneView = [UIView new];
        [self.view addSubview:_oneView];
        [_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_oneView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _oneView;
}
- (UIButton *)oneBtn {
    if (!_oneBtn) {
        _oneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.oneView addSubview:_oneBtn];
        [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
        }];
        _oneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_oneBtn setTitle:@" 请输入就诊人信息,我们将完全保密,请放心填写" forState:UIControlStateNormal];
        [_oneBtn setImage:[UIImage imageNamed:@"icon_l_ts"] forState:UIControlStateNormal];
    }
    return _oneBtn;
}

- (UIView *)twoView {
    if (!_twoView) {
        _twoView = [UIView new];
        [self.view addSubview:_twoView];
        [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.oneView.mas_bottom);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_twoView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _twoView;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.twoView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _nameLb.text = @"姓名";
        _nameLb.font = [UIFont systemFontOfSize:15];
    }
    return _nameLb;
}

- (UIButton *)contanceBtn {
    if (!_contanceBtn) {
        _contanceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.twoView addSubview:_contanceBtn];
        [_contanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(38, 38));
        }];
        _contanceBtn.contentMode = UIViewContentModeScaleAspectFill;
        _contanceBtn.clipsToBounds = YES;
        [_contanceBtn setImage:[UIImage imageNamed:@"icon_l_bt_tx"] forState:UIControlStateNormal];
        [_contanceBtn addTarget:self action:@selector(contactButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contanceBtn;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [UITextField new];
        [self.twoView addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLb.mas_right).equalTo(8);
            make.right.equalTo(self.contanceBtn.mas_left).equalTo(-6);
            make.top.equalTo(4);
            make.bottom.equalTo(0);
        }];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.delegate = self;
        _nameTextField.font = [UIFont systemFontOfSize:13];
        _nameTextField.placeholder = @"请输入联系人姓名或从通讯录选择";
//        [_nameTextField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        
    }
    return _nameTextField;
}

- (UIView *)threeView {
    if (!_threeView) {
        _threeView = [UIView new];
        [self.view addSubview:_threeView];
        [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.twoView.mas_bottom).equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_threeView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _threeView;
}
- (UILabel *)phoneLb {
    if (!_phoneLb) {
        _phoneLb = [UILabel new];
        [self.threeView addSubview:_phoneLb];
        [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _phoneLb.text = @"电话";
        _phoneLb.font = [UIFont systemFontOfSize:15];
    }
    return _phoneLb;
}
- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [UITextField new];
        [self.threeView addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phoneLb.mas_right).equalTo(8);
            make.top.equalTo(4);
            make.bottom.equalTo(0);
            make.right.equalTo(-20);
        }];
        _phoneTextField.textAlignment = NSTextAlignmentRight;
        _phoneTextField.delegate = self;
        _phoneTextField.font = [UIFont systemFontOfSize:13];
        _phoneTextField.placeholder = @"请输入联系人号码或从通讯录选择";
        [_phoneTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _phoneTextField;
}


- (UIView *)fourView {
    if (!_fourView) {
        _fourView = [UIView new];
        [self.view addSubview:_fourView];
        [_fourView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.threeView.mas_bottom).equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_fourView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _fourView;
}
- (UILabel *)sexLb {
    if (!_sexLb) {
        _sexLb = [UILabel new];
        [self.fourView addSubview:_sexLb];
        [_sexLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _sexLb.text = @"性别";
        _sexLb.font = [UIFont systemFontOfSize:15];
    }
    return _sexLb;
}

- (HZIsClickBtn *)womanBtn {
    if (!_womanBtn) {
        [self sexLb];
        _womanBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        [self.fourView addSubview:_womanBtn];
        [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(0);
        }];
        _womanBtn.tag = 1001;
        [_womanBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        [_womanBtn setTitle:@" 女" forState:UIControlStateNormal];
        [_womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _womanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_womanBtn addTarget:self action:@selector(sexSelectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womanBtn;
}


- (HZIsClickBtn *)manBtn {
    if (!_manBtn) {
        _manBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        [self.fourView addSubview:_manBtn];
        [_manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.womanBtn.mas_left).equalTo(-30);
            make.centerY.equalTo(0);
        }];
        [_manBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        [_manBtn setTitle:@" 男" forState:UIControlStateNormal];
        [_manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _manBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _manBtn.tag = 1000;
        [_manBtn addTarget:self action:@selector(sexSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        _manBtn.isClick = YES;
    }
    return _manBtn;
}

- (UIView *)fiveView {
    if (!_fiveView) {
        _fiveView = [UIView new];
        [self.view addSubview:_fiveView];
        [_fiveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.fourView.mas_bottom).equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_fiveView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _fiveView;
}

- (UILabel *)birthLb {
    if (!_birthLb) {
        _birthLb = [UILabel new];
        [self.fiveView addSubview:_birthLb];
        [_birthLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _birthLb.text = @"出生日期";
        _birthLb.font = [UIFont systemFontOfSize:15];
    }
    return _birthLb;
}

- (UITextField *)timeField {
    if (!_timeField) {
        _timeField = [UITextField new];
        [self.fiveView addSubview:_timeField];
        [_timeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.birthLb.mas_right).equalTo(8);
            make.top.equalTo(4);
            make.bottom.equalTo(0);
            make.right.equalTo(-20);
        }];
        _timeField.textAlignment = NSTextAlignmentRight;
        _timeField.delegate = self;
        _timeField.font = [UIFont systemFontOfSize:13];
        _timeField.placeholder = @"请输入出生日期";
        [_timeField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        
    }
    return _timeField;
}


- (UIView *)sixView {
    if (!_sixView) {
        _sixView = [UIView new];
        [self.view addSubview:_sixView];
        [_sixView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.fiveView.mas_bottom).equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_sixView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _sixView;
}
- (UILabel *)IDLb {
    if (!_IDLb) {
        _IDLb = [UILabel new];
        [self.sixView addSubview:_IDLb];
        [_IDLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _IDLb.text = @"医保卡号";
        _IDLb.font = [UIFont systemFontOfSize:15];
    }
    return _IDLb;
}
- (UITextField *)IDTextField {
    if (!_IDTextField) {
        _IDTextField = [UITextField new];
        [self.sixView addSubview:_IDTextField];
        [_IDTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.IDLb.mas_right).equalTo(8);
            make.top.equalTo(4);
            make.bottom.equalTo(0);
            make.right.equalTo(-20);
        }];
        _IDTextField.textAlignment = NSTextAlignmentRight;
        _IDTextField.delegate = self;
        _IDTextField.font = [UIFont systemFontOfSize:13];
        _IDTextField.placeholder = @"请输入身份证号码(可不填)";
        [_IDTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _IDTextField;
}


- (UIView *)sevenView {
    if (!_sevenView) {
        _sevenView = [UIView new];
        [self.view addSubview:_sevenView];
        [_sevenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.sixView.mas_bottom).equalTo(0);
            make.height.equalTo(42);
        }];
        UIView *lineView = [UIView new];
        [_sevenView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.6);
        }];
        lineView.backgroundColor = kLightGrayColor;
    }
    return _sevenView;
}
- (UILabel *)healthIDLb {
    if (!_healthIDLb) {
        _healthIDLb = [UILabel new];
        [self.sevenView addSubview:_healthIDLb];
        [_healthIDLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _healthIDLb.text = @"身份证号";
        _healthIDLb.font = [UIFont systemFontOfSize:15];
    }
    return _healthIDLb;
}
- (UITextField *)healthIDTextField {
    if (!_healthIDTextField) {
        _healthIDTextField = [UITextField new];
        [self.sevenView addSubview:_healthIDTextField];
        [_healthIDTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.healthIDLb.mas_right).equalTo(8);
            make.top.equalTo(4);
            make.bottom.equalTo(0);
            make.right.equalTo(-20);
        }];
        _healthIDTextField.textAlignment = NSTextAlignmentRight;
        _healthIDTextField.delegate = self;
        _healthIDTextField.font = [UIFont systemFontOfSize:13];
        _healthIDTextField.placeholder = @"请输入医保卡号(可不填)";
        [_healthIDTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return _healthIDTextField;
}



@end
