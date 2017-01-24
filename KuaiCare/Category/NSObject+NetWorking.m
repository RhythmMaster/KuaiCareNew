//
//  NSObject+NetWorking.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSObject+NetWorking.h"

@implementation NSObject (NetWorking)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:kBasePath.tzl_URL];
    manager.requestSerializer.timeoutInterval = 9;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        
        //NSLog(@"%@", task.originalRequest);
        !completionHandler ?: completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        //NSLog(@"%@", task.originalRequest);
        if (error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
            hud.labelText = @"当前没有网络!";
            //提示框风格
            hud.mode = MBProgressHUDModeText;
            //提示1.5秒钟
            [hud hide:YES afterDelay:1.5];
        }
        !completionHandler ?: completionHandler(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 9;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
        !completionHandler ?: completionHandler(responseObject, nil);
//        NSLog(@"%@", responseObject);
        
        //目前的作用是为了在用户掉线或未登录状态提醒用户未登录并提示跳转到登录页面(才发现AppDelegate的作用,很牛的样子,不知道有没有后遗症啊)
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSInteger state = [[responseObject objectForKey:@"STATE"] integerValue];
        if (state != 1) {
            
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"未登录,请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
 
                LoginViewController *loginvc = [[LoginViewController alloc] init];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginvc];
                app.window.rootViewController = navi;
                
        }];
        [alertController addAction:logoutAction];
        [app.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            
            
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"未登录,请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                LoginViewController *loginvc = [[LoginViewController alloc] init];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginvc];
                kAppdelegate.window.rootViewController = navi;
                
            }];
            [alertController addAction:logoutAction];
            [kAppdelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"未登录,请重新登录!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *loginvc = [[LoginViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginvc];
            kAppdelegate.window.rootViewController = navi;
            
        }];
        [alertController addAction:logoutAction];
        [kAppdelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        !completionHandler ?: completionHandler(nil, error);
    }];
    
}



@end
