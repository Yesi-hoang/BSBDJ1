//
//  YYMeViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYMeViewController.h"
#import "YYSettingViewController.h"
#import "YYMeCell.h"
#import "YYMeFooterView.h"

@interface YYMeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableview */
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *ID = @"MeCell";

@implementation YYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self setupNaviBarItems];
    [self setupTableView];
    [self setupNote];
}

- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:YYTabBarButtonDidRepeatClickNotification object:nil];
}
-(void)tabBarButtonDidRepeatClick{
    if (self.view.window == nil) return;
    [self.tableView reloadData];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YYCommonPadding;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YYCommonBgColor;
    self.tableView.tableFooterView = [[YYMeFooterView alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.tableView registerClass:[YYMeCell class] forCellReuseIdentifier:ID];
    
}

- (void)setupNaviBarItems{
    NSDictionary *attrs = @{ NSFontAttributeName:[UIFont systemFontOfSize:20],
                             NSForegroundColorAttributeName : [UIColor darkGrayColor],
                             NSStrokeWidthAttributeName : @2                             };
    
    self.navigationController.navigationBar.titleTextAttributes = attrs;
    
    // NavibarItem
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"mine-sun-icon-click"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(moonClick:) forControlEvents:UIControlEventTouchDown];
    [button sizeToFit];
    UIBarButtonItem *moon = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    
}
- (void)moonClick:(UIButton *)sender{
    
    YYLog(@"moonClick");
}

- (void)settingClick:(UIButton *)sender{
    YYLog(@"settignClick");
    YYSettingViewController *settingVC = [[YYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - Datasource
#pragma mark - Table view data source

// Section numbers
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  2;
}

//  Row number in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

//  Each cell like
- (YYMeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登陆/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
    
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
