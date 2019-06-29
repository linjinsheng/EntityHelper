//
//  DeviceUniqueIdentifierHelper.h
//  Sale_app
//
//  Created by eddy_Mac on 2018/8/24.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUniqueIdentifierHelper : NSObject

/*
 从钥匙串取设备id
 */
+ (id)readDeviceUniqueIdentifier;

@end
