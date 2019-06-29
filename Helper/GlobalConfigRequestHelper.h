//
//  GlobalConfigRequestHelper.h
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/25.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

//验证码类型
typedef NS_ENUM(NSInteger, MessageType)
{
    MessageType_Register, //注册
    MessageType_ForgetPassword, //忘记密码
    MessageType_ModifyPassowrd, //修改密码
    
    MessageType_ForgetTradePassword, //忘记交易密码
};

//app全局配置信息
@interface AppConfigModel : NSObject

//项目地址
@property (nonatomic, copy) NSString *dynSite;

//小图图片路径
@property (nonatomic, copy) NSString *imageSmallUrlPath;

//图片路径
@property (nonatomic, copy) NSString *imageUrlPath;

//版本
@property (nonatomic, copy) NSString *appVersionCode;

//版本号
@property (nonatomic, copy) NSString *appVersion;

//app下载路径
@property (nonatomic, copy) NSString *appUrl;

@end

//版本信息
@interface AppVersionModel : NSObject

//version唯一code值
@property (nonatomic, copy) NSString *versionCode;

//版本号
@property (nonatomic, copy) NSString *version;

//app下载路径
@property (nonatomic, copy) NSString *appUrl;

//版本更新内容
@property (nonatomic, copy) NSString *content;

@end

//
@interface GlobalConfigRequestHelper : NSObject

//请求全局配置
+ (void)requestAppConfig;

//请求最新版本
+ (void)requestCurrentVersionCompletion:(void (^)(AppVersionModel *))completion;

//发送验证码
+ (void)requestSendMessageWithType:(MessageType)type
                       countryCode:(NSString *)countryCode
                       phoneNumber:(NSString *)phoneNumber
                        completion:(void (^)(NSError *error))completion;
@end
