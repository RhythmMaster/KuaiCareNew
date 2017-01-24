//
//  TZLFactory.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/7/29.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "TZLFactory.h"

@implementation TZLFactory

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//计算文件夹的大小
+ (float)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}







+ (NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
}


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




- (void)AlipayWithOrderCode:(NSString *)orderCode {
    
   
    
}










@end
