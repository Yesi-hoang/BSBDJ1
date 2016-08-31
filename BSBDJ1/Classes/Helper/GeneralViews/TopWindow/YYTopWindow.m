
//
//  YYTopWindow.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/29.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTopWindow.h"
#import "UIView+Extension.h"

@implementation YYTopWindow

static UIWindow *topWindow_;

+(void)show{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        topWindow_ = [[UIWindow alloc] init];
        topWindow_.frame = [UIApplication sharedApplication].statusBarFrame;
        topWindow_.backgroundColor = [UIColor clearColor];
        topWindow_.windowLevel = UIWindowLevelAlert;
        [topWindow_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)]];
        topWindow_.hidden = NO;
    });
}

+ (void)topWindowClick{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchAllScrollViewsInWindow:keyWindow];
}

+(void)searchAllScrollViewsInWindow:(UIView *)superView{
    for(UIView *view in superView.subviews){
        [self searchAllScrollViewsInWindow:view];
    }
    if (![superView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    UIScrollView *scrollView = (UIScrollView *)superView;
    // 如果scrollView的矩形框 跟 window 没有重叠，直接返回
    if(![scrollView isShowingOnKeyWindow]){
        return;
    }
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}
@end
