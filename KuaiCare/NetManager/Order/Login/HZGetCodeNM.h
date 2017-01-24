//
//  HZGetCodeNM.h
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HZGetCodeNM : NSObject
//获取验证码
+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber completionHandler:(void(^)(id model, NSError *error))completionHandler;
//注册
+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber codeNumber:(NSString *)codeNumber password:(NSString *)password completionHandler:(void(^)(id model, NSError *error))completionHandler;
//登录
+ (id)getLoginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completionHandler:(void(^)(id model, NSError *error))completionHandler;

+ (id)logoutCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

//忘记密码
+ (id)forgetPasswordWithPhone:(NSString *)phone userPass:(NSString *)userPass randomCode:(NSString *)randomCode completionHandler:(void(^)(id model, NSError *error))completionHandler;



//手机号码修改密码获取验证码
+ (id)getRandomCodeWithUUID:(NSString *)UUID flag:(NSString *)flag phoneNumber:(NSString *)phoneNumber completionHandler:(void(^)(id model, NSError *error))completionHandler;


//手机号码修改
+ (id)getPwdByPhoneWithUUID:(NSString *)UUID codeNumber:(NSString *)codeNumber newPassword:(NSString *)newPassword phoneNumber:(NSString *)phoneNumber completionHandler:(void(^)(id model, NSError *error))completionHandler;


//新旧密码修改
+ (id)getPwdByOldPwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
