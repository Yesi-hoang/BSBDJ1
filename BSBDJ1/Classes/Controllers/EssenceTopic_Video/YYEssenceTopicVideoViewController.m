//
//  YYEssenceTopicVideoViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/23.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYEssenceTopicVideoViewController.h"

@interface YYEssenceTopicVideoViewController ()

@end

@implementation YYEssenceTopicVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (YYTopicType)type{
    return TopicType_Video;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
