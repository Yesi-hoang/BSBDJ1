//
//  YYFooter.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYFooter.h"

@implementation YYFooter

-(void)prepare{
    [super prepare];
    self.stateLabel.textColor = [UIColor cyanColor];
    [self setTitle:@"继续啦啦啦" forState:MJRefreshStatePulling];
     [self setTitle:@"热腾腾的数据马上来啦" forState:MJRefreshStateRefreshing];
//    self.noticeNoMoreData
}

-(void)placeSubviews{
    [super placeSubviews];
}


@end
