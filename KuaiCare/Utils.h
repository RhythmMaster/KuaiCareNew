//
//  Utils.h
//  定制公交
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

//UIColor 转UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color;

//根据 宽度， 字体大小 计算一段文字的高度
+ (CGFloat)getTextHeightWithFont:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font;

//判断是否是身份证号
+(BOOL)isInvalidshenFenNumber:(NSString*)shenFenNumber;

//判断是否是手机号
+ (BOOL)isInvalidPhoneNumber:(NSString*)phoneNumber;

//判断是否是合法的验证码
+ (BOOL)isInvalidRegisterCode:(NSString*)registerCode;

//判断密码是否符合规则
+ (BOOL)isInvalidPassWord:(NSString*)password;

//判断是否为空字符串
+ (BOOL)isEmptyString:(NSString*)string;

//将字符串转换成nsdate 如@"1992-05-21 13:08:08"
+(NSDate *)dateFromString:(NSString *)dateString;


@end
