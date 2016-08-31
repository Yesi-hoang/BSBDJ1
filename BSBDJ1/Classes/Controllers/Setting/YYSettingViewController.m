//
//  YYSettingViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/18.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYSettingViewController.h"
#import "YYCacheCell.h"

@interface YYSettingViewController ()<UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;

@end

#define CacheCellID @"CacheCellID"

@implementation YYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationItem.title = @"设置";

    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[YYCacheCell class] forCellReuseIdentifier:CacheCellID];
    tableView.dataSource = self;
}

#pragma mark - Table view data source

// Section numbers
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

//  Row number in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

//  Each cell like
- (YYCacheCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YYCacheCell *cell = (YYCacheCell *)[tableView dequeueReusableCellWithIdentifier:CacheCellID];
    
    return cell;
    
}


@end
