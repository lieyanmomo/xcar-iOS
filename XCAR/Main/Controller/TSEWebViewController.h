//
//  TSEWebViewController.h
//  XCAR
//
//  Created by Morris on 9/25/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TSEWebViewController : UIViewController

//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *urlStr;

@end
