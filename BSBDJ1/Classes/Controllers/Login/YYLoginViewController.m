//
//  YYLoginViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/18.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYLoginViewController.h"
#import <objc/runtime.h>
#import "UITextField+Extension.h"


@interface YYLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContentLeadingCons;
@property (weak, nonatomic) IBOutlet UIButton *loginChangeButton;


@end

@implementation YYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)reisterButtonClick:(id)sender {
    YYLog(@"Register Button Click");
}

- (IBAction)logChangeClick:(UIButton *)sender {
    if (self.leftContentLeadingCons.constant == 0) {
        self.leftContentLeadingCons.constant = -YYScreenW;
        sender.selected = YES;
    }else{
        self.leftContentLeadingCons.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)loginButtonClick:(id)sender {
    YYLog(@"Login Button Click");
    }


@end
