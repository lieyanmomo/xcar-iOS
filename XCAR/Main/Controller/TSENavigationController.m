//
//  TSENavigationController.m
//  XCar
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSENavigationController.h"
#import "Public.h"

@interface TSENavigationController ()

@end

@implementation TSENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBarTheme];
//    [self setupBarButtonItemTheme];
}

- (void)setupNavigationBarTheme {
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSDictionary *attrNavBar = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:attrNavBar];
    [navBar setBackgroundColor:TSEColor(248, 248, 248)];
}

- (void)setupBarButtonItemTheme {
    UIBarButtonItem *btnItem = [UIBarButtonItem appearance];
    NSDictionary *attrBtnItem = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
    [btnItem setTitleTextAttributes:attrBtnItem forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
