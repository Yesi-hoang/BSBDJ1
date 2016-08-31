//
//  ZHRPropertyButton.m
//  Zoharo
//
//  Created by Yesi on 16/8/9.
//  Copyright © 2016年 Zoharo. All rights reserved.
//

#import "ZHRPropertyButton.h"

@implementation ZHRPropertyButton

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
