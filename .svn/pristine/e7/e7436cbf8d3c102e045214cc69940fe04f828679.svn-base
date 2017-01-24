//
//  TimeBasic.m
//  ATLife
//
//  Created by Aisino on 16/10/26.
//  Copyright © 2016年 Aisino. All rights reserved.
//


#import "TimeBasic.h"
@interface TimeBasic()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UILabel *cyleLabe;

/**状态的介绍*/
@property (nonatomic, strong) UILabel *instroduLabel;

/**状态的时间*/
@property (nonatomic, strong) UILabel *timeLabel;

@end
@implementation TimeBasic


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame: frame]) {
        
        [self addChids];
    }
    
    return self;
    
}

-(void)addChids{
    
    //画圆圈
    UIView *cycleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 15, 15)];
    CGFloat cx = CGRectGetWidth(cycleView.frame);
    cycleView.backgroundColor = [UIColor clearColor];
    [self addSubview:cycleView];
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    //线宽
    CGFloat lineWith = 2.0f;
    _shapeLayer.lineWidth = lineWith;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:cycleView.bounds];
    _shapeLayer.path = path.CGPath;
    [cycleView.layer addSublayer:_shapeLayer];
    
    //圆圈里面的图片
    CGFloat clx = (cx - 10 ) * 0.5;
    _cyleLabe = [[UILabel alloc]initWithFrame:CGRectMake(clx, clx, 10, 10)];
    _cyleLabe.font = [UIFont boldSystemFontOfSize:11.0];
    _cyleLabe.text = _nameStr ? _nameStr : @"1";
    _cyleLabe.textAlignment = NSTextAlignmentCenter;
    [cycleView addSubview:_cyleLabe];
    
    //尾部
    CGFloat lasty = CGRectGetMidY(cycleView.frame) - 2;
    CGFloat lastW = CGRectGetWidth(self.frame) - cx;
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cycleView.frame), lasty, lastW, 2)];
    _lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineView];
    
    //说明文字
    _instroduLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, 35, CGRectGetWidth(_lineView.bounds) + 20, 20)];
    _instroduLabel.font = [UIFont systemFontOfSize:13.0];
    //    _instroduLabel.textAlignment = NSTextAlignmentCenter;
    _instroduLabel.textColor = [UIColor grayColor];
    _instroduLabel.textAlignment = NSTextAlignmentLeft;
    
    _instroduLabel.text = _nameStr ? _nameStr : @"未知";
    
    
    [self addSubview:_instroduLabel];
    //说明时间
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(-20, 48, CGRectGetWidth(_lineView.bounds) + 40, 20)];
    _timeLabel.font = [UIFont systemFontOfSize:11.0];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    
    _instroduLabel.text = _stateTime ? _stateTime : @"未知";
    
    
    [self addSubview:_timeLabel];
    
}


- (void)setCompleteColor:(UIColor *)completeColor {
    _completeColor = completeColor;
    // 填充色
    _shapeLayer.strokeColor = completeColor.CGColor;
//    _instroduLabel.textColor = completeColor;
    _cyleLabe.textColor = completeColor;
    _lineView.backgroundColor = completeColor;
    
    
}

- (void)setNameStr:(NSString *)nameStr {
    
    _nameStr = nameStr;
    //    NSLog(@"123=====%@",_nameStr);
    
    _cyleLabe.text = nameStr;
    
}

- (void)setStateStr:(NSString *)stateStr {
    
    _stateStr = stateStr;

    _instroduLabel.text = _stateStr;
    
}

-(void)setStateTime:(NSString *)stateTime{
    
    _stateTime =  stateTime;
    _timeLabel.text  = _stateTime;
}

@end
