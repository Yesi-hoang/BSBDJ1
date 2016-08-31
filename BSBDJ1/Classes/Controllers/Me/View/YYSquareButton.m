//
//  YYSquareButton.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYSquareButton.h"
#import "UIButton+WebCache.h"

static CGFloat scale = 0.3;
@implementation YYSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat width = self.width * (1 - scale);
    return CGRectMake((self.width - width) * 0.5, 0, width, width);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat width = self.width * (1 - scale);

    return CGRectMake(0, width, self.width, self.width * scale);
}

- (void)setModel:(YYMeFooterModel *)model{
    _model = model;
    [self sd_setImageWithURL:[NSURL URLWithString:model.imageLink] forState:UIControlStateNormal];
    [self setTitle:model.titleName forState:UIControlStateNormal];
}

@end
