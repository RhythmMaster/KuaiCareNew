//
//  AddressBookViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/15.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);

@protocol ChangeStatus <NSObject>
//代理方法
- (void)changeStatus:(NSString *)isOn phone:(NSString *)phone;
@end

@interface AddressBookViewController : UIViewController
@property (nonatomic ,copy) myBlock block;
@property (nonatomic,assign) id <ChangeStatus> delegate;
@end
