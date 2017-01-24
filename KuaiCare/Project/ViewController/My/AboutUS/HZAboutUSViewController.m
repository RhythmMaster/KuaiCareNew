//
//  HZAboutUSViewController.m
//  dddd
//
//  Created by tang on 16/12/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZAboutUSViewController.h"

#import "HZMyCenterIndexNetManager.h"

@interface HZAboutUSViewController ()

@property(nonatomic) UIButton *contentLb;

@end

@implementation HZAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [HZMyCenterIndexNetManager getAboutUSWithCompletionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        NSString *string = [model objectForKey:@"CONTENT"];
        [self.contentLb setTitle:string forState:UIControlStateNormal];
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)contentLb {
    if (!_contentLb) {
        _contentLb = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(15);
            make.right.equalTo(-15);
        }];
        _contentLb.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _contentLb.layer.borderColor = kGrayColor.CGColor;
        _contentLb.layer.borderWidth = 0.8;
        _contentLb.layer.cornerRadius = 10;
        _contentLb.clipsToBounds = YES;
        _contentLb.titleLabel.numberOfLines = 0;
        _contentLb.enabled = NO;
        [_contentLb setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    return _contentLb;
}

@end
