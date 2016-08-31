//
//  YYVideoView.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/25.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYVideoView.h"
#import "YYTopicModel.h"
#import "UIImageView+WebCache.h"


@interface YYVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YYVideoView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setModel:(YYTopicModel *)model{
    _model = model;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld",model.playcount];
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",model.videotime / 60,model.voicetime % 60];
}
- (IBAction)videoPlayButtonClick:(id)sender {
    
    
}

@end
