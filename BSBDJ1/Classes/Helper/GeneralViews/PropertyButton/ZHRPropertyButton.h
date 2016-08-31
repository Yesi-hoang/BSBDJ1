//
//  ZHRPropertyButton.h
//  Zoharo
//
//  Created by Yesi on 16/8/9.
//  Copyright © 2016年 Zoharo. All rights reserved.
//  UIButton 设置此类后可以直接在Attributes Inspector 里面设置圆角 边框宽度 和 边框颜色

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ZHRPropertyButton : UIButton

/** Border width */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/** Corner radius */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/** Border color */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
