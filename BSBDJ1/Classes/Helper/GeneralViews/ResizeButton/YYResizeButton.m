//
//  YYResizeButton.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/18.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYResizeButton.h"

#define kImageScale 0.7
@implementation YYResizeButton

//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    
//    return CGRectMake(0, self.height * 0.7, self.width, self.height * (1 -0.7));
//
//}
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
// 
//    return CGRectMake(0, 0, self.width, self.height * 0.7);
//}
- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片的位置和尺寸
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字的位置和尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
