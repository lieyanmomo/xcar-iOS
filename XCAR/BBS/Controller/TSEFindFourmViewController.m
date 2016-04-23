//
//  TSEFindFourmViewController.m
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEFindFourmViewController.h"

#import "TSEFindForumView.h"

@interface TSEFindFourmViewController ()

@end

@implementation TSEFindFourmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TSEFindForumView *findForumView = [[TSEFindForumView alloc] init];
    [findForumView setFrame:self.view.frame];
    [self.view addSubview:findForumView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
