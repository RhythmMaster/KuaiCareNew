//
//  Utils.m
//  定制公交
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 KL. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//UIColor 转UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//根据 宽度， 字体大小 计算一段文字的高度
+(CGFloat)getTextHeightWithFont:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font{

    CGSize size = CGSizeMake(width,MAXFLOAT);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize messageSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return messageSize.height;
}
//判断是否是手机号
+ (BOOL)isInvalidPhoneNumber:(NSString*)phoneNumber{
    
    if(phoneNumber==nil||[phoneNumber isEqualToString:@""]){
        
        return false;
    }
    if(phoneNumber.length < 11){
        
        return false;
    }
    
    return true;
}
//判断是否是身份证号
+(BOOL)isInvalidshenFenNumber:(NSString*)shenFenNumber
{
    if(shenFenNumber==nil||[shenFenNumber isEqualToString:@""]){
        
        return false;
    }
    if(shenFenNumber.length < 18){
        
        return false;
    }
    
    return true;

    
}
//判断是否是合法的验证码
+ (BOOL)isInvalidRegisterCode:(NSString*)registerCode{

    if(registerCode==nil||[registerCode isEqualToString:@""]){
        
        return false;
    }
    return true;
}
//判断密码是否符合规则
+ (BOOL)isInvalidPassWord:(NSString*)password{
    
    if(password==nil||[password isEqualToString:@""]){
        
        return false;
    }
    return true;

}

//判断是否为空字符串
+ (BOOL)isEmptyString:(NSString*)string{

    if(string==nil || [string isEqualToString:@""]){
    
        return true;
    }
    return false;
}

//将字符串转换成nsdate 如@"1992-05-21 13:08:08"
+(NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}


@end
