//
//  YYCacheCell.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYCacheCell.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define YYSDWebImageCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"default"]

#define YYCustomCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"MyCache"]

@implementation YYCacheCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化
        [self setupInit];
        // Add Tap
        [self setupTapGesture];
        // Calculate
        [self calculateCache];
    }
    return self;
}

-(void)setupInit{
    self.textLabel.text = @"正在计算缓存大小......";
    [self setupAccessory];
}

-(void)setupAccessory{
    UIActivityIndicatorView *chrysanthenum = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [chrysanthenum startAnimating];
    self.accessoryView = chrysanthenum;
}

-(void)setupTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCache)];
    [self addGestureRecognizer:tap];
}

-(void)calculateCache{
    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       //计算
        unsigned long long fileSize = YYSDWebImageCachePath.yy_fileSize + YYCustomCachePath.yy_fileSize;
        NSString *fileSizeText = nil;

        // 如果cell不存在就不用计算了
        if(!weakSelf) return;
        // Get size string
        // pow(10, 9) == 10的9次方
        if (fileSize >= pow(10, 9)) { // fileSize >= 1GB
            fileSizeText = [NSString stringWithFormat:@"%.1fGB", fileSize / pow(10, 9)];
        } else if (fileSize >= pow(10, 6)) { // fileSize >= 1MB
            fileSizeText = [NSString stringWithFormat:@"%.1fMB", fileSize / pow(10, 6)];
        } else if (fileSize >= pow(10, 3)) { // fileSize >= 1KB
            fileSizeText = [NSString stringWithFormat:@"%.1fKB", fileSize / pow(10, 3)];
        } else { // fileSize < 1KB
            fileSizeText = [NSString stringWithFormat:@"%zdB", fileSize];
        }

        NSString *sizeText = [NSString stringWithFormat:@"清除缓存%@",fileSizeText];
        // Back to Main
        dispatch_async(dispatch_get_main_queue(), ^{
            // weakSelf.userInteractionEnabled = YES;
            
            // 清空右边的指示器控件
            weakSelf.accessoryView = nil;
            
            // 显示右边的箭头
            weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // 显示文字
            weakSelf.textLabel.text = sizeText;
        });
    });
    
}
// 在cell显示之前（添加到窗口前）会调用一次这个方法
-(void)layoutSubviews{
    [super layoutSubviews];
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];

}
-(void)cleanCache{
    if (self.accessoryView) return;
    __weak __typeof(self)weakSelf = self;
    [SVProgressHUD showWithStatus:@"清除缓存中......"];
    // 子线程清除
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       // File Manager
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:YYSDWebImageCachePath error:nil];
        [mgr removeItemAtPath:YYCustomCachePath error:nil];
        [mgr createDirectoryAtPath:YYCustomCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        // Back to main
        dispatch_async(dispatch_get_main_queue(), ^{
            SVProgressHUD.minimumDismissTimeInterval = 1.0;
            [SVProgressHUD showSuccessWithStatus:@"清除成功!"];
            weakSelf.textLabel.text = @"清除缓存0dB";
        });
    });
    
}
@end
