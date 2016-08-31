//
//  YYTabbarViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYTabbarViewController.h"
#import "YYNaviViewController.h"
#import "YYEssenceViewController.h"
#import "YYNewViewController.h"
#import "YYPublishViewController.h"
#import "YYFocusViewController.h"
#import "YYMeViewController.h"

#import "YYTabbar.h"

@interface YYTabbarViewController ()

@end

@implementation YYTabbarViewController
+ (void)initialize{
    
    NSMutableDictionary *arrText = [NSMutableDictionary dictionary];
    arrText[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrText[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selText = [NSMutableDictionary dictionary];
    selText[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selText[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:arrText forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:selText forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewControllers];
    [self setupTabbar];
}

- (void)setupTabbar{
    YYTabbar *tabbar = [[YYTabbar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    tabbar.publishClick = ^(){
        YYLog(@"Publish Clicked");
    };
}

- (void)setUpChildViewControllers {

    YYEssenceViewController *essenceVC = [[YYEssenceViewController alloc] init];
                                          
    YYNewViewController *newVC = [[YYNewViewController alloc] init];
    YYFocusViewController *focusVC = [[YYFocusViewController alloc] init];
    YYMeViewController *meVC = [[YYMeViewController alloc] init];
    
    YYNaviViewController *essenceNVC = [[YYNaviViewController alloc] initWithRootViewController:essenceVC];
    [self setupTabbarAttrWithViewController:essenceNVC Image:[UIImage imageNamed:@"tabBar_essence_icon"] selecredImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    YYNaviViewController *newNVC = [[YYNaviViewController alloc] initWithRootViewController:newVC];
     [self setupTabbarAttrWithViewController:newNVC Image:[UIImage imageNamed:@"tabBar_new_icon"] selecredImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"新帖"];
    
    YYNaviViewController *focusNVC = [[YYNaviViewController alloc] initWithRootViewController:focusVC];
     [self setupTabbarAttrWithViewController:focusNVC Image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selecredImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    YYNaviViewController *meNVC = [[YYNaviViewController alloc] initWithRootViewController:meVC];
     [self setupTabbarAttrWithViewController:meNVC Image:[UIImage imageNamed:@"tabBar_me_icon"] selecredImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我的"];
    
    
    [self addChildViewController:essenceNVC];
    [self addChildViewController:meNVC];
    [self addChildViewController:focusNVC];
    [self addChildViewController:newNVC];

    
}

- (void)setupTabbarAttrWithViewController:(UIViewController *)controller Image:(UIImage *)image selecredImage:(UIImage *)selectedImage title:(NSString *)title{
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectedImage;
}

@end
