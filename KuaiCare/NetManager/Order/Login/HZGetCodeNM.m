//
//  HZGetCodeNM.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZGetCodeNM.h"

@implementation HZGetCodeNM


+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(id, NSError *))completionHandler {
    NSLog(@"%@, %@", UUID, phoneNumber);
    NSDictionary *randomDic = @{@"phone": phoneNumber, @"uniqueCode": UUID};
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kRandomCode];
    return  [self POST:path parameters:randomDic downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
    
}


+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber codeNumber:(NSString *)codeNumber password:(NSString *)password completionHandler:(void (^)(id, NSError *))completionHandler {
    NSDictionary *registerDic = @{@"phone": phoneNumber, @"userPass": password, @"uniqueCode": UUID, @"randomCode": codeNumber};
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kRegisterPath];
    return [self POST:path parameters:registerDic downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


+ (id)getLoginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completionHandler:(void (^)(id, NSError *))completionHandler {
    NSDictionary *loginDic = @{@"phone": phoneNumber, @"userPass": password};
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kLoginPath];
    return [self POST:path parameters:loginDic downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


+ (id)logoutCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kLogOutPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)forgetPasswordWithPhone:(NSString *)phone userPass:(NSString *)userPass randomCode:(NSString *)randomCode completionHandler:(void(^)(id model, NSError *error))completionHandler {
    NSDictionary *forgetDic = @{@"phone": phone, @"userPass": userPass, @"randomCode": randomCode};
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kForgetPath];
    return [self POST:path parameters:forgetDic downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}



+ (id)getRandomCodeWithUUID:(NSString *)UUID flag:(NSString *)flag phoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(id, NSError *))completionHandler {
    
    NSDictionary *randomDic = @{@"phone": phoneNumber, @"uniqueCode": UUID, @"flag": @"changePassword"};
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kRandomCode];
    return  [self POST:path parameters:randomDic downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
    
}

+ (id)getPwdByPhoneWithUUID:(NSString *)UUID codeNumber:(NSString *)codeNumber newPassword:(NSString *)newPassword phoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kPwdByPhonePath];
    NSDictionary *parameters = @{@"uniqueCode": UUID, @"randomCode": codeNumber, @"newpwd": newPassword, @"phone": phoneNumber};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


+ (id)getPwdByOldPwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kPwdByOldPwdPath];
    NSDictionary *paramters = @{@"oldpwd": oldPwd, @"newpwd": newPwd};
    return [self POST:path parameters:paramters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


@end
