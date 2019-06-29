//
//  GlobalConfigRequestHelper.m
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/25.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "GlobalConfigRequestHelper.h"
#import "ProvinceOrCityModel.h"

@implementation AppConfigModel

@end

@implementation AppVersionModel

@end


//
@implementation GlobalConfigRequestHelper

+ (void)requestAppConfig
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObjectExtra:@"IOS" forKey:@"appType"];
    
    [[NetWorkEngine sharedInstance] requestInterfaceWithURL:kGlogalConfigURL baseURL:nil param:params requestMethod:HttpRequestMethodPost completionHandler:^(NSDictionary *requestParam, NSError *error, id responseResult)
     {
         if (error == nil)
         {
             AppConfigModel *model = [AppConfigModel mj_objectWithKeyValues:responseResult];
             
             [[SystemPublicData sharedInstance] setConfig:model];
         }
     }];
}

+ (void)requestCurrentVersionCompletion:(void (^)(AppVersionModel *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObjectExtra:@"IOS" forKey:@"appType"];
    
    [[NetWorkEngine sharedInstance] requestInterfaceWithURL:kAppVersionURL baseURL:nil param:params requestMethod:HttpRequestMethodPost completionHandler:^(NSDictionary *requestParam, NSError *error, id responseResult) {
        if (error == nil)
        {
            AppVersionModel *model = [AppVersionModel mj_objectWithKeyValues:responseResult];
            
            if (completion != nil)
            {
                completion(model);
            }
        }
    }];
}

+ (void)requestSendMessageWithType:(MessageType)type
                       countryCode:(NSString *)countryCode
                       phoneNumber:(NSString *)phoneNumber
                        completion:(void (^)(NSError *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *mobileParams = [NSMutableDictionary dictionary];
    [mobileParams setObjectExtra:countryCode forKey:@"areaCode"];
    [mobileParams setObjectExtra:phoneNumber forKey:@"number"];
    
    [params setObjectExtra:mobileParams forKey:@"mobile"];

    if (type != MessageType_Register)
    {
        [params setObjectExtra:@1 forKey:@"isCheckExist"];
    }
    else
    {
        [params setObjectExtra:@0 forKey:@"isCheckExist"];
    }
    
    [[NetWorkEngine sharedInstance] requestInterfaceWithURL:kSendMessageURL baseURL:nil param:params requestMethod:HttpRequestMethodPost completionHandler:^(NSDictionary *requestParam, NSError *error, id responseResult) {
        if (completion != nil)
        {
            completion(error);
        }
    }];
}

+ (NSString *)valueStringWithType:(MessageType)type
{
    if (type == MessageType_Register)
    {
        return @"Register";
    }
    else if (type == MessageType_ForgetPassword)
    {
        return @"Password";
    }
    else if (type == MessageType_ForgetTradePassword)
    {
        return @"TradePwd";
    }
    
    return @"Modify";
}

+ (NSString *)signValueWithPhoneNumber:(NSString *)phoneNumber
{
    NSMutableString *sign = [NSMutableString string];
    
    [sign appendString:@"F87EC8850FC94F78935DF71711808474"];
    [sign appendString:[NSString nowDateTimestamp]];
    [sign appendString:phoneNumber];
    [sign appendString:@"F87EC8850FC94F78935DF71711808474"];
    
    NSLog(@"sign===%@",sign.copy);
    
    return [sign.copy md5_32BitValue];
}

@end
