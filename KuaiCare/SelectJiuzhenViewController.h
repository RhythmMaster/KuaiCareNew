//
//  SelectJiuzhenViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
@interface SelectJiuzhenViewController : UIViewController
//判断是否从个人中心进入,是就不能回调(不然会崩哦,小伙子乱回调可不好)
@property(nonatomic) BOOL isCenterVC;

@property (nonatomic ,copy) myBlock block1;
@property (nonatomic ,copy) myBlock block2;
@property (nonatomic ,copy) myBlock block3;
@property (nonatomic ,copy) myBlock block4;
@property (nonatomic ,copy) myBlock block5;


@end
