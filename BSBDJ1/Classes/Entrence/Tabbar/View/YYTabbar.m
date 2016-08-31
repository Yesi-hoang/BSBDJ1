//
//  YYTabbar.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTabbar.h"

@interface YYTabbar()
/** Publish Button */
@property (nonatomic, strong) UIButton *publishButton;

/** 记录上一个被选中的位置 */
@property (nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation YYTabbar

- (void)layoutSubviews{
    [super layoutSubviews];
    self.publishButton.center = CGPointMake(0.5 * self.width, 0.5 * self.height);
    
    CGFloat width = self.width * 0.2;
    NSInteger i = 0;
    for (UIControl *subview in self.subviews) {
        if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)])continue;
        
        CGRect oriFrame = subview.frame;
        if (i > 1) {
            oriFrame.origin.x = (i + 1) * width;
        }else{
            oriFrame.origin.x = i * width;
        }
        subview.width = width;
        subview.frame = oriFrame;
        subview.tag = i;
        [subview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        i++;
    }
}

- (UIButton *)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        [self addSubview:publishButton];
        [publishButton addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchDown];
        _publishButton  = publishButton;
    }
    return _publishButton;
}

- (void)publishButtonClick:(UIButton *)sender{
    if (self.publishClick) {
        self.publishClick();
    }
}

-(void)buttonClick:(UIControl *)button{
    if (self.selectedIndex == button.tag) {
        // notification
        [[NSNotificationCenter defaultCenter] postNotificationName:YYTabBarButtonDidRepeatClickNotification object:nil];

    }
    self.selectedIndex = button.tag;
}
@end
