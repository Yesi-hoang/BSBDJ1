//
//  YYConst.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYConst.h"
#import <UIKit/UIKit.h>

@implementation YYConst

/** 请求路径 */
NSString * const YYRequestURL = @"http://api.budejie.com/api/api_open.php";

CGFloat const YYCommonPadding = 10;

/** 统一的间距 */
CGFloat const YYCommonMargin = 10;

/** 导航栏最大的Y值 */
CGFloat const YYNavMaxY = 64;

/** 标题栏的高度 */
CGFloat const YYTitlesViewH = 35;

/** UITabBar的高度 */
CGFloat const YYTabBarH = 49;

/** 统一的URL */
NSString * const YYCommonURL = @"http://api.budejie.com/api/api_open.php";

/** 通知-UITabBarButton被重复点击就会发出这个通知 */
NSString * const YYTabBarButtonDidRepeatClickNotification = @"XMGTabBarButtonDidRepeatClickNotification";

/** 通知-标题栏按钮被重复点击就会发出这个通知 */
NSString * const YYTitleButtonDidRepeatClickNotification = @"XMGTitleButtonDidRepeatClickNotification";

@end

