//
//  YYTagCell.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTagCell.h"
#import "YYTagCellModel.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Extension.h"


@interface YYTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation YYTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setModel:(YYTagCellModel *)model{
    _model = model;

    [_iconImageView resetImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"friendPortrait"] shapeType:YYShapeTypeStar];
//    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"friendPortrait"]];
    _titleLabel.text = model.title;
    if (model.subTitle > 10000) {
        _subTitleLabel.text =  [NSString stringWithFormat:@"%.1f万人订阅",(model.subTitle / 10000.0)];
    }else{
    _subTitleLabel.text = [NSString stringWithFormat:@"%ld人订阅",(long)model.subTitle];
    }
}

- (IBAction)subscribeButtonClick:(id)sender {
    YYLog(@"subscribeButtonClick");
}


@end
