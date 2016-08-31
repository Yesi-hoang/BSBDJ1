//
//  YYHotCommentModel.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYUser.h"
@interface YYHotCommentModel : NSObject

/** User */
@property (nonatomic, strong) YYUser *user;
/** content */
@property (nonatomic, strong) NSString *content;
/** Like */
@property (nonatomic, assign) NSInteger like_count;


@end
