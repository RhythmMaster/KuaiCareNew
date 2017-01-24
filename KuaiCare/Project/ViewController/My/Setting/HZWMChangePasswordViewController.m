//
//  HZWMChangePasswordViewController.m
//  dddd
//
//  Created by tang on 16/12/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWMChangePasswordViewController.h"

#import "HZPhoneChangeViewController.h"
#import "HZPasswordChangeViewController.h"

@interface HZWMChangePasswordViewController ()

@end

@implementation HZWMChangePasswordViewController


- (NSArray<NSString *> *)titles {
    return @[@"手机修改", @"密码修改"];
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        HZPhoneChangeViewController *phoneChangeVC = [HZPhoneChangeViewController new];
        return phoneChangeVC;
    } else {
        HZPasswordChangeViewController *passwordChangeVC = [HZPasswordChangeViewController new];
        return passwordChangeVC;
    }
    
}

- (UIColor *)titleColorSelected {
    return kRGBA(37, 108, 255, 1.0);
}

- (UIColor *)titleColorNormal {
    return [UIColor grayColor];
}

- (WMMenuViewStyle)menuViewStyle {
    return WMMenuViewStyleLine;
}


- (UIColor *)menuBGColor {
    return [UIColor whiteColor];
}

- (CGFloat)menuHeight {
    return 35;
}

- (CGFloat)progressHeight {
    return 3;
}

- (CGFloat)menuItemWidth {
    return kScreenW * 0.25;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
