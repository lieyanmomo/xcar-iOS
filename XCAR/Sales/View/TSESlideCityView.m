//
//  TSESlideCityView.m
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSESlideCityView.h"
#import "Public.h"

@interface TSESlideCityView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>;

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation TSESlideCityView

- (instancetype)initWithViewWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        
        [self setFrame:CGRectMake(0.0, 0.0, width, ScreenHeight)];
        [self setBackgroundColor:TSEAColor(160, 160, 160, 0)];
        
        UIView *parentView = [[UIView alloc] init];
        [parentView setFrame:CGRectMake(0.0, 0.0, width, ScreenHeight)];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:@"选择城市"];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:18]];
        [titleLabel setFrame:CGRectMake(0.0, 0.0, ScreenWidth * 3 / 2, 44.0)];
        [parentView addSubview:titleLabel];
        
        // 最开始的tableView隐藏在屏幕的最右侧
        CGFloat tableViewY = CGRectGetMaxY(titleLabel.frame);
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, tableViewY, ScreenWidth * 3 / 2, ScreenHeight) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [parentView addSubview:tableView];
        [self addSubview:parentView];
        self.tableView = tableView;
        
        [self showSlideCityView];
    }
    
    return self;
}

#pragma mark - Table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"test";
    // 1.从重用对象池中找不用的cell对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // 3.设置cell的属性
    [cell.textLabel setText:@"123456789011121314151617181920 "];
    
    return cell;
}

#pragma mark - Table view delegate

/**
 *  展示SlideCityView
 */
- (void)showSlideCityView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = TSEAColor(160, 160, 160, 0.4);
        [UIView animateWithDuration:.25 animations:^{
            [self.tableView setFrame:CGRectMake(ScreenWidth / 3, 0.0, ScreenWidth * 3 / 2, ScreenHeight)];
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showInView:(UIViewController *)showVC {
    if (!showVC) {
        // 获取当前视图的控制器
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    } else {
        [showVC.view addSubview:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

- (void)tappedCancel {
    [UIView animateWithDuration:.25 animations:^{
        [self.tableView setFrame:CGRectMake(ScreenWidth, 0.0, ScreenWidth * 3 / 2, ScreenHeight)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
