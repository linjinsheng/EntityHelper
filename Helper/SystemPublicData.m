//
//  SystemPublicData.m
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/25.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "SystemPublicData.h"

@implementation SystemPublicData

#pragma mark - ******** 单例

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static SystemPublicData *sharedInstance;
    
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
    return [SystemPublicData sharedInstance];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (UIImage *)defaultImage
{
    if (_defaultImage == nil)
    {
        _defaultImage = [UIImage imageNamed:@"i_logo"];
    }
    
    return _defaultImage;
}

- (UIImage *)defaultAvatar
{
    if (_defaultAvatar == nil)
    {
        _defaultAvatar = [UIImage imageNamed:@"i_logo"];
    }
    
    return _defaultAvatar;
}

- (AccountModel *)accountModel
{
    if ([AccountModel isLogin])
    {
        return [AccountModel getAccountInfo];
    }
    
    return nil;
}

@end
