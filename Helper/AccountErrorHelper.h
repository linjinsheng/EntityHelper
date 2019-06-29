//
//  AccountErrorHelper.h
//  Sale_app
//
//  Created by eddy_Mac on 2018/9/30.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 账号相关请求错误处理，业务方法类 */
@interface AccountErrorHelper : NSObject

+ (void)handleErrorIfNeeded:(NSError *)error;

@end
