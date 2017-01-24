//
//  EditViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^noLoginBlock) (NSString *addressInfo, NSString *tel, NSString *name);

@interface EditViewController : UIViewController

@property(nonatomic, copy) noLoginBlock noLoginBlock;

@end
