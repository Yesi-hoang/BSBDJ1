//
//  YYNaviViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYNaviViewController.h"

@interface YYNaviViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YYNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 恢复系统左滑手势
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1){
    // 重新设置返回键
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClickd:) forControlEvents:UIControlEventTouchDown];
    [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
    
    }
    
    [super pushViewController:viewController animated:animated];

}
- (void)backButtonClickd:(UIButton *)sender{
    [self popViewControllerAnimated:YES];
}
@end
