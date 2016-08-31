//
//  YYTopicModel.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class YYHotCommentModel;
#import "YYHotCommentModel.h"
typedef NS_ENUM (NSUInteger,YYTopicType){
    TopicType_All = 1,
    TopicType_Video = 41,
    TopicType_Audio = 31,
    TopicType_Image = 10,
    TopicType_Episode = 29
};

@interface YYTopicModel : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) YYHotCommentModel *top_cmt;
/** 类型 */
@property (nonatomic, assign) YYTopicType type;



#pragma mark - ---- content info

/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;

/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 声音文件的长度（单位：s） */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频文件的长度（单位：s） */
@property (nonatomic, assign) NSInteger videotime;

/** 是否为动态图片 */
@property (nonatomic, assign) BOOL is_gif;

#pragma mark - addition

/** 中间图片的frame */
@property (nonatomic, assign) CGRect pictureFrame;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 是否为长图（大图） */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;





@end
