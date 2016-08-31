//
//  YYEssenceRecommendTagViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/19.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYEssenceRecommendTagViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "YYTagCell.h"
#import "YYHTTPSessionManager.h"
#import "MJExtension.h"
#import "YYTagCellModel.h"

@interface YYEssenceRecommendTagViewController ()

/** YYHTTPSessionManager */
@property (nonatomic, weak) YYHTTPSessionManager *manager;

@property (nonatomic, weak) AFHTTPSessionManager *sessionManager;

/** result Array */
@property (nonatomic, strong) NSArray *reusltArray;

@end
//YYTagCell
#define kTagCell (@"YYTagCell")
@implementation YYEssenceRecommendTagViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
    [self loadData];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YYCommonBgColor;
    self.tableView.rowHeight = 70;
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYTagCell class]) bundle:nil]forCellReuseIdentifier:kTagCell];
}

- (void)loadData{
    // 弹框
    [SVProgressHUD show];
    
    // 加载标签数据
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    __weak __typeof(self)weakSelf = self;
    
        [self.manager GET:YYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            __strong __typeof(weakSelf)
            
            strongSelf = weakSelf;
        if (responseObject == nil) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return;
        }
            [YYTagCellModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"image" : @"image_list",
                         @"title" : @"theme_name",
                         @"subTitle" : @"sub_number"
                                                 };
                //字典转模型
            }];
            _reusltArray = [YYTagCellModel mj_objectArrayWithKeyValuesArray:responseObject];
            [strongSelf.tableView reloadData];
            
        // 关闭弹框
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 如果是取消了任务，就不算请求失败，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
        } else {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }
    }];

}

-(YYHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [YYHTTPSessionManager manager];
    }
    return _manager;

}
- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;

}

- (NSArray *)reusltArray{
    if (!_reusltArray) {
        _reusltArray = [NSArray array];
    }
    return _reusltArray;

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reusltArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTagCell forIndexPath:indexPath];
   YYTagCell *newCell = (YYTagCell *)cell;
    newCell.model = self.reusltArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
