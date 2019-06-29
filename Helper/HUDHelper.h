//
//  HUDHelper.h
//  Sale_app
//
//  Created by targetios on 2018/8/31.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 默认自动隐藏的时间 */
static NSTimeInterval const kHUDAutoHideAfterDelay =1.0;

@interface HUDHelper : NSObject

/** 显示默认样式，不会自动隐藏 */
+ (void)show;

/**
 *  显示文本，默认的时间后自动隐藏
 *  showInView: keywindow    hideAfterDelay: kHideHUDAfterDelay    animated: YES
 *
 *  @see showInView:showIndicator:tip:hideAfterDelay:animated:
 */
+ (void)showTip:(NSString *)tipString;

/**
 *  同时显示菊花和文本，不自动隐藏
 *  showInView: keywindow    showIndicator: YES    animated: YES
 *
 *  @see showInView:showIndicator:tip:animated:
 */
+ (void)showHUDAndTip:(NSString *)tipString;

/**
 *  在指定view中显示默认样式，不会自动隐藏
 *
 *  @see showInView:showIndicator:tip:hideAfterDelay:animated:
 */
+ (void)showInView:(UIView *)view;

/**
 *  在指定view中显示文本，默认的时间后自动隐藏，显示时阻止整个view交互
 *  showInView: keywindow    hideAfterDelay: kHideHUDAfterDelay    animated: YES
 *
 *  @see showInView:showIndicator:tip:hideAfterDelay:animated:
 */
+ (void)showTip:(NSString *)tipString inView:(UIView *)view;

/**
 *  在指定view中同时显示菊花和文本，不自动隐藏，显示时阻止整个view交互
 *  showInView: keywindow    showIndicator: YES    animated: YES
 *
 *  @see showInView:showIndicator:tip:animated:
 */
+ (void)showHUDAndTip:(NSString *)tipString inView:(UIView *)view;

/**
 *  在指定view中显示hud，不自动隐藏
 *  hideAfterDelay: 0
 *
 *  @param showIndicator 是否显示活动指示器（菊花）
 *
 *  @see showInView:showIndicator:tip:hideAfterDelay:animated:
 */
+ (void)showInView:(UIView *)view
     showIndicator:(BOOL)showIndicator
               tip:(NSString *)tipString
          animated:(BOOL)animated;

/**
 *  在指定view中显示hud
 *
 *  @param view          需要显示hud的view
 *  @param showIndicator 是否显示活动指示器（菊花）
 *  @param tipString     需要显示的提示文本 （如果传入的文本 length 为 0，则不显示文本，必显示菊花）
 *  @param delay         自动消失的时间，单位：秒；如果为 0，则不自动消失
 *  @param animated      是否使用动画
 */
+ (void)showInView:(UIView *)view
     showIndicator:(BOOL)showIndicator
               tip:(NSString *)tipString
    hideAfterDelay:(NSTimeInterval)delay
          animated:(BOOL)animated;

/** 隐藏所有hud */
+ (void)hide;

@end
