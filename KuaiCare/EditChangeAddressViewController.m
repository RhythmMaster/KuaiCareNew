//
//  EditChangeAddressViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/17.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "EditChangeAddressViewController.h"
#import "YihuMapViewController.h"
#import "AddressBookViewController.h"
#import "Utils.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"

#import "ChooseCityViewController.h"

@interface EditChangeAddressViewController ()<UITextFieldDelegate,ChangeStatus, GYZChooseCityDelegate>
@property (nonatomic ,strong)UITextField *textfield1;
@property (nonatomic ,strong)UITextField *textfield2;
@property (nonatomic ,strong)UITextField *textfield3;
@property (nonatomic ,strong)UITextField *textfield4;
@property (nonatomic ,copy)NSString *str1;
@property (nonatomic ,copy)NSString *str2;
@property (nonatomic ,copy)NSString *isDefault;
@property (nonatomic ,strong)NSDictionary *dict;
@property (nonatomic ,strong)UISwitch *switchView;
@end

@implementation EditChangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddressView",KCBaseURLString];
    NSLog(@"%@",self.editID);
    NSDictionary *paramters = @{@"id":self.editID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        [MBProgressHUD hideHUD];
        //[MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];

        
         self.dict = [responseObject objectForKey:@"CONTENT"];
         self.textfield1.text = [self.dict objectForKey:@"name"];
         self.textfield2.text = [self.dict objectForKey:@"tel"];
         self.textfield3.text = [self.dict objectForKey:@"address"];
         self.textfield4.text = [self.dict objectForKey:@"addressInfo"];
        if ([[self.dict objectForKey:@"isDefault"] isEqualToString:@"1"]) {
            self.switchView.on = YES;
        }else
        {
            self.switchView.on = NO;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];

    
    
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"编辑地址";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"" name:@"保存" target:self action:@selector(rightClick)];
    [self initUI];
    
}
-(void)initUI
{
    NSArray *nameArray = [[NSArray alloc] initWithObjects:@"联系人：",@"电话：",@"地址：",@"详细地址：",@"设为默认：", nil];
    NSArray *textfiledArray = [[NSArray alloc ] initWithObjects:@"请输入联系人姓名或从通讯录选择",@"请输入联系人电话",@"请输入你所在的小区或大厦",@"请输入详细地址，如门牌号(必填)", nil];
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, KCWIDTH, 230);
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    for (int  i = 0; i<5 ; i++) {
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+45*i, KCWIDTH*0.25, 20)];
        namelabel.font = [UIFont systemFontOfSize:14];
        namelabel.text = [nameArray objectAtIndex:i];
        [backView addSubview:namelabel];
        
        if (i == 0) {
            UIButton *contactButton = [[UIButton alloc] init];
            contactButton.frame = CGRectMake(20+KCWIDTH*0.8, 10, KCWIDTH*0.08, KCWIDTH*0.08);
            [contactButton setImage:[UIImage imageNamed:@"icon_l_bt_tx"] forState:UIControlStateNormal];
            [contactButton addTarget:self action:@selector(contactButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:contactButton];
        }
        if (i == 2) {
            UIButton *mapButton = [[UIButton alloc] init];
            mapButton.frame = CGRectMake(20+KCWIDTH*0.8, 10+45*2, KCWIDTH*0.08, KCWIDTH*0.08);
            [mapButton addTarget:self action:@selector(mapButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [mapButton setImage:[UIImage imageNamed:@"icon_l_bt_wz"] forState:UIControlStateNormal];
            
            [backView addSubview:mapButton];
        }
        if (i == 4) {
            self.switchView = [[UISwitch alloc] initWithFrame:CGRectMake(20+KCWIDTH*0.75, 12+45*i, KCWIDTH*0.2, KCWIDTH*0.1)];
            self.switchView.on = YES;
            self.isDefault = @"1";
            [self.switchView addTarget:self action:@selector(switchViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:self.switchView];
            
        }
        
        
    }
    for (int i = 0; i<4; i++) {
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(20+KCWIDTH*0.2,  15+45*i, KCWIDTH*0.6, 20)];
        textfield.placeholder = [textfiledArray objectAtIndex:i];
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:12];
        [backView addSubview:textfield];
        if (i == 0) {
            self.textfield1 =  textfield;
            
            NSLog(@"%@",self.textfield1.text);
        }else if (i == 1)
        {
            self.textfield2 = textfield;
        }else if (i == 2)
        {
            self.textfield3 = textfield;
            
        }else
        {
            self.textfield4 = textfield;
        }
        
    }
    for (int i = 0; i<4; i++) {
        UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 46*(i+1) , KCWIDTH-5, 1)];
        linelabel.backgroundColor = RGB(242, 242, 242);
        [backView addSubview:linelabel];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

//点击了联系人按钮
-(void)contactButtonClick
{
    AddressBookViewController *addressVC = [[AddressBookViewController alloc] init];
    addressVC.delegate = self;
    [self.navigationController pushViewController:addressVC animated:YES];
    
}
-(void)changeStatus:(NSString *)isOn phone:(NSString *)phone
{
    self.textfield1.text = isOn;
    self.textfield2.text = phone;
}
//点击了转换器开关
-(void)switchViewClick:(UISwitch*)switchclick
{
    if (switchclick.isOn) {
        self.isDefault = @"1";
    } else {
        self.isDefault = @"0";
    }
    
    
}
//点击了地图按钮
-(void)mapButtonClick {
    self.hidesBottomBarWhenPushed = YES;
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city {
    self.textfield3.text = city.cityName;
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController {
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击了右边保存按钮
-(void)rightClick {
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
    if ([Utils isEmptyString:self.textfield4.text]) {
        [MBProgressHUD showToast:@"请填写详细地址"];
        return;
    }
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/commonlyaddress",KCBaseURLString];
    
    NSDictionary *paramters = @{@"name":self.textfield1.text,@"tel":self.textfield2.text,@"address":self.textfield3.text,@"addressInfo":self.textfield4.text,@"isDefault":self.isDefault,@"id":self.editID};
    NSLog(@"%@",paramters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        if ([[responseObject objectForKey:@"MSG"] isEqualToString:@"成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
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
    }else
    {
        [self.textfield4 resignFirstResponder];
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
    
}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    CGFloat offset=320-(self.view.frame.size.height-(textField.frame.origin.y+textField.frame.size.height));
//    //    NSLog(@"%f",offset);
//    if(offset>0){
//
//        [self moveUpKeyBoard:offset];
//    }else{
//
//        if(!(textField.superview==self.view)){
//
//            CGFloat superOffset=320-(H(self.view)-(Y_H(textField.superview)));
//            //            NSLog(@"%f",superOffset);
//            if(superOffset>0){
//
//                [self moveUpKeyBoard:superOffset];
//            }
//        }
//    }
//
//    if (textField == self.textfield2) {
//        textField.keyboardType = UIKeyboardTypeNumberPad;
//    }
//}
-(void)moveDownKeyBoard{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
//
//-(void)moveUpKeyBoard:(CGFloat)offset{
//
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
//
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
