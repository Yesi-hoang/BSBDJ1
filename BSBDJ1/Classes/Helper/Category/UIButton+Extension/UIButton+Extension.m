//
//  UIButton+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/25.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)setupButtonTitleNumber:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [self setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [self setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [self setTitle:placeholder forState:UIControlStateNormal];
    }
}

@end
