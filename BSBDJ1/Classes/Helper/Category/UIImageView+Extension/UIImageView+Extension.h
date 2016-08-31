//
//  UIImageView+Extension.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum:NSInteger{
    YYShapeTypeRound,
    YYShapeTypeStar,
    YYShapeTypeHeart
}YYShapeType;


@interface UIImageView (Extension)

- (void)resetImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage shapeType:(YYShapeType)type;
@end
