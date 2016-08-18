//
//  YDStatusBarHUB.h
//  04-LMStatusBarHUB
//
//  Created by 王雅东 on 16/8/9.
//  Copyright © 2016年 YD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDStatusBarHUB : NSObject

/** 显示普通信息 */
+ (void)showMassage:(NSString *)massage;
/** 加载成功 */
+ (void)showSuccess:(NSString *)massage;
/** 加载失败 */
+ (void)showError:(NSString *)massage;
/** 加载中  */
+ (void)showLoading:(NSString *)massage;
/** 隐藏 */
+ (void)hide;


@end
