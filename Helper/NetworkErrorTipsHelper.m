//
//  NetworkErrorTipsHelper.m
//  Sale_app
//
//  Created by targetios on 2018/9/10.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "NetworkErrorTipsHelper.h"
#import "HUDHelper.h"

@implementation NetworkErrorTipsHelper

+ (NSString *)tipWithError:(NSError *)error
{
    NSString *tip = error.localizedDescription;
    
    switch (error.code)
    {
        case -1001:
            tip = @"网络连接失败了";
            break;
            
        case -1009:
            tip = @"网络连接失败了";
            break;
            
        case 3840:
            tip = @"数据解析失败.";
            break;
            
        case 500000:
            tip = @"数据解析失败.";
            break;
    
        case -1003:
            tip = @"网络连接失败了";
            break;
            
            
        default:
            break;
    }
    
    if (error.code == -999) //请求取消
    {
        tip = nil;
    }
    
    return tip;
}

+ (void)showTipWithError:(NSError *)error
{
    NSString *tip = [self tipWithError:error];
    
    if (tip.length != 0)
    {
        [HUDHelper showTip:tip];
    }
}

@end
