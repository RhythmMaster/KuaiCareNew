//
//  SuggestViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SuggestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSTextView.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
@interface SuggestViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)JSTextView *textView ;
@property (nonatomic ,copy)NSString *textString;
@property (nonatomic ,strong)UIButton *submitButton;
@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"意见反馈";

    
    [self initUI];
}
-(void)initUI
{

    _textView = [[JSTextView alloc] initWithFrame:CGRectZero];
    _textView.placeholder = @"请输入您的反馈意见，我们将持续改进。。。";
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 1;
    _textView.placeholerColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:16];
    [_textView.layer setCornerRadius:10];
    _textView.delegate = self;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    _textView.scrollEnabled = NO;//设置是否可以滑动
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(50);
        make.left.equalTo(25);
        make.right.equalTo(-25);
        make.height.equalTo(KCHEIGHT*0.25);
    }];
    
    self.submitButton = [[UIButton alloc] init];
    self.submitButton.layer.cornerRadius = 20;
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.frame = CGRectZero;
    [self.submitButton setTitle:@"提交意见" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = RGB(38, 107, 255);
    [self.submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    [self.submitButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-100);
        make.left.equalTo(KCWIDTH*0.3);
        make.right.equalTo(-KCWIDTH*0.3);
        make.height.equalTo(40);
    }];
      NSLog(@"dd%@",self.textString);

      self.submitButton.enabled= NO;
    
    
    
}
//开始编辑

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
//结束编辑

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.textString = textView.text;
    NSLog(@"%@",self.textString);
    self.submitButton.enabled = YES;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textView resignFirstResponder];
}
//点击了提交按钮
- (void)submitClick {
    [MBProgressHUD showMessage:Net_Connecting];

    NSString *urlString = [NSString stringWithFormat:@"%@/app/common/advicefeedback",KCBaseURLString];
    if (self.textString.length == 0) {
        self.textString = @"";
    }
    NSDictionary *dict = @{@"feedbackReason":self.textString};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:[responseObject objectForKey:@"MSG"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    
}
-(void)leftClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
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
