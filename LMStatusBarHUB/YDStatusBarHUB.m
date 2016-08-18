//
//  YDStatusBarHUB.m
//  04-LMStatusBarHUB
//
//  Created by 王雅东 on 16/8/9.
//  Copyright © 2016年 YD. All rights reserved.
//

#import "YDStatusBarHUB.h"

#define  LMMessageFont [UIFont systemFontOfSize:13]
/** 消息停留时间 */
static CGFloat const LMDuration = 2.0;
/** 动画时间 */
static CGFloat const LMAnimationDuration = 0.25;


@implementation YDStatusBarHUB

static UIWindow *window_;
static NSTimer *timer_;

+ (void)createWindow
{
    
    CGFloat winH = 20;
    CGRect frame =     window_.frame           = CGRectMake(0, -winH, [UIScreen mainScreen].bounds.size.width, 20);
    
    

    
    //0 先隐藏之前的窗口
    window_.hidden = YES;
    window_                 = [[UIWindow alloc] init];
    window_.hidden          = NO;
    window_.windowLevel     = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor blackColor];
//    window_.frame           = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.frame           = frame;
    
    
    frame.origin.y = 0;
    [UIView animateWithDuration:LMAnimationDuration animations:^{
        
        window_.frame = frame;
        
        
    }];
//    return window_;

}

/** 显示普通信息 */
+ (void)showMassage:(NSString *)massage image:(UIImage *)image
{
    //停止上一次的定时器
    [timer_ invalidate];

    
    [ self createWindow];
    
    
    //添加button
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame            = window_.bounds;
    button.titleLabel.font  = LMMessageFont;
    if (image) { //如果有图片
        button.titleEdgeInsets  = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setImage:image forState:UIControlStateNormal];
    }
    [button setTitle:massage forState:UIControlStateNormal];
    [window_ addSubview:button];
    
    
    //定时消失  用GCD 不太合适    连续点击不同的就会出问题  所以建议用nstimer
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hide];
//    });
    
 
    
    /********思路*******/
    /*
    NSObject *obj;
    //先取消上一个 再加载显示下一个
    [NSString cancelPreviousPerformRequestsWithTarget:obj selector:@selector(hide) object:nil];
    
    [obj performSelector:@selector(hide) withObject:nil afterDelay:2.0];  */
     /********思路*******/
    
    
    //建议：
    //    [NSTimer timer...];
    
    timer_ = [NSTimer  scheduledTimerWithTimeInterval:LMDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
}


+ (void)showMassage:(NSString *)massage
{
    [YDStatusBarHUB showMassage:massage image:nil];
}

/** 加载成功 */
+ (void)showSuccess:(NSString *)massage
{
    
    //打印沙河
    NSLog(@"%@",NSTemporaryDirectory());
    
    
    [YDStatusBarHUB showMassage:massage image:[UIImage imageNamed:@"LMStatusBarHUB.bundle/check"]];
    
}
/** 加载失败 */
+ (void)showError:(NSString *)massage
{
    [YDStatusBarHUB showMassage:massage image:[UIImage imageNamed:@"LMStatusBarHUB.bundle/error"]];

}
/** 加载中  */
+ (void)showLoading:(NSString *)massage
{
    
    //停止上一次的定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self createWindow];
    
    //显示文字
    UILabel *label = [[UILabel alloc] init];
    label.font  = LMMessageFont;
    label.frame = window_.bounds;
     label.text = massage;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
   [window_ addSubview:label];
    
    //添加圈圈
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator startAnimating];
    
    //算出传进来的文字的宽度
    CGFloat msgWidth = [massage sizeWithAttributes:@{NSFontAttributeName : LMMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgWidth) * 0.5 - 15;
    CGFloat centerY = window_.frame.size.height * 0.5;
    indicator.center = CGPointMake(centerX, centerY);
    [window_ addSubview:indicator];
    

}
/** 隐藏 */
+ (void)hide
{
    
    [UIView animateWithDuration:LMAnimationDuration animations:^{
        
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
        
        
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
    
}

@end
