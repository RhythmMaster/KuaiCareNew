//
//  PersonDetailViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock) ();

@interface PersonDetailViewController : UIViewController

@property(nonatomic, copy) refreshBlock block;

@end
