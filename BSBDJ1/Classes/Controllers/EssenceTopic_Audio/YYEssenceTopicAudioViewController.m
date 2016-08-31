//
//  YYEssenceTopicAudioViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/23.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYEssenceTopicAudioViewController.h"

@interface YYEssenceTopicAudioViewController ()

@end

@implementation YYEssenceTopicAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (YYTopicType)type{
    return TopicType_Audio;
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
