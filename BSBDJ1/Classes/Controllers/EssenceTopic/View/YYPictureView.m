//
//  YYPictureView.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/25.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYPictureView.h"
#import "YYTopicModel.h"
#import "DALabeledCircularProgressView.h"
#import "UIImageView+WebCache.h"
#import "YYSeeBigPictureViewController.h"
#import "DACircularProgressView.h"

@interface YYPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation YYPictureView
-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.contentImageView.userInteractionEnabled = YES;
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)]];
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
}

-(void)seeBigPic{
    // 来个controller
    YYSeeBigPictureViewController *seeBig = [[YYSeeBigPictureViewController alloc] init];
    seeBig.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setModel:(YYTopicModel *)model{
    _model = model;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //progress
        expectedSize = (expectedSize < 0) ? 1 :expectedSize;
        CGFloat scale = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.f%%",scale];
        self.progressView.hidden = NO;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
//gif
    self.gifImageView.hidden = !model.is_gif;
// see big button
    self.seeBigButton.hidden = !model.isBigPicture;
    
    if (model.isBigPicture) {
        self.contentImageView.contentMode = UIViewContentModeTop;
        self.contentImageView.clipsToBounds = YES;
    }else{
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentImageView.clipsToBounds = NO;
    }
}
@end
