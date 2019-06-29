//
//  DeviceTypeHelper.h
//  Sale_app
//
//  Created by targetios on 2018/9/17.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DeviceType)
{
    Unknown = 0,
    Simulator,
    IPhone_5,
    IPhone_5C,
    IPhone_5S,
    IPhone_SE,
    IPhone_6,
    IPhone_6P,
    IPhone_6s,
    IPhone_6s_P,
    IPhone_7,
    IPhone_7P,
    IPhone_8,
    IPhone_8P,
    IPhone_X,
};

@interface DeviceTypeHelper : NSObject

+ (DeviceType)deviceType;

@end
