//
//  QuickFullScreenCountDown.h
//  QuickFullScreenCountDown
//
//  Created by pcjbird on 2018/6/26.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for QuickFullScreenCountDown.
FOUNDATION_EXPORT double QuickFullScreenCountDownVersionNumber;

//! Project version string for QuickFullScreenCountDown.
FOUNDATION_EXPORT const unsigned char QuickFullScreenCountDownVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <QuickFullScreenCountDown/PublicHeader.h>

@class QuickFullScreenCountDown;

/**
 * @brief 倒计时开始时调的block
 * @param countdown 倒计时视图
 */
typedef void(^QuickFullScreenCountDownBeginBlock)(QuickFullScreenCountDown *countdown);

/**
 * @brief 倒计时完成时调的block
 * @param countdown 倒计时视图
 */
typedef void(^QuickFullScreenCountDownSuccessBlock)(QuickFullScreenCountDown *countdown);

/**
 * @brief 全屏倒计时
 */
@interface QuickFullScreenCountDown : UIView

/**
 * @brief 设置数字颜色
 * @param color 数字颜色
 */
+ (void)setNumberColor:(UIColor*)color;

/**
 * @brief 设置数字字体
 * @param font 字体
 */
+ (void)setNumberFont:(UIFont*) font;

/**
 * @brief 设置背景颜色
 * @param color 背景颜色
 */
+ (void)setBackgroundColor:(UIColor*)color;

/**
 * @brief 播放
 */
+ (instancetype)play;

/**
 * @brief 播放
 * @param number 倒计时开始数字
 */
+ (instancetype)playWithNumber:(NSInteger)number;

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle;

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number success:(QuickFullScreenCountDownSuccessBlock)success;

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle success:(QuickFullScreenCountDownSuccessBlock)success;

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 * @param begin 倒计时开始回调
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle begin:(QuickFullScreenCountDownBeginBlock)begin success:(QuickFullScreenCountDownSuccessBlock)success;

@end
