//
//  CameraHelper.h
//  Buy
//
//  Created by BinghongLee on 16/3/11.
//  Copyright © 2016年 KuGou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraHelper : NSObject
/**
 *  检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 *
 *  @return bool
 */
+ (void)checkPhotoLibraryAuthorizationStatusCompletion:(void (^)(BOOL authorizationStatus))completion;

/**
 *  检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 *
 *  @return bool
 */
+ (BOOL)checkCameraAuthorizationStatus;

@end
