//
//  YYTopicCell.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTopicCell.h"
#import "YYPictureView.h"
#import "YYAudioView.h"
#import "YYVideoView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Extension.h"
#import "UIButton+Extension.h"
#import "YYTopicModel.h"

@interface YYTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotTopicLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *hotTopicView;
// 中间的控件
/** Picture */
@property (nonatomic, weak) YYPictureView *pictureView;
/** AudioView */
@property (nonatomic, weak) YYAudioView *audioView;
/** videoView */
@property (nonatomic, weak) YYVideoView *videoView;

@end

@implementation YYTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setModel:(YYTopicModel *)model{
    _model = model;
    [self.profileImageView resetImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:nil shapeType:YYShapeTypeStar];
    
    self.usernameLabel.text = model.name;
    self.createAtLabel.text = model.created_at;
    self.contentLabel.text = model.text;
    // top_cmt
    if (model.top_cmt) {
        self.hotTopicView.hidden = NO;
        NSString *content = model.top_cmt.content;
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        self.hotTopicLabel.text = [NSString stringWithFormat:@"%@:%@",model.top_cmt.user.username,model.top_cmt.content];
    }else{
        self.hotTopicView.hidden = YES;
    }
    
    
    [self.dingButton setupButtonTitleNumber:model.ding
                                placeholder:@"顶"];
    [self.caiButton setupButtonTitleNumber:model.cai placeholder:@"踩"];
    [self.shareButton setupButtonTitleNumber:model.repost placeholder:@"分享"];
    [self.commentButton setupButtonTitleNumber:model.comment placeholder:@"评论"];
    
    // 中间内容
    if(model.type == TopicType_Image){
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;
        self.pictureView.model = model;
    }else if(model.type == TopicType_Video){
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.audioView.hidden = YES;
        self.videoView.model = model;
    }else if(model.type == TopicType_Audio){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = NO;
        self.audioView.model = model;
    }else{
        //段子文字
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;

    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.model.type == TopicType_Image){
        self.pictureView.frame = self.model.pictureFrame;
    }else if(self.model.type == TopicType_Video){
        self.videoView.frame = self.model.pictureFrame;

    }else if(self.model.type == TopicType_Audio){
        self.audioView.frame = self.model.pictureFrame;

    }
}
#pragma mark - Lazy

- (YYPictureView *)pictureView{
    if (!_pictureView) {
        YYPictureView *picView = [YYPictureView yy_viewFromXib];
        [self.contentView addSubview:picView];
        _pictureView = picView;
    }
    return _pictureView;
}

- (YYAudioView *)audioView{
    if (!_audioView) {
        YYAudioView *audioView = [YYAudioView yy_viewFromXib];
        _audioView = audioView;
        [self.contentView addSubview:audioView];
    }
    return _audioView;

}

-(YYVideoView *)videoView{
    if (!_videoView) {
        YYVideoView *videoView = [YYVideoView yy_viewFromXib];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
    }
    return _videoView;

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= YYCommonMargin;
    [super setFrame:frame];
}
@end
