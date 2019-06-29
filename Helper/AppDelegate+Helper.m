//
//  AppDelegate+Helper.m
//  Sale_app
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AppDelegate+Helper.h"
#import "IQKeyboardManager.h"
#import<CoreTelephony/CTCellularData.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>

static NSString * const kUmengKey = @"xxx";

@implementation AppDelegate (Helper)

- (void)configUIScrollView
{
    if (@available(iOS 11, *))
    {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}

- (void)configGlobalKeyboardManager
{
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}

- (void)monitoringNetworkAccessCompletionHandler:(void (^)(BOOL))handler
{
    if (IS_IOS_10_OR_LATER && [UIDevice currentDevice].systemVersion.floatValue <= 11.0)
    {
        [self monitoringNetAccessCompletionHandler:handler];
    }
    else
    {
        [self monitoringNetStatusCompletionHandler:handler];
    }
}

- (void)monitoringNetAccessCompletionHandler:(void (^)(BOOL))handler
{
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    
    /*
     此函数会在网络权限改变时再次调用
     */
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        switch (state)
        {
            case kCTCellularDataRestricted:
                //2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                break;
            case kCTCellularDataNotRestricted:
                [self monitoringNetStatusCompletionHandler:handler];
                break;
            case kCTCellularDataRestrictedStateUnknown:
                //2.3未知情况 （还没有遇到推测是有网络但是连接不正常的情况下）
                break;
                
            default:
                break;
        }
    };
}

- (void)monitoringNetStatusCompletionHandler:(void (^)(BOOL))handler
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"网络不通：%@",@(status) );
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"网络通过WIFI连接：%@",@(status));
                if (handler != nil)
                {
                    handler(YES);
                }
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"网络通过蜂窝网络连接：%@",@(status));
                if (handler != nil)
                {
                    handler(YES);
                }
                break;
            }
            default:
                break;
        }
    }];
    
    // 开始网络状态监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)configUmengAnalytics
{
    [UMConfigure initWithAppkey:kUmengKey channel:@"App Store"];
    [MobClick setScenarioType:E_UM_NORMAL];
    
#ifdef DEBUG
    [MobClick setCrashReportEnabled:NO];    //关闭错误统计
#else
    [MobClick setCrashReportEnabled:YES];   //打开错误统计
#endif
}

@end
