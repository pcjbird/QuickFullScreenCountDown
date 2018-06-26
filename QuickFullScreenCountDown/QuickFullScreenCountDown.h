//
//  QuickFullScreenCountDown.h
//  QuickFullScreenCountDown
//
//  Created by pcjbird on 2018/6/26.
//  Copyright © 2018年 Zero Status. All rights reserved.
//
//  框架名称:QuickFullScreenCountDown
//  框架功能:A full screen count down view for iOS. 一款全屏倒计时视图，须在Info.plist中增加后台模式支持, 常见于运动类 App 中。
//  修改记录:
//     pcjbird    2018-06-26  Version:1.0.2 Build:201806260003
//                            1.修正Info.plist未配置错误提示。
//
//     pcjbird    2018-06-26  Version:1.0.1 Build:201806260002
//                            1.完善项目描述。
//
//     pcjbird    2018-06-26  Version:1.0.0 Build:201806260001
//                            1.首次发布SDK版本


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

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
