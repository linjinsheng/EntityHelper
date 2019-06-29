//
//  AppDelegate+Helper.h
//  Sale_app
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Helper)

//iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
- (void)configUIScrollView;

- (void)configGlobalKeyboardManager;

//ios10 之后网络权限
- (void)monitoringNetworkAccessCompletionHandler:(void(^)(BOOL haveNet))handler;

- (void)configUmengAnalytics;

@end
