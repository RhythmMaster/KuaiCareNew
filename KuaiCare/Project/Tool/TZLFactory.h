//
//  TZLFactory.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/7/29.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSigner.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>



@interface TZLFactory : NSObject

+ (long long)fileSizeAtPath:(NSString *)filePath;
+ (float)folderSizeAtPath:(NSString *)folderPath;



//获取UUID
+ (NSString *)getUniqueStrByUUID;




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




// 简单的MD5加密




//支付宝
- (void)AlipayWithOrderCode:(NSString *)orderCode;






@end
