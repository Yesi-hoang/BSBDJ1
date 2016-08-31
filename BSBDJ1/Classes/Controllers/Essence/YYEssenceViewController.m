//
//  YYEssenceViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYEssenceViewController.h"
#import "YYEssenceRecommendTagViewController.h"
#import "Masonry.h"

#import "YYEssenceTopicAllViewController.h"
#import "YYEssenceTopicVideoViewController.h"
#import "YYEssenceTopicAudioViewController.h"
#import "YYEssenceTopicImageViewController.h"
#import "YYEssenceTopicEpisodeViewController.h"

#import "YYTitleButton.h"

@interface YYEssenceViewController ()<UIScrollViewDelegate>


/** Title View */
@property (nonatomic, strong) UIView *titleView;

/** title array */
@property (nonatomic, strong) NSArray *titleArray;

/** selected YYTitleButton */
@property (nonatomic, strong) YYTitleButton *selectedTitleButton;
/** underline */
@property (nonatomic, strong) UIView *underlineView;

/** scrollView */
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

#define kTitleViewHeight 44
@implementation YYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setupNavigation];
    [self setupChildViewControllers];
    [self setupScrollView];
    [self setupTitleView];
    [self addChildVCToScrollView];
}

#pragma mark - ChildViewControllers

-(void)setupChildViewControllers{
    
    [self addChildViewController:[[YYEssenceTopicAllViewController alloc] init]];
    [self addChildViewController:[[YYEssenceTopicVideoViewController alloc] init]];
    [self addChildViewController:[[YYEssenceTopicAudioViewController alloc] init]];
    [self addChildViewController:[[YYEssenceTopicImageViewController alloc] init]];
    [self addChildViewController:[[YYEssenceTopicEpisodeViewController alloc] init]];
    
}

#pragma mark - IndicatorView

-(void)setupTitleView{
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(YYScreenW));
        make.height.equalTo(@(YYTitlesViewH));
        make.leading.equalTo(@0);
        make.top.equalTo(@(YYNavMaxY));
    }];

    [self setupTitleButtons];
    [self setupUnderline];
}

-(void)setupTitleButtons{
    
    NSArray *titleArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    self.titleArray = titleArray;
    CGFloat width = YYScreenW / titleArray.count;
    CGFloat heigth = YYTitlesViewH;
    for (int i = 0; i < titleArray.count; i++) {
        YYTitleButton *button = [YYTitleButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag = i + 1000;
        [self.titleView addSubview:button];
        CGFloat x = i * width;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(width));
            make.height.equalTo(@(heigth));
            make.top.equalTo(@0);
            make.leading.equalTo(@(x));
        }];
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchDown];
    }
}

-(void)titleButtonClicked:(YYTitleButton *)sender{

    
    // 重复点击了某个标题按钮
    if (self.selectedTitleButton == sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YYTitleButtonDidRepeatClickNotification object:nil];
    }
    
    
    self.selectedTitleButton.selected = NO;
    sender.selected = YES;
    self.selectedTitleButton = sender;
    // underline
    [self updateUnderline:sender];
    // scrollview
    
    CGPoint point = self.contentScrollView.contentOffset;
    point.x = (sender.tag - 1000) * YYScreenW;
    [self.contentScrollView setContentOffset:point];
}
- (void)setupUnderline
{
    // 取出最前面的按钮
    YYTitleButton *firstTitleButton = self.titleView.subviews.firstObject;
    
    // 添加下划线
    UIView *underline = [[UIView alloc] init];
    [self.titleView addSubview:underline];
    
    underline.backgroundColor = [UIColor redColor];
    underline.height = 1;
    underline.y = YYTitlesViewH - underline.height;
    
    // 默认点击了最前面的按钮
    // 切换按钮的状态 来 切换按钮的文字颜色
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    // 让按钮内部的titleLabel根据文字内容自动计算大小
    [firstTitleButton.titleLabel sizeToFit];
    CGFloat width = YYScreenW / self.titleArray.count;

    // 下划线宽度
    underline.width = width;
    // 下划线中心点
    underline.centerX = 0.5 * width;
    
    self.underlineView = underline;
}


- (void)updateUnderline:(YYTitleButton *)titleButton{
    
    CGFloat width = YYScreenW / self.titleArray.count;
    
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        // 宽度
        self.underlineView.width = width;
        
        // 中心点
        self.underlineView.centerX = titleButton.centerX;
    }];

}

#pragma mark - Navigation Bar & Item

-(void)setupNavigation{
    // NavibarItem
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(TagClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    // NaviBarView
    UIImageView *titleView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = titleView;
}

- (void)TagClick {
    YYEssenceRecommendTagViewController *tagVC = [[YYEssenceRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark - ScrollView
- (void)setupScrollView{
    // 不自动设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
//    scrollView.backgroundColor = [UIColor cyanColor];
    self.contentScrollView = scrollView;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;

    CGSize contentSize = scrollView.contentSize;
    contentSize.width = self.childViewControllers.count * YYScreenW;
    self.contentScrollView.contentSize = contentSize;
}

- (void)addChildVCToScrollView{
    // current index
    NSInteger currentIndex = self.contentScrollView.contentOffset.x / YYScreenW;
    
    UIViewController *childViewController = self.childViewControllers[currentIndex];
    if (childViewController.isViewLoaded) return;

    [self.contentScrollView addSubview:childViewController.view];
    childViewController.view.frame = self.contentScrollView.bounds;
}

#pragma mark - UIScrollView delegate
//拖拽
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / YYScreenW;
    //corresponding button selected
    YYTitleButton *currentButton = self.titleView.subviews[index];
    [self titleButtonClicked:currentButton];
    [self addChildVCToScrollView];

}
//
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self addChildVCToScrollView];
}

@end
