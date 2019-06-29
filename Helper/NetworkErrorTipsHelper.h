//
//  NetworkErrorTipsHelper.h
//  Sale_app
//
//  Created by targetios on 2018/9/10.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkErrorTipsHelper : NSObject

/** 根据error生成可展示给用户的文案 */
+ (NSString *)tipWithError:(NSError *)error;

/** 根据error生成可展示给用户的文案，并直接显示该提示到 keywindow 中，并在默认的时间后隐藏提示 */
+ (void)showTipWithError:(NSError *)error;

@end
