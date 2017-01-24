//
//  RegisterViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^phoneBlock) (NSString *, NSString *);

@interface RegisterViewController : UIViewController

@property(nonatomic, copy) phoneBlock block;
- (void)phone:(phoneBlock)phoneBlock;

@end
