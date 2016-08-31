//
//  YYMeFooterView.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYMeFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YYMeFooterModel.h"
#import "YYSquareButton.h"
#import "YYWebViewController.h"


#define CellID @"YYMeCollectionCell"
@interface YYMeFooterView()

/** ModelArray */
@property (nonatomic, strong) NSArray *models;

@end

@implementation YYMeFooterView

- (NSArray *)models{
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;

}

- (instancetype)init{
    if (self = [super init]) {
        [self requestDatas];
    }
    return self;
}

- (void)requestDatas{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 发送请求
    __weak __typeof(self)weakSelf = self;
   
    [[AFHTTPSessionManager manager] GET:YYRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        [YYMeFooterModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"titleName":@"name",
                     @"linkUrl":@"url",
                     @"imageLink":@"icon"
                     };
            
        }];
       NSArray *modelArray = [[NSArray alloc]init];
        
       modelArray = [YYMeFooterModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        self.models = modelArray;
        [weakSelf createSquares:self.models];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}


- (void)createSquares:(NSArray *)models{
    
    int numEachRow = 4;
    CGFloat width = YYScreenW / numEachRow;
    NSInteger count = self.models.count;
    for (int i = 0; i < count; i++) {
        CGFloat x = (i % numEachRow) * width  ;
        CGFloat y = (i / numEachRow) * width;
        YYSquareButton *button = [YYSquareButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, width, width);
        [self addSubview:button];
        button.model = self.models[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    }
    
    CGFloat height = CGRectGetMaxY(self.subviews.lastObject.frame);
    [self setHeight:height];
    UITableView *tableview = (UITableView *)self.superview;
    tableview.contentSize = CGSizeMake(YYScreenW, CGRectGetMaxY(self.frame));
}

- (void)buttonClick:(YYSquareButton *)sender{
    if ([sender.model.linkUrl hasPrefix:@"http"]) {
        
        // webView
        YYWebViewController *webView = [[YYWebViewController alloc] init];
        webView.url = sender.model.linkUrl;
        UITabBarController *tabVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *naviVC = tabVC.selectedViewController;
        
        [naviVC pushViewController:webView animated:YES];
    }
    else{
        YYLog(@"其实没有链接 不用点了👽");
    }
}



@end
