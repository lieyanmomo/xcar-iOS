//
//  TSEWebViewController.m
//  XCAR
//
//  Created by Morris on 9/25/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEWebViewController.h"
#import "TSEBarButtonItem.h"
#import "Public.h"

@interface TSEWebViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation TSEWebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
}

- (void)initWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight)];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [TSEBarButtonItem barButtonWithImage:@"nav_fanhui" title:@"返回" target:self action:@selector(backToLatesetView)];

    self.navigationItem.rightBarButtonItem = [TSEBarButtonItem barButtonWithTitle:@"更多" target:self action:@selector(moreButtonClick)];
    
    // 为webView添加点击手势
    UITapGestureRecognizer* singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGesture.delegate = self; // 设置代理
    [self.webView addGestureRecognizer:singleTapGesture];
    
    [self.view addSubview:self.webView];
}

- (void)backToLatesetView {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)moreButtonClick {
    TSELog(@"more button clicked");
}

- (void)handleSingleTapGesture:(UIGestureRecognizer *)sender {
    
    UIWebView *webView = (UIWebView *)sender.view;
    CGPoint pt = [sender locationInView:webView];
    NSString *urlString = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y]];
    if (urlString.length > 0) {
        NSLog(@"\nImage_URL:%@", urlString);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES; // 是否允许同时响应多手势，因为UIWebView自身也响应点击事件
}

#pragma mark - Web view delegate 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

/**
 *  网页开始加载的时候调用
 */
- (void )webViewDidStartLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    UIView *footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor orangeColor]];
    CGFloat height = 50.0;
    CGFloat width = self.view.frame.size.width;
    CGFloat x = 0.0;
    CGFloat y = self.view.frame.size.height - height * 2;
    [footerView setFrame:CGRectMake(x, y, width, height)];
    
//    [webView addSubview:footerView];
}

/**
 *  网页加载完成的时候调用
 */
- (void )webViewDidFinishLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/**
 *  网页加载错误的时候调用
 */
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
