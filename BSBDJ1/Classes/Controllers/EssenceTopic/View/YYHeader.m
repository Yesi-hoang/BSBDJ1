//
//  YYHeader.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYHeader.h"

@interface YYHeader()

/** logoView */
@property (nonatomic, weak) UIImageView *logoView;

@end
@implementation YYHeader
- (void)prepare{
    [super prepare];
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"header_cry_icon"];
    [self addSubview:logoView];
    self.logoView = logoView;
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.textColor = [UIColor magentaColor];

}

- (void)placeSubviews{
    [super placeSubviews];
    self.logoView.mj_x = 0;
    self.logoView.width = 100;
    self.logoView.height = 50;
    self.logoView.mj_y = 20;
    
}
@end
