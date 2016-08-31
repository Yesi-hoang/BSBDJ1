//
//  YYWebViewController.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YYWebViewController.h"

@interface YYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation YYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

- (void)setupWebView {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

    
}
- (IBAction)refreshButtonClick:(id)sender {
    [self.webView reload];
}
- (IBAction)backButtonClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardButtonClick:(id)sender {
    [self.webView goForward];
}

#pragma mark - WebView Delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.backButton.enabled = webView.canGoBack;
    self.forwardButton.enabled = webView.canGoForward;

}

@end
