//
//  EditjiuzhenViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "EditjiuzhenViewController.h"
#import "AddressBookViewController.h"

#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "HcdDateTimePickerView.h"
@interface EditjiuzhenViewController ()<UITextFieldDelegate,ChangeStatus>
{
    HcdDateTimePickerView * dateTimePickerView;
}
@property (nonatomic ,strong)UITextField *textfield1;
@property (nonatomic ,strong)UITextField *textfield2;
@property (nonatomic ,strong)UITextField *textfield3;
@property (nonatomic ,strong)UITextField *textfield4;
@property (nonatomic ,strong)UITextField *textfield5;
@property (nonatomic ,strong)UIButton *selectbutton1;
@property (nonatomic ,strong)UIButton *selectbutton2;
@property (nonatomic ,copy)NSString *xingbie;


@end

@implementation EditjiuzhenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"编辑就诊人";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"" name:@"保存" target:self action:@selector(rightClick)];
    [self initUI];

    
}
-(void)initUI {
    
    NSArray *nameArray = [[NSArray alloc] initWithObjects:@"姓名",@"电话",@"性别",@"出生日期", @"身份证号",@"医保卡号",nil];
    NSArray *textfiledArray = [[NSArray alloc ] initWithObjects:@"请设置出生日期",@"请输入身份证号（可不填）",@"请输入医保卡号（可不填）", nil];
    UIView *backView = [[UIView alloc] init];
   // backView.frame = CGRectMake(0, 0, KCWIDTH, 375);
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(320);
    }];
    
    
    UIButton *topButton = [[UIButton alloc] init];
    topButton.frame = CGRectMake(10, 10, 15, 20);
    [topButton setBackgroundImage:[UIImage imageNamed:@"icon_l_ts"] forState:UIControlStateNormal];
    [backView addSubview:topButton];
    UILabel *toplabel = [[UILabel alloc] init];
    toplabel.frame = CGRectMake(35, 10, KCWIDTH*0.9, 20);
    toplabel.font = [UIFont systemFontOfSize:10];
    toplabel.text = @"请输入就诊人信息，我们将完全保密，请放心填写";
    toplabel.font = [UIFont systemFontOfSize:12];
    [backView addSubview:toplabel];
    
    for (int  i = 0; i<6 ; i++) {
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+45*(i+1), KCWIDTH*0.25, 20)];
        namelabel.text = [nameArray objectAtIndex:i];
        namelabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:namelabel];
        if (i == 0) {
            UIButton *contactButton = [[UIButton alloc] init];
            contactButton.frame = CGRectMake(20+KCWIDTH*0.8, 52+45*i, KCWIDTH*0.085, KCWIDTH*0.085);
            [contactButton addTarget:self action:@selector(contactButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [contactButton setImage:[UIImage imageNamed:@"icon_l_bt_tx"] forState:UIControlStateNormal];
            [contactButton setTitle:@"  " forState:UIControlStateNormal];
            [backView addSubview:contactButton];
            
            UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(KCWIDTH*0.22, 60+45*i, KCWIDTH*0.6, 20)];
          
           // textfield1.borderStyle =  UITextBorderStyleRoundedRect;
            textfield1.delegate = self;
            textfield1.textAlignment = NSTextAlignmentRight;
            textfield1.font = [UIFont systemFontOfSize:12];
            textfield1.placeholder = @"请输入联系人姓名或从通讯录选择";
            self.textfield1 = textfield1;
            [backView addSubview:textfield1];
        }
        if (i == 1) {
            UITextField *textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(KCWIDTH*0.4, 60+45*i, KCWIDTH*0.5, 20)];
            textfield2.font = [UIFont systemFontOfSize:12];
            textfield2.delegate = self;
            textfield2.textAlignment = NSTextAlignmentRight;
            self.textfield2 = textfield2;
            textfield2.placeholder = @"请输入联系人的手机号码";
            [backView addSubview:textfield2];
        }
        
        if (i == 2) {
            _selectbutton1 = [[UIButton alloc] init];
            [_selectbutton1 addTarget:self action:@selector(selectButtonclick1:) forControlEvents:UIControlEventTouchUpInside];
            _selectbutton1.frame = CGRectMake(KCWIDTH*0.7, 53+45*i, 50, 30);
            [_selectbutton1 setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
            [_selectbutton1 setImage:[UIImage imageNamed:@"复选框选中"]  forState:UIControlStateSelected];
            [_selectbutton1 setTitle:@"男" forState:UIControlStateNormal];
            [_selectbutton1.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_selectbutton1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [_selectbutton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _selectbutton1.selected = YES;
            self.xingbie = @"0";
            [backView addSubview:_selectbutton1];
            
            
            
            _selectbutton2 = [[UIButton alloc] init];
            [_selectbutton2 addTarget:self action:@selector(selectButtonclick2:) forControlEvents:UIControlEventTouchUpInside];
            _selectbutton2.frame = CGRectMake(KCWIDTH*0.7+55, 53+45*i, 50, 30);
            [_selectbutton2 setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
            [_selectbutton2 setImage:[UIImage imageNamed:@"复选框选中"]  forState:UIControlStateSelected];
            [_selectbutton2 setTitle:@"女" forState:UIControlStateNormal];
            [_selectbutton2.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_selectbutton2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [_selectbutton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [backView addSubview:_selectbutton2];

            
        }
    }
   
    for (int i = 0; i<6; i++) {
        
        UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 45*(i+1) , KCWIDTH-5, 1)];
        linelabel.backgroundColor = RGB(242, 242, 242);
        [backView addSubview:linelabel];
    }
    for (int i = 4; i<7; i++) {
        
        UITextField *textfiled = [[UITextField alloc] init];
        textfiled.delegate = self;
        textfiled.frame = CGRectMake(KCWIDTH*0.4, 60+45*(i-1), KCWIDTH*0.5, 20);
        textfiled.placeholder = [textfiledArray objectAtIndex:i-4];
        textfiled.font = [UIFont systemFontOfSize:12];
        textfiled.textAlignment = NSTextAlignmentRight;
        [backView addSubview:textfiled];
        if (i == 4) {
            self.textfield3 = textfiled;
            //self.textfield3.enabled = NO;
        }else if (i == 5)
        {
            self.textfield4 = textfiled;
        }else
        {
            self.textfield5 = textfiled;
        }
        
    }
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    if (self.textfield1 == textField) {
        [self.textfield1 resignFirstResponder];
    }else  if (self.textfield2  == textField){
        [self.textfield2 resignFirstResponder];
    }else if (self.textfield3 == textField)
    {
        [self.textfield3 resignFirstResponder];
    }else if (self.textfield4 == textField)
    {
        [self.textfield4 resignFirstResponder];
    }else
    {
        [self.textfield5 resignFirstResponder];
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.view.frame.origin.y<0){
        [self moveDownKeyBoard];
    }
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield3 resignFirstResponder];
    [self.textfield4 resignFirstResponder];
    [self.textfield5 resignFirstResponder];
}

-(void)moveDownKeyBoard{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textfield3 == textField) {
        dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
        [dateTimePickerView setMinYear:1890];
        [dateTimePickerView setMaxYear:2100];
        WK(weakSelf)
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            NSLog(@"%@", datetimeStr);
            weakSelf.textfield3.text = datetimeStr;
        };
        if (dateTimePickerView) {
            [self.view addSubview:dateTimePickerView];
            [dateTimePickerView showHcdDateTimePicker];
        }
        return NO;
    }
    return YES;
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (  self.textfield4 == textField  || self.textfield5 == textField  ) {
        CGFloat offset=320-(self.view.frame.size.height-(textField.frame.origin.y+textField.frame.size.height));
        //    NSLog(@"%f",offset);
        if(offset>0){
            
            [self moveUpKeyBoard:offset];
        }else{
            
            if(!(textField.superview==self.view)){
                
                CGFloat superOffset=320-(H(self.view)-(Y_H(textField.superview)));
                //            NSLog(@"%f",superOffset);
                if(superOffset>0){
                    
                    [self moveUpKeyBoard:superOffset];
                }
            }
        }
        

    }
  }


-(void)moveUpKeyBoard:(CGFloat)offset{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}


- (void)selectButtonclick1:(UIButton*)selectButton1 {
    selectButton1.selected = !selectButton1.selected;
    if (selectButton1.selected == YES) {
        self.xingbie = @"0";
        _selectbutton2.selected = NO;
    }else
    {
        
    }
    
}

-(void)selectButtonclick2:(UIButton*)selectButton2
{
    selectButton2.selected = !selectButton2.selected;
    if (selectButton2.selected == YES) {
        self.xingbie = @"1";
        _selectbutton1.selected = NO;
    }else
    {
        
        
    }
    
}
-(void)headButtonClick:(UIButton*)headButton
{
    
}
//点击了联系人按钮
-(void)contactButtonClick
{
    AddressBookViewController *bookVC = [[AddressBookViewController alloc] init];
    bookVC.delegate = self;
    [self.navigationController pushViewController:bookVC animated:YES];
}
-(void)changeStatus:(NSString *)isOn phone:(NSString *)phone
{
    
    self.textfield1.text = isOn;
    self.textfield2.text = phone;
    
}

//点击了保存按钮
- (void)rightClick {
    if (kAppdelegate.haveLogin) {
        if ([Utils isEmptyString:self.textfield1.text]) {
            [MBProgressHUD showToast:self.textfield1.placeholder];
            return;
        }
        if(![Utils isInvalidPhoneNumber:self.textfield2.text]){
            
            [MBProgressHUD showToast:self.textfield2.placeholder];
            return;
        }
        if ([Utils isEmptyString:self.textfield3.text]) {
            [MBProgressHUD showToast:self.textfield3.placeholder];
            return;
        }
        if (self.textfield4.text.length == 0) {
            self.textfield4.text = @"";
        }
        if (self.textfield5.text.length == 0) {
            self.textfield5.text = @"";
        }
        if (_selectbutton1.selected  == NO && _selectbutton2.selected == NO) {
            [MBProgressHUD showToast:@"请选择性别"];
            return;
        }
        [MBProgressHUD showMessage:Net_Connecting];
        
        NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/editseedoctorperson",KCBaseURLString];
        
        NSDictionary *paramters = @{@"name":self.textfield1.text,@"tel":self.textfield2.text,@"sex":self.xingbie,@"birthday":self.textfield3.text,@"idcard":self.textfield4.text,@"medicareCard":self.textfield5.text};
        NSLog(@"%@",paramters);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
            if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showToast:Net_Connection_Error];
        }];
    } else {
        
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
