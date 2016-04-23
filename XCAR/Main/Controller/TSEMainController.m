//
//  TSEMainController.m
//  XCar
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEMainController.h"
#import "TSENavigationController.h"

#import "TSELatestNewsViewController.h"
#import "TSEVideoViewController.h"
#import "TSEGuideViewController.h"
#import "TSEEvaluatingViewController.h"
#import "TSEMarketViewController.h"

#import "TSEChoicePostsViewController.h"
#import "TSEHotPostsViewController.h"
#import "TSEFindFourmViewController.h"

#import "TSEProfileViewController.h"

#import "TSEBrandFindCarViewController.h"
#import "TSEConditionFindCarViewController.h"

#import "TSEDepreciateViewController.h"
#import "TSEEventViewController.h"
#import "TSEDiscountViewController.h"
#import "TSEApplyViewController.h"

#import "WMPageController.h"

#import "Public.h"

#define kTitlesNormalColor TSEColor(45, 48, 53)
#define kTitleSelectedColor TSEColor(63, 169, 213)

@interface TSEMainController ()

@end

@implementation TSEMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMainViewController];
}

- (void)initMainViewController {
    
    // 1.
    // 1.1
    NSMutableArray *homeVCs = [[NSMutableArray alloc] init];
    NSMutableArray *homeVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [TSELatestNewsViewController class];
                title = @"最新";
                break;
            case 1:
                vcClass = [TSEVideoViewController class];
                title = @"视频";
                break;
            case 2:
                vcClass = [TSEGuideViewController class];
                title = @"导购";
                break;
            case 3:
                vcClass = [TSEEvaluatingViewController class];
                title = @"测评";
                break;
            case 4:
                vcClass = [TSEMarketViewController class];
                title = @"行情";
                break;
        }
        [homeVCs addObject:vcClass];
        [homeVCTitles addObject:title];
    }
    
    WMPageController *homeVC = [[WMPageController alloc] initWithViewControllerClasses:homeVCs andTheirTitles:homeVCTitles];
    UINavigationController *homeNav =  [[UINavigationController alloc] initWithRootViewController:homeVC];
    [homeVC.navigationController setNavigationBarHidden:YES];
    homeVC.menuViewStyle = WMMenuViewStyleLine;
    homeVC.menuItemWidth = 66;
    homeVC.titleColorNormal = kTitlesNormalColor;
    homeVC.titleColorSelected = kTitleSelectedColor;
    homeVC.postNotification = YES;
    
    // 1.2
    NSMutableArray *bbsVCs = [[NSMutableArray alloc] init];
    NSMutableArray *bbsVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [TSEChoicePostsViewController class];
                title = @"精选";
                break;
            case 1:
                vcClass = [TSEHotPostsViewController class];
                title = @"热帖";
                break;
            case 2:
                vcClass = [TSEFindFourmViewController class];
                title = @"找论坛";
                break;
        }
        [bbsVCs addObject:vcClass];
        [bbsVCTitles addObject:title];
    }
    
    WMPageController *bbsVC = [[WMPageController alloc] initWithViewControllerClasses:bbsVCs andTheirTitles:bbsVCTitles];
    UINavigationController *bbsNav =  [[UINavigationController alloc] initWithRootViewController:bbsVC];
    [bbsVC.navigationController setNavigationBarHidden:YES];
    bbsVC.menuViewStyle = WMMenuViewStyleLine;
    bbsVC.menuItemWidth = 66;
    bbsVC.titleColorNormal = kTitlesNormalColor;
    bbsVC.titleColorSelected = kTitleSelectedColor;
    bbsVC.postNotification = YES;
    
    // 1.3
    TSEProfileViewController *profileVC = [[TSEProfileViewController alloc] init];
    
    // 1.4
    NSMutableArray *findVCs = [[NSMutableArray alloc] init];
    NSMutableArray *findVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [TSEBrandFindCarViewController class];
                title = @"品牌找车";
                break;
            case 1:
                vcClass = [TSEConditionFindCarViewController class];
                title = @"条件找车";
                break;
        }
        [findVCs addObject:vcClass];
        [findVCTitles addObject:title];
    }
    
    WMPageController *findVC = [[WMPageController alloc] initWithViewControllerClasses:findVCs andTheirTitles:findVCTitles];
    UINavigationController *findNav =  [[UINavigationController alloc] initWithRootViewController:findVC];
    [findVC.navigationController setNavigationBarHidden:YES];
    findVC.menuViewStyle = WMMenuViewStyleLine;
    findVC.menuItemWidth = 88;
    findVC.titleColorNormal = kTitlesNormalColor;
    findVC.titleColorSelected = kTitleSelectedColor;
    findVC.postNotification = YES;
    
    // 1.5
    NSMutableArray *salesVCs = [[NSMutableArray alloc] init];
    NSMutableArray *salesVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [TSEDepreciateViewController class];
                title = @"降价";
                break;
            case 1:
                vcClass = [TSEEventViewController class];
                title = @"活动";
                break;
            case 2:
                vcClass = [TSEDiscountViewController class];
                title = @"车有惠";
                break;
            case 3:
                vcClass = [TSEApplyViewController class];
                title = @"我报名的";
                break;
        }
        [salesVCs addObject:vcClass];
        [salesVCTitles addObject:title];
    }
    
    WMPageController *salesVC = [[WMPageController alloc] initWithViewControllerClasses:salesVCs andTheirTitles:salesVCTitles];
    UINavigationController *salesNav =  [[UINavigationController alloc] initWithRootViewController:salesVC];
    [salesVC.navigationController setNavigationBarHidden:YES];
    salesVC.menuViewStyle = WMMenuViewStyleLine;
    salesVC.menuItemWidth = 88;
    salesVC.titleColorNormal = kTitlesNormalColor;
    salesVC.titleColorSelected = kTitleSelectedColor;
    salesVC.postNotification = YES;
    
    // 2.初始化tabBarCtr
    NSArray *viewCtrs = @[homeNav, bbsNav, profileVC, findNav, salesNav];
    [self setViewControllers:viewCtrs animated:YES];
    UITabBar *tabBar = self.tabBar;
    
    // 3.设置控制器属性
    [self setupChildViewController:homeVC title:@"首页" imageName:@"tab_shouye_baitian" selectedImageName:@"tab_shouye_baitian_hit" tabBar:tabBar index:0];
    
    [self setupChildViewController:bbsVC title:@"论坛" imageName:@"tab_luntan_baitian" selectedImageName:@"tab_luntan_baitian_hit" tabBar:tabBar index:1];
    
    [self setupChildViewController:profileVC title:@"我" imageName:@"tabbar_me" selectedImageName:@"tabbar_me" tabBar:tabBar index:2];
    
    [self setupChildViewController:findVC title:@"找车" imageName:@"tab_zhaoche_baitian" selectedImageName:@"tab_zhaoche_baitian_hit" tabBar:tabBar index:3];
    
    [self setupChildViewController:salesVC title:@"降价" imageName:@"tab_jiangjia_baitian" selectedImageName:@"tab_jiangjia_baitian_hit" tabBar:tabBar index:4];
    
    // 改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TSEColor(43, 177, 223),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

- (void)setupChildViewController:(UIViewController *)childVC
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName
                          tabBar:(UITabBar *)tabBar
                           index:(NSUInteger)index {
    childVC.title = title;
    UITabBarItem *item = [tabBar.items objectAtIndex:index];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 设置不对图片进行蓝色的渲染
    [item setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
