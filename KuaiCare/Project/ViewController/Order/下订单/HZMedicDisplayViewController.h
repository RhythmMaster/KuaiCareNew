//
//  HZMedicDisplayViewController.h
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
@interface HZMedicDisplayViewController : UIViewController
@property(nonatomic) NSString *medicId;
@property (nonatomic ,copy) myBlock block1;
@property (nonatomic ,copy) myBlock block2;
@property (nonatomic ,copy) myBlock block3;
@property (nonatomic ,copy) myBlock block4;
@end
