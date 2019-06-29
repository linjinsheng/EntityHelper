//
//  SystemPublicData.h
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/25.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConfigRequestHelper.h"

@interface SystemPublicData : NSObject

/** 默认图片 */
@property (nonatomic, strong) UIImage *defaultImage;
/** 默认头像 */
@property (nonatomic, strong) UIImage *defaultAvatar;

//app全局配置
@property (nonatomic, strong) AppConfigModel *config;

//账号实体
@property (nonatomic, strong) AccountModel *accountModel;

+ (instancetype)sharedInstance;

@end
