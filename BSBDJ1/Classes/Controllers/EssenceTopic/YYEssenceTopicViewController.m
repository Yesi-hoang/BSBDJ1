//
//  YYEssenceTopicViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/23.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYEssenceTopicViewController.h"
#import "YYTopicModel.h"
#import "MJRefresh.h"
#import "AFNetWorking.h"
#import "MJExtension.h"

#import "YYNewViewController.h"
#import "YYHeader.h"
#import "YYFooter.h"
#import "YYTopicModel.h"
#import "YYTopicCell.h"

#define ReuseIdentifier @"YYTopicCell"
@interface YYEssenceTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
/** AFSessionManager */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** aParam */
@property (nonatomic, strong) NSString *aParam;

/** maxtime */
@property (nonatomic, strong) NSString *maxtime;
/** dataSource */
@property (nonatomic, strong) NSMutableArray<YYTopicModel *> *topics;


@end

@implementation YYEssenceTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefrsh];
    [self setupNote];
}
- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:YYTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:YYTitleButtonDidRepeatClickNotification object:nil];
}
-(void)titleButtonDidRepeatClick{
    [self tabBarButtonDidRepeatClick];
}
-(void)tabBarButtonDidRepeatClick{
    // 如果当前控制器的view不在window上，直接返回（说明当前控制器的view并没有显示出来）
    if (self.view.window == nil) return;
    
    // 如果当前控制器的view的矩形框没有跟window矩形框有重叠，直接返回（说明用户看不见当前控制器的view）
    if (![self.view yy_intersectsWithView:self.view.window]) return;
    
    // 下拉刷新
//    [self.tableView.mj_header beginRefreshing];

    [self loadNewDatas];
}

- (void)setupTableView {
    
    self.tableView.backgroundColor = YYCommonBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(YYNavMaxY + YYTitlesViewH, 0,YYTabBarH , 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYTopicCell class]) bundle:nil] forCellReuseIdentifier:ReuseIdentifier];
}

- (void)setupRefrsh{
    // down

    self.tableView.mj_header = [YYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    // up
    
    self.tableView.mj_footer = [YYFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark - Lazy

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;

}
#pragma mark - load datas

-(void)loadNewDatas{
    // 取消之前所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *aStr = @"list";
    // 新帖 a = @"newlist";
    // 请求参数
    NSDictionary *param = @{@"a":aStr,
                            @"c":@"data",
                            @"type":@(self.type)
                            };
    //发送请求
    __weak __typeof(self)weakSelf = self;
   
    [self.manager GET:YYRequestURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        self.topics = [YYTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {        [weakSelf.tableView.mj_header endRefreshing];

    }];
}

-(NSString *)aParam{
    if ([self.parentViewController isKindOfClass:[YYNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}

-(void)loadMoreData{
    
    // 取消之前所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    NSString *aStr = @"list";
    // 新帖 a = @"newlist";
    // 请求参数
    NSDictionary *param = @{@"a":self.aParam,
                            @"c":@"data",
                            @"type":@(self.type),
                            @"maxtime":self.maxtime
                            };
    //发送请求
    __weak __typeof(self)weakSelf = self;
    
    [self.manager GET:YYRequestURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreArray = [YYTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 将新数据拼接到旧数据的后面
        [weakSelf.topics addObjectsFromArray:moreArray];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}
- (YYTopicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYTopicCell *cell = (YYTopicCell *)[self.tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    cell.model = self.topics[indexPath.row];
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.topics[indexPath.row].cellHeight;
}

@end
