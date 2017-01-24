//
//  HZMessageViewController.h
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZMsgNetManager.h"
#import "HZMsgViewModel.h"
typedef void(^backRefreshBlock) ();

@interface HZMessageViewController : UIViewController
@property(nonatomic, copy) backRefreshBlock block;
@end
