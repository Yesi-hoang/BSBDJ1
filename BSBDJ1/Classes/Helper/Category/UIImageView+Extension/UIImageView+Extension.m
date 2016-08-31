//
//  UIImageView+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)resetImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage shapeType:(YYShapeType)type{
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        switch (type) {
            case YYShapeTypeRound:
            {
                [self drawCircleImage:image];
                break;
            }
            case YYShapeTypeStar:
            {
                [self drawStarImage:image];
                break;
            }
            case YYShapeTypeHeart:
            {
                [self drawHeartImage:image];
                break;
            }
            default:
                break;
        }
      
  }];
}

//-(void)draw

-(void)drawCircleImage:(UIImage *)image{
    // placeholderImage->roundImage
    // 开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画一个圆 减掉周围
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    // 从上下文中搞一张图
    [image drawInRect:rect];
    // 获得上下文中的图片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
}

- (void)drawStarImage:(UIImage *)image{
    // placeholderImage->roundImage
    // 开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
//    //画一个圆 减掉周围
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
//    CGContextAddEllipseInRect(context, rect);
    CGPoint centerPoint=  CGPointMake(0.5 * rect.size.width , 0.5 * rect.size.height);
    //确定半径
    CGFloat radius= 0.5 * rect.size.height;
    //五角星到顶点
    CGPoint p1=CGPointMake(centerPoint.x, centerPoint.y - radius);
    CGContextMoveToPoint(context, p1.x, p1.y);
    //五角星每个点之间点夹角，采用弧度计算。没两个点进行连线就可以画出五角星
    //点与点之间点夹角为2*M_PI/5.0，
    CGFloat angle = 4 * M_PI / 5.0;
    for (int i = 1; i <= 5; i++) {
        CGFloat x = centerPoint.x - sinf(i * angle) * radius;
        CGFloat y = centerPoint.y - cosf(i * angle) * radius;
        CGContextAddLineToPoint(context, x, y);
        
    }

     CGContextClip(context);
    // 从上下文中搞一张图
    [image drawInRect:rect];
    // 获得上下文中的图片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();

}
//算法不会  放弃
-(void)drawHeartImage:(UIImage *)image{
    [self drawStarImage:image];
}

@end
