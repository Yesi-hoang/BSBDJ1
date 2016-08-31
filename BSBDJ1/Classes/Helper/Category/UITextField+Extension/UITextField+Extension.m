//
//  UITextField+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "UITextField+Extension.h"

/** 占位文字颜色 */
static NSString * const YYPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (Extension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    BOOL change = NO;
    if (self.placeholder == nil) {
        change = YES;
        self.placeholder = @" ";
    }
    // 之所以要写这么多废话是因为如果placeholder是空的话就保存不了  设置不上去  所以给了他几个空格
    [self setValue:placeholderColor forKeyPath:YYPlaceholderColorKey];
    
    if (change) {
        self.placeholder = nil;
    }
}

-(UIColor *)placeholderColor{
    
   return [self valueForKeyPath:YYPlaceholderColorKey];
}
@end
