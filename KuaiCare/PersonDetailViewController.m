//
//  PersonDetailViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Utils.h"
#import "HcdDateTimePickerView.h"

@interface PersonDetailViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    HcdDateTimePickerView * dateTimePickerView;
}
@property (nonatomic ,strong)NSArray *nameArray;
@property (nonatomic ,strong)NSArray *placeholderArray1;
@property (nonatomic ,strong)NSArray *placeholderArray2;
@property (nonatomic ,strong)UIButton *selectbutton1;
@property (nonatomic ,strong)UIButton *selectbutton2;
@property (nonatomic ,strong)UITextField *textfield1;
@property (nonatomic ,strong)UITextField *textfield2;
@property (nonatomic ,strong)UITextField *textfield3;
@property (nonatomic ,strong)UITextField *textfield4;
@property (nonatomic ,strong)UITextField *textfield5;
@property (nonatomic ,retain)NSMutableDictionary *dict;
@property (nonatomic ,strong)UIButton *nextButton;
@property (nonatomic ,copy)NSString *xingbie;
@property (nonatomic ,strong)UIImagePickerController *picker;
@end

@implementation PersonDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem withBarItem:@"" name:@"保存" target:self action:@selector(rightClick)];
    self.nameArray = [NSArray arrayWithObjects:@"头像",@"昵称",@"姓名",@"性别",@"出生日期",@"身份证号",@"支付宝账号", nil];
    self.placeholderArray1 = [NSArray arrayWithObjects:@"请设置昵称",@"请设置姓名", nil];
    self.placeholderArray2 = [NSArray arrayWithObjects:@"请设置出生日期",@"请输入身份证号",@"请输入支付宝账户", nil];
    self.dict = [[NSMutableDictionary alloc] init];

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/myinfo",KCBaseURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
       // [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        NSLog(@"333333%@",responseObject);
        
        NSMutableDictionary *dict1 = responseObject;
        self.dict = [dict1 objectForKey:@"CONTENT"];
        [self initUI];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
    
    //增加对键盘的监听,当键盘出现或改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加对键盘的监听,当键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
 
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.block();
}

- (void)initUI {
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, KCWIDTH, 44*7+40);
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    for (int i= 0; i<7; i++) {
        UILabel *namelabel = [[UILabel alloc] init];
        namelabel.frame = CGRectMake(10, 0+43*i, KCWIDTH*0.3, 43);
        namelabel.font = [UIFont systemFontOfSize:14];
        namelabel.text = [self.nameArray objectAtIndex:i];
        [backView addSubview:namelabel];
        if (i == 0) {
            UIImageView *headButton = [[UIImageView alloc] init];
            headButton.frame = CGRectMake(KCWIDTH-30-50, 5, 36, 36);
            headButton.tag = 1231;
            if ([self.dict objectForKey:@"head"]) {
                [headButton sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [self.dict objectForKey:@"head"]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
            } else {
                headButton.image = [UIImage imageNamed:@"默认头像"];
            }
            headButton.layer.cornerRadius = 18;
            headButton.clipsToBounds = YES;
            [backView addSubview:headButton];
            
            //后期加的,前面不是我写的,看到了别怪我
            UIButton *zhebujushoubuleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            zhebujushoubuleBtn.frame = CGRectMake(KCWIDTH * 0.4, 5, kScreenW * 0.6, 35);
            [backView addSubview:zhebujushoubuleBtn];
            [zhebujushoubuleBtn addTarget:self action:@selector(submithead) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    for (int i = 0; i<7; i++) {
        UILabel *linelabel = [[UILabel alloc] init];
        linelabel.frame = CGRectMake(5, 43*(i+1), KCWIDTH-5, 1);
        linelabel.backgroundColor = RGB(242, 242, 242);
        [backView addSubview:linelabel];
    }
    for (int i = 0; i<3; i++) {
        UIButton *nextButton1 = [[UIButton alloc] init];
        nextButton1.frame = CGRectMake(KCWIDTH-30, 5+43*i, 20, 30);
        [nextButton1 setImage :[UIImage imageNamed:@"gray_com"] forState:UIControlStateNormal];
        [nextButton1 setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 0)];
        //nextButton1.backgroundColor = [UIColor redColor];
        [backView addSubview:nextButton1];
    }
    for (int i = 4; i<7; i++) {
        UIButton *nextButton2 = [[UIButton alloc] init];
        nextButton2.frame = CGRectMake(KCWIDTH-30, 5+43*i, 20, 30);
        [nextButton2 setImage:[UIImage imageNamed:@"gray_com"] forState:UIControlStateNormal];
        [nextButton2 setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 0)];
        [backView addSubview:nextButton2];
        if (i == 4) {
            self.nextButton = nextButton2;
            [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    _selectbutton1 = [[UIButton alloc] init];
    [_selectbutton1 addTarget:self action:@selector(selectButtonclick1:) forControlEvents:UIControlEventTouchUpInside];
    _selectbutton1.frame = CGRectMake(KCWIDTH*0.7, 45+45*2, 50, 30);
    [_selectbutton1 setImage:[UIImage imageNamed:@"cityhot_edittext_bg.9"] forState:UIControlStateNormal];
    [_selectbutton1 setImage:[UIImage imageNamed:@"复选框选中"]  forState:UIControlStateSelected];
    [_selectbutton1 setTitle:@"男" forState:UIControlStateNormal];
    [_selectbutton1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_selectbutton1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_selectbutton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backView addSubview:_selectbutton1];
    if ([[self.dict objectForKey:@"sex"] isEqualToString:@"0"]) {
        _selectbutton1.selected = YES;
        self.xingbie = @"0";
    }
    _selectbutton2 = [[UIButton alloc] init];
    [_selectbutton2 addTarget:self action:@selector(selectButtonclick2:) forControlEvents:UIControlEventTouchUpInside];
    _selectbutton2.frame = CGRectMake(KCWIDTH*0.7+55, 45+45*2, 50, 30);
    [_selectbutton2 setImage:[UIImage imageNamed:@"cityhot_edittext_bg.9"] forState:UIControlStateNormal];
    [_selectbutton2 setImage:[UIImage imageNamed:@"复选框选中"]  forState:UIControlStateSelected];

    [_selectbutton2 setTitle:@"女" forState:UIControlStateNormal];
    [_selectbutton2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_selectbutton2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_selectbutton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([[self.dict objectForKey:@"sex"] isEqualToString:@"1"]) {
        _selectbutton2.selected = YES;
        self.xingbie = @"1";
    }
    
    [backView addSubview:_selectbutton2];
    
    for (int i= 1; i<3; i++) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(KCWIDTH*0.2, 43*i, KCWIDTH*0.7, 40);
        textfield.placeholder = [self.placeholderArray1 objectAtIndex:i-1];
        textfield.font = [UIFont systemFontOfSize:12];
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.delegate = self;
        [backView addSubview:textfield];
        if (i == 1) {
            self.textfield1 = textfield;
            NSLog(@"22222%@",self.dict);
            self.textfield1.text = [self.dict objectForKey:@"nickname"];
        }
        if (i == 2) {
            self.textfield2 = textfield;
            self.textfield2.text = [self.dict objectForKey:@"name"];
        }
    }
    for (int i = 4; i<7; i++) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(KCWIDTH*0.2, 43*i, KCWIDTH*0.7, 40);
        textfield.placeholder = [self.placeholderArray2 objectAtIndex:i-4];
        textfield.font = [UIFont systemFontOfSize:12];
        textfield.font = [UIFont systemFontOfSize:12];
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.delegate = self;
        [backView addSubview:textfield];
        if (i == 4) {
            self.textfield3 = textfield;
            self.textfield3.enabled = NO;
            self.textfield3.text = [self.dict objectForKey:@"birthday"];
            
            //这布局我没办法,只能这么做,不要怪我
            UIButton *zhebujuwofusongnigeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            zhebujuwofusongnigeBtn.frame = CGRectMake(KCWIDTH*0.2, 43*i, KCWIDTH*0.7, 40);
            [backView addSubview:zhebujuwofusongnigeBtn];
            [zhebujuwofusongnigeBtn addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        if (i == 5) {
            self.textfield4 = textfield;
            self.textfield4.text = [self.dict objectForKey:@"idcard"];

        }
        if (i == 6) {
            self.textfield5 = textfield;
            self.textfield5.text = [self.dict objectForKey:@"alipay"];
        }
    }
    UILabel *bottomlabel = [[UILabel alloc] init];
    bottomlabel.frame = CGRectMake(10, 44*7-15, KCWIDTH-10, 60);
    bottomlabel.font = [UIFont systemFontOfSize:13];
    bottomlabel.numberOfLines = 0;
    bottomlabel.text = @"备注：姓名、身份证号、支付宝账户信息我们将为您保密，三者一致才能进行提现操作";
    bottomlabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:bottomlabel];
    
}
- (void)nextButtonClick {
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
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
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
    self.view.frame = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}




//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"height:%f", height);
    
    
    CGFloat offset = height - (self.view.frame.size.height - (self.textfield5.frame.origin.y + self.textfield5.frame.size.height));
    //    NSLog(@"%f",offset);
    if(offset>0){
        
        [self moveUpKeyBoard:offset];
    }else{
        
        if(!(self.textfield5.superview==self.view)){
            
            CGFloat superOffset = height - (H(self.view)-(Y_H(self.textfield5.superview)));
            //            NSLog(@"%f",superOffset);
            if(superOffset>0){
                
                [self moveUpKeyBoard:superOffset];
            }
        }
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.view.frame.origin.y < 0) {
        [self moveDownKeyBoard];
    }
    
    
}

- (void)moveUpKeyBoard:(CGFloat)offset{
    
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
       // self.xingbie = @"1";
    }

}

- (void)selectButtonclick2:(UIButton*)selectButton2 {
    selectButton2.selected = !selectButton2.selected;
    if (selectButton2.selected == YES) {
        self.xingbie = @"1";
        _selectbutton1.selected = NO;
    }else
    {
        
       // self.xingbie = @"0";
    }
    
}

//点击了保存按钮
- (void)rightClick {
    if ([Utils isEmptyString:self.textfield1.text]) {
        [MBProgressHUD showToast:self.textfield1.placeholder];
        return;
    }
    if ([Utils isEmptyString:self.textfield2.text]) {
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

    NSString *url = [NSString stringWithFormat:@"%@/app/patient/mycenter/myinfosave",KCBaseURLString];
    NSDictionary *paramters = @{@"nickname":self.textfield1.text,@"name":self.textfield2.text,@"sex":self.xingbie,@"birthday":self.textfield3.text,@"idcard":self.textfield4.text,@"alipay":self.textfield5.text};
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        if ([[responseObject objectForKey:@"STATE"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
    
}
- (void)submithead {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择图片方法" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ablumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //调用系统相册
        UIImagePickerController *pickerController = [UIImagePickerController new];
        //设置选取的照片是否可编辑
        pickerController.allowsEditing = YES;
        //设置相册呈现样式
        pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;  // 照片分组样式
        //UIImagePickerControllerSourceTypePhotoLibrary,  直接全部呈现出系统相册
        //UIImagePickerControllerSourceTypeCamera,  调取摄像头
        
        //选择完成图片或者点击取消按钮都是通过代理来操作我们需要的逻辑过程
        pickerController.delegate = self;
        // 使用模态呈现相册
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *cameraPickerVC = [UIImagePickerController new];
        cameraPickerVC.delegate = self;
        cameraPickerVC.allowsEditing = YES;
        
        
        //是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            cameraPickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:cameraPickerVC animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:ablumAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
   
}


#pragma mark - UIImagePickerControllerDelegate
//选择完成图片之后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    // 保存图片至本地，方法见下文
    [self saveImage:resultImage withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImageView *btn = (UIImageView *)[self.view viewWithTag:1231];
    btn.image = [savedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSString *memberId = [self.dict objectForKey:@"id"];
    NSString *path = [NSString stringWithFormat:@"%@%@", kBaseDownPath, kHeadChangePath];
    NSDictionary *parameters = @{@"memberId": memberId};
    
    NSLog(@"_personModel.ID:%@", memberId);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //将图片以表单形式上传
        NSData *data1=[NSData dataWithContentsOfFile:fullPath];
        [formData appendPartWithFileData:data1 name:@"file" fileName:@"file.jpg" mimeType:@"image/png"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.originalRequest);

        [kAppdelegate.window showWarning:[responseObject objectForKey:@"MSG"]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[responseObject objectForKey:@"CONTENT"] forKey:@"headChange"];
        [defaults synchronize];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {

            [kAppdelegate.window showWarning:@"当前没有网络!"];
            NSLog(@"%@", error.localizedDescription);
        }
        NSLog(@"%@", task.originalRequest);
        
    }];
    
    
}

// 点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
