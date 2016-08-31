
//
//  YYTitleButton.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/23.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTitleButton.h"

@implementation YYTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
