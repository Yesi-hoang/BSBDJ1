//
//  YYTopicModel.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTopicModel.h"
#import "NSCalendar+Extension.h"
#import "NSDate+Extension.h"
#import "YYHotCommentModel.h"

@implementation YYTopicModel

#pragma mark - 模型属性处理

- (NSString *)create_at{
    // 只创建一次常用的两个对象
    static NSDateFormatter *fmt = nil;
    if (fmt == nil) {
        fmt = [[NSDateFormatter alloc] init];
    }
    static NSCalendar *calender = nil;
    if (calender == nil) {
        calender = [NSCalendar yy_calender];
    }
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:_created_at];
    
    //判断处理
    if(createdAtDate.yy_isThisYear){
        if (createdAtDate.yy_isToday) {
            //today
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calender components:unit fromDate:createdAtDate toDate:[NSDate date] options:0];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.hour];
            }else{
                return @"刚刚";
            }
            
        }else if(createdAtDate.yy_isYesterday){
            //yesterday
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];

        }else{
            //今年的其他天
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
        
    }else{
        //非今年
        return _created_at;
    }
}

-(CGFloat)cellHeight{
    if (_cellHeight) {
        return _cellHeight;
    }
    
    // 头像
    _cellHeight = 55;
    //2 文字
    CGFloat textMaxW = YYScreenW - 2 * YYCommonMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGFloat textH = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += textH;
    _cellHeight += YYCommonMargin;
    // 3 中间图片高度 除文字其他的都有图片
    // 显示：pictureW   pictureH
    // 真实：self.width self.height
    if(self.type != TopicType_Episode){
        CGFloat pictureW = textMaxW;
        CGFloat pictureH = pictureW * self.height / self.width;
        // 如果图片高度 >= 屏幕高度，那么让图片显示出来的高度变为200
        if (pictureH >= YYScreeH) {
            pictureH = 200;
            self.bigPicture = YES;
        }
        // 中间图片的Frame
        self.pictureFrame = CGRectMake(YYCommonMargin, _cellHeight, pictureW, pictureH);
        _cellHeight += pictureH;
        _cellHeight += YYCommonMargin;
    }
    //最热评论
    if(self.top_cmt){
        _cellHeight += 20;
        //计算内容高度
        NSString *username = self.top_cmt.user.username;
        NSString *content = self.top_cmt.content;
        if (content.length == 0) {
            content = @"语音评论";
        }
        NSString *fullContent = [NSString stringWithFormat:@"%@:%@",username,content];
        CGFloat contentH = [fullContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:0].size.height;
        _cellHeight += contentH;
        _cellHeight += YYCommonMargin;
    }
    //tool hright
    _cellHeight += 35;
    _cellHeight += YYCommonMargin;
    return _cellHeight;
}


@end
