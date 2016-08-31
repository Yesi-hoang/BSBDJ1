//
//  YYMeCell.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYMeCell.h"

@implementation YYMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    CGFloat width = self.height - 2 * YYCommonPadding;
    self.imageView.width = width;
    self.imageView.height = width;
    self.imageView.x = YYCommonPadding;
    self.imageView.y = YYCommonPadding;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YYCommonPadding;
}
@end
