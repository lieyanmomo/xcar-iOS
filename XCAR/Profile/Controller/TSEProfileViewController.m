//
//  TSEProfileViewController.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEProfileViewController.h"
#import "TSEProfileHeaderView.h"
#import "TSEProfileCollectionCell.h"
#import "TSEProfileSectionView.h"

#import "Public.h"

@interface TSEProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation TSEProfileViewController

static NSString *const TableViewCellIdentifier = @"TableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.从重用对象池中找不用的cell对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableViewCellIdentifier];
        [cell setBackgroundColor:TSEColor(235, 235, 235)];
    }
    
    // 3.设置cell的属性
//    [cell.textLabel setText:@"not finished"];
    
    return cell;
}

#pragma mark - Table view delegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSELog(@"table view selected index%ld", indexPath.row);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"why";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TSEProfileSectionView *sectionView = [[TSEProfileSectionView alloc] init];
    return sectionView;
}

#pragma mark - private method
- (void)setupTableHeaderView {
    TSEProfileHeaderView *profileHeaderView = [[TSEProfileHeaderView alloc] init];
    [profileHeaderView setFrame:CGRectMake(0.0, 0.0, ScreenWidth, profileHeaderView.viewHeight)];
    UITableView *tableView = [[UITableView alloc] init];
    [tableView setFrame:CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.tableHeaderView = profileHeaderView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end
