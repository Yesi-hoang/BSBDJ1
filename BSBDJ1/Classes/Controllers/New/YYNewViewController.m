//
//  YYNewViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYNewViewController.h"

@interface YYNewViewController ()

@end

@implementation YYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NaviBarView
    UIImageView *titleView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = titleView;
    // NavibarItem
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(TagClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)TagClick {
    
    YYLog(@"TagClick");
    // Dispose of any resources that can be recreated.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
