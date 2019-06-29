//
//  AccountErrorHelper.m
//  Sale_app
//
//  Created by eddy_Mac on 2018/9/30.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AccountErrorHelper.h"
#import "LoginMainController.h"
#import "CustomNavigationController.h"

typedef NS_ENUM(NSUInteger, AccountErrorType) {
    AccountErrorTypeNotLogin = 10, //用户未登录
    AccountErrorTypeLoginAtOtherDevice //其他设备登录
};


@interface AccountErrorHelper ()<NSCopying, UIAlertViewDelegate>

/** 处理中 */
@property (nonatomic) BOOL isHandling;

@end

@implementation AccountErrorHelper

+ (void)handleErrorIfNeeded:(NSError *)error
{
    if ([[self sharedInstance] isHandling])
    {
        return;
    }
    
    switch (error.code)
    {
        case -4:    // 账号其他设备登录
        {
//            [[self sharedInstance] setIsHandling:YES];
            [AccountModel logout];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_ACCOUNT_UI object:nil];
            });
            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"账号在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction *only = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_ACCOUNT_UI object:nil];
//
//                [[self sharedInstance] setIsHandling:NO];
//            }];
//
//            [alertController addAction:only];
//
//            [[self currentTopRootViewController] presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        case -2:    // 用户未登录
        {
//            [[self sharedInstance] setIsHandling:YES];
            [AccountModel logout];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_ACCOUNT_UI object:nil];
            });
            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction *only = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_ACCOUNT_UI object:nil];
//
//                [[self sharedInstance] setIsHandling:NO];
//            }];
//
//            [alertController addAction:only];
//
//            [[self currentTopRootViewController] presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

+ (UIViewController *)currentTopRootViewController
{
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (controller.presentedViewController != nil)
    {
        controller = controller.presentedViewController;
    }
    
    return controller;
}

#pragma mark - ******** 单例

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static AccountErrorHelper *sharedInstance;
    
    dispatch_once(&once, ^{
        
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [AccountErrorHelper sharedInstance];
}

@end
