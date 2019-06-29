//
//  HUDHelper.m
//  Sale_app
//
//  Created by targetios on 2018/8/31.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "HUDHelper.h"
#import "MBProgressHUD.h"
#import "UIColor+Extra.h"

static MBProgressHUD *_progressHUD;

@implementation HUDHelper

+ (void)show
{
    [self showHUDAndTip:nil];
}

+ (void)showTip:(NSString *)tipString
{
    [self showInView:[UIApplication sharedApplication].delegate.window
       showIndicator:NO
                 tip:tipString
      hideAfterDelay:kHUDAutoHideAfterDelay
            animated:YES];
}

+ (void)showHUDAndTip:(NSString *)tipString
{
    [self showInView:[UIApplication sharedApplication].delegate.window
       showIndicator:YES
                 tip:tipString
            animated:YES];
}

+ (void)showInView:(UIView *)view
{
    [self showInView:view
       showIndicator:YES
                 tip:nil
            animated:YES];
}

+ (void)showTip:(NSString *)tipString inView:(UIView *)view
{
    [self showInView:view
       showIndicator:NO
                 tip:tipString
      hideAfterDelay:kHUDAutoHideAfterDelay
            animated:YES];
}

+ (void)showHUDAndTip:(NSString *)tipString inView:(UIView *)view
{
    [self showInView:view
       showIndicator:YES
                 tip:tipString
            animated:YES];
}

+ (void)showInView:(UIView *)view
     showIndicator:(BOOL)showIndicator
               tip:(NSString *)tipString
          animated:(BOOL)animated
{
    [self showInView:view
       showIndicator:showIndicator
                 tip:tipString
      hideAfterDelay:0
            animated:animated];
}

+ (void)showInView:(UIView *)view
     showIndicator:(BOOL)showIndicator
               tip:(NSString *)tipString
    hideAfterDelay:(NSTimeInterval)delay
          animated:(BOOL)animated
{
    [self hide];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.userInteractionEnabled = YES;
    [hud addGestureRecognizer:[UITapGestureRecognizer new]];
    [hud.label setNumberOfLines:0];
    [hud.label setFont:[UIFont systemFontOfSize:14]];
    [hud setContentColor:[UIColor whiteColor]];//设置文字颜色
//    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
    //设置等待框背景色为黑色
    [hud.bezelView setBackgroundColor:[UIColor colorWithHex:0x262A34]];
    [hud setRemoveFromSuperViewOnHide:YES];
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    
    if (tipString.length > 0)
    {
        hud.label.text = LocalizedString(tipString);
        hud.mode = MBProgressHUDModeText;
    }
    else
    {
        hud.mode = MBProgressHUDModeIndeterminate;
    }

    if (showIndicator)
    {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (delay > 0)
    {
        [hud hideAnimated:animated afterDelay:delay];
    }
    
    _progressHUD = hud;
}

+ (void)hide
{
    if (_progressHUD != nil)
    {
        [_progressHUD hideAnimated:YES];
        _progressHUD = nil;
    }
}

@end
