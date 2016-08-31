//
//  YYAdViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYAdViewController.h"
#import "ZHRPropertyButton.h"
@interface YYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet ZHRPropertyButton *jumpButton;

/** Timer */
@property (nonatomic, strong) NSTimer *timer;
/** leftTime */
@property (nonatomic, assign) NSInteger leftTime;

@end

#define kAdTime 0

@implementation YYAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentImageView.image = [UIImage imageNamed:@"myguide"];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer  = timer;
    NSInteger leftTime = kAdTime;
    self.leftTime = leftTime;
    NSString *timeStr = [NSString stringWithFormat:@"jump:%ld s",(long)self.leftTime];
    [self.jumpButton setTitle:timeStr forState:UIControlStateNormal];
}
- (void)reduceTime{
    
    if (self.leftTime == 0) {
        
        if (self.complete) {
            [self stopTimer];
            self.complete();
        }
    }else{
        self.leftTime --;
        NSString *timeStr = [NSString stringWithFormat:@"jump:%ld s",(long)self.leftTime];
        [self.jumpButton setTitle:timeStr forState:UIControlStateNormal];

    }
}
- (IBAction)jumpButtonClick:(id)sender {
    [self stopTimer];
    if (self.complete) {
        self.complete();
    }
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
