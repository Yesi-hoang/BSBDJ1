//
//  YYFocusViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/18.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYFocusViewController.h"
#import "YYLoginViewController.h"

@interface YYFocusViewController ()

@end

@implementation YYFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    NSDictionary *attrs = @{ NSFontAttributeName:[UIFont systemFontOfSize:20],
                             NSForegroundColorAttributeName : [UIColor darkGrayColor],
                             NSStrokeWidthAttributeName : @2                             };
    
    self.navigationController.navigationBar.titleTextAttributes = attrs;
    // NavibarItem
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(TagClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)TagClick {
    
    YYLog(@"FocusClick");
    // Dispose of any resources that can be recreated.
}
- (IBAction)logRegButtonClicked:(id)sender {
    
    YYLoginViewController *loginVc = [[YYLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}

@end
