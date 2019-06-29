//
//  CameraHelper.m
//  Buy
//
//  Created by BinghongLee on 16/3/11.
//  Copyright © 2016年 KuGou. All rights reserved.
//

#import "CameraHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation CameraHelper

+ (void)checkPhotoLibraryAuthorizationStatusCompletion:(void (^)(BOOL))completion
{
    if (IS_IOS_9_OR_LATER)
    {
        if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized)
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized)
                    {
                        if (completion != nil)
                        {
                            completion(YES);
                        }
                    }
                    else
                    {
                        [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
                        
                        if (completion != nil)
                        {
                            completion(NO);
                        }
                    }
                });
    
            }];
        }
        else
        {
            if (completion != nil)
            {
                completion(YES);
            }
        }
    }
    else
    {
        if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)])
        {
            if ([ALAssetsLibrary authorizationStatus] != ALAuthorizationStatusAuthorized)
            {
                [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
            
                if (completion != nil)
                {
                    completion(NO);
                }
            }
            else
            {
                if (completion != nil)
                {
                    completion(YES);
                }
            }
        }
        else
        {
            if (completion != nil)
            {
                completion(NO);
            }
        }
    }
}

+ (BOOL)checkCameraAuthorizationStatus
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus)
        {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
    
            return NO;
        }
    }
    
    return YES;
}

+ (void)showSettingAlertStr:(NSString *)tipStr
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tipStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
