//
//  QuickFullScreenCountDown.m
//  QuickFullScreenCountDown
//
//  Created by pcjbird on 2018/6/26.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "QuickFullScreenCountDown.h"

#define APP_BACKGROUNDMODES ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIBackgroundModes"])
#define SDK_RAISE_EXCEPTION(msg) ([NSException raise:@"[⌚️QuickFullScreenCountDown]" format:@"%@ 【class name:%@, line:%@】",(msg),@(__PRETTY_FUNCTION__),@(__LINE__)])

@interface QuickFullScreenCountDown()

@property(nonatomic, assign) BOOL   shouldContinueWithUIBackgroundModes;

@property(nonatomic, assign) NSInteger number;
@property(nonatomic, strong) NSString* endTitle;
@property(nonatomic, strong) UIFont * font;
@property(nonatomic, strong) UIColor* foreColor;
@property(nonatomic, strong) UIColor* backColor;

@property (nonatomic, copy) QuickFullScreenCountDownSuccessBlock successBlock;
@property (nonatomic, copy) QuickFullScreenCountDownBeginBlock beginBlock;

@property (nonatomic, weak) UILabel* label;
@end

@implementation QuickFullScreenCountDown

static QuickFullScreenCountDown* _sharedInstance = nil;

+ (instancetype)instance
{
    static dispatch_once_t onceToken;
    void(^instanceBlock)(void) = ^{
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
    };
    if ([NSThread isMainThread])
    {
        dispatch_once(&onceToken, instanceBlock);
    }
    else
    {
        if (DISPATCH_EXPECT(onceToken == 0L, NO))
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                dispatch_once(&onceToken, instanceBlock);
            });
        }
    }
    return _sharedInstance;
}

-(id)init
{
    if(self = [super init])
    {
        [self initVariables];
    }
    return self;
}

-(void) initVariables
{
    self.shouldContinueWithUIBackgroundModes = YES;
    self.number = 3;
    self.endTitle = @"";
    self.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * 0.3];
    self.foreColor = [UIColor whiteColor];
    self.backColor = [UIColor colorWithRed:0.11f green:0.61f blue:0.81f alpha:1.00f];
    self.successBlock = nil;
    self.beginBlock = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if([newSuperview isKindOfClass:[UIView class]])
    {
        if(self.shouldContinueWithUIBackgroundModes)
        {
            NSError *error = nil;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
            [[AVAudioSession sharedInstance] setActive:YES error:&error];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnAppEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
}

-(void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}

-(void)OnAppEnterBackground:(NSNotification*)notifiaction
{
    if(self.shouldContinueWithUIBackgroundModes)
    {
        UIApplication*   app = [UIApplication sharedApplication];
        __block    UIBackgroundTaskIdentifier bgTask;
        bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (bgTask != UIBackgroundTaskInvalid)
                {
                    bgTask = UIBackgroundTaskInvalid;
                }
            });
        }];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (bgTask != UIBackgroundTaskInvalid)
                {
                    bgTask = UIBackgroundTaskInvalid;
                }
            });
        });
    }
}

/**
 * @brief 设置数字颜色
 * @param color 数字颜色
 */
+ (void)setNumberColor:(UIColor*)color
{
    [QuickFullScreenCountDown instance].foreColor = color;
}

/**
 * @brief 设置数字字体
 * @param font 字体
 */
+ (void)setNumberFont:(UIFont*) font
{
    [QuickFullScreenCountDown instance].font = font;
}

/**
 * @brief 设置背景颜色
 * @param color 背景颜色
 */
+ (void)setBackColor:(UIColor*)color
{
    [QuickFullScreenCountDown instance].backColor = color;
}

/**
 * @brief 设置UI后台模式是否继续运行
 * @param bContinue 是否继续
 * @since v1.0.5
 */
+ (void)setContinueWithUIBackgroundModes:(BOOL)bContinue
{
    [QuickFullScreenCountDown instance].shouldContinueWithUIBackgroundModes = bContinue;
}

/**
 * @brief 播放
 */
+ (instancetype)play
{
    [QuickFullScreenCountDown playWithNumber:[QuickFullScreenCountDown instance].number endTitle:@"" begin:nil success:nil];
    return [QuickFullScreenCountDown instance];
}

/**
 * @brief 播放
 * @param number 倒计时开始数字
 */
+ (instancetype)playWithNumber:(NSInteger)number
{
    [QuickFullScreenCountDown playWithNumber:number endTitle:@"" begin:nil success:nil];
    return [QuickFullScreenCountDown instance];
}

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle
{
    [QuickFullScreenCountDown playWithNumber:number endTitle:endTitle begin:nil success:nil];
    return [QuickFullScreenCountDown instance];
}

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number success:(QuickFullScreenCountDownSuccessBlock)success
{
    [QuickFullScreenCountDown playWithNumber:number endTitle:@"" begin:nil success:success];
    return [QuickFullScreenCountDown instance];
}

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle success:(QuickFullScreenCountDownSuccessBlock)success
{
    [QuickFullScreenCountDown playWithNumber:number endTitle:endTitle begin:nil success:success];
    return [QuickFullScreenCountDown instance];
}

/**
 * @brief 播放
 * @param number 倒计时开始数字
 * @param endTitle 倒计时结束时显示的字符 例如"Go"
 * @param begin 倒计时开始回调
 * @param success 倒计时完成回调
 */
+ (instancetype)playWithNumber:(NSInteger)number endTitle:(NSString *)endTitle begin:(QuickFullScreenCountDownBeginBlock)begin success:(QuickFullScreenCountDownSuccessBlock)success
{
    [QuickFullScreenCountDown instance].number = number;
    [QuickFullScreenCountDown instance].endTitle = endTitle;
    [QuickFullScreenCountDown instance].beginBlock = begin;
    [QuickFullScreenCountDown instance].successBlock = success;
    
    [[[QuickFullScreenCountDown instance] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [QuickFullScreenCountDown instance].opaque = NO;
    [QuickFullScreenCountDown instance].backgroundColor =  [[QuickFullScreenCountDown instance].backColor isKindOfClass:[UIColor class]] ? [QuickFullScreenCountDown instance].backColor : [UIColor colorWithRed:0.11f green:0.61f blue:0.81f alpha:1.00f];
    
    UILabel *label = [UILabel new];
    [label setFont:[[QuickFullScreenCountDown instance].font isKindOfClass:[UIFont class]] ? [QuickFullScreenCountDown instance].font : [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * 0.3]];
    [label setTextColor:[[QuickFullScreenCountDown instance].foreColor isKindOfClass:[UIColor class]] ? [QuickFullScreenCountDown instance].foreColor : [UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.opaque = YES;
    label.alpha = 1.0;
    label.backgroundColor = [UIColor clearColor];
    [[QuickFullScreenCountDown instance] addSubview:label];
    [QuickFullScreenCountDown instance].label = label;
    [QuickFullScreenCountDown instance].frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:[QuickFullScreenCountDown instance]];
    [[QuickFullScreenCountDown instance] play];
    return [QuickFullScreenCountDown instance];
}

- (void)play
{
    if(self.shouldContinueWithUIBackgroundModes && (![APP_BACKGROUNDMODES isKindOfClass:[NSArray class]] || [APP_BACKGROUNDMODES count] < 1))
    {
        NSLog(@"请在Info.plist中添加\"Required background modes\"键, 并添加子项: App plays audio or streams audio/video using AirPlay");
        [self removeFromSuperview];
        SDK_RAISE_EXCEPTION(@"请在Info.plist中添加\"Required background modes\"键, 并添加子项: App plays audio or streams audio/video using AirPlay");
        return;
    }
    [self playNumberAction];
    [self setCircleBackView];
}

- (void)playNumberAction
{
    __block NSInteger second = self.number;
    __weak typeof (self) weakSelf = self;
    if(self.beginBlock)self.beginBlock(weakSelf);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second > 0 || (second == 0 && [weakSelf.endTitle isKindOfClass:[NSString class]] && [weakSelf.endTitle length] > 0))
            {
                
                if (second == 0)
                {
                    weakSelf.label.text = [NSString stringWithFormat:@"%@", weakSelf.endTitle];
                }
                else
                {
                    weakSelf.label.text = [NSString stringWithFormat:@"%@", @(second)];
                }
                [weakSelf animation];
                second--;
            }
            else
            {
                
                dispatch_source_cancel(timer);
                
                if(weakSelf.successBlock)
                {
                    weakSelf.successBlock(weakSelf);
                }
                [weakSelf removeFromSuperview];
            }
        });
    });
    //启动源
    dispatch_resume(timer);
}

- (void)animation
{
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.duration = 0.30;
    animation2.toValue = @(0.2);
    animation2.removedOnCompletion = YES;
    animation2.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:animation2 forKey:@"opacity"];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1.0)]];
    animation.values = values;
    [self.label.layer addAnimation:animation forKey:nil];
}

- (void)setCircleBackView
{
    CGFloat delay = 1.0;
    CGFloat scale = 3;
    NSInteger count = 4;
    
    for (NSInteger i = 0; i < count; i++)
    {
        UIView *animationView = [self circleView];
        animationView.backgroundColor = [UIColor clearColor];
        [self insertSubview:animationView atIndex:0];
        [UIView animateWithDuration:1
                              delay:i * delay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             animationView.transform = CGAffineTransformMakeScale(scale, scale);
                             animationView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
                             animationView.alpha = 0;
                             
                         } completion:^(BOOL finished) {
                             [animationView removeFromSuperview];
                         }];
    }
    
}
- (UIView *)circleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = self.center;
    view.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:143 / 255.0 blue:242 / 255.0 alpha:1.0];
    view.layer.cornerRadius = 50.0;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width , self.frame.size.width);
    [self.label setCenter:self.center];
    
}
@end
