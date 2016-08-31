//
//  YYExtensionConfig.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/25.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYExtensionConfig.h"
#import "YYTopicModel.h"
#import "MJExtension.h"


@implementation YYExtensionConfig

+ (void)load
{
    
    [YYTopicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"large_image" : @"image1",
                 @"middle_image" : @"image2"
                 };
    }];
}


@end
