//
//  YYConst.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYConst : NSObject

/** 请求路径 */
UIKIT_EXTERN  NSString * const YYRequestURL;
/** 统一间距 */
UIKIT_EXTERN CGFloat const YYCommonPadding;

/** 统一的间距 */
UIKIT_EXTERN CGFloat const YYCommonMargin;

/** 导航栏最大的Y值 */
UIKIT_EXTERN CGFloat const YYNavMaxY;

/** 标题栏的高度 */
UIKIT_EXTERN CGFloat const YYTitlesViewH;

/** UITabBar的高度 */
UIKIT_EXTERN CGFloat const YYTabBarH ;

/** 统一的URL */
UIKIT_EXTERN NSString * const YYCommonURL;


/** 通知-UITabBarButton被重复点击就会发出这个通知 */
UIKIT_EXTERN NSString * const YYTabBarButtonDidRepeatClickNotification;

/** 通知-标题栏按钮被重复点击就会发出这个通知 */
UIKIT_EXTERN NSString * const YYTitleButtonDidRepeatClickNotification;
@end
