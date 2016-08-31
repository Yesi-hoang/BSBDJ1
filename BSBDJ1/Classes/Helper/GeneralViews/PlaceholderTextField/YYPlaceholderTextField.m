//
//  YYPlaceholderTextField.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYPlaceholderTextField.h"
#import "UITextField+Extension.h"

// 默认的文字颜色
#define YYPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define YYPlaceholderFocusColor [UIColor whiteColor]
@implementation YYPlaceholderTextField
- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = YYPlaceholderFocusColor;
    self.textColor = YYPlaceholderFocusColor;
}

- (BOOL)becomeFirstResponder{
    self.placeholderColor = YYPlaceholderFocusColor;
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    self.placeholderColor = YYPlaceholderDefaultColor;
    return [super resignFirstResponder];
}
@end
