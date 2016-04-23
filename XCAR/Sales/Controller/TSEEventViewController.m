//
//  TSEEventViewController.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEEventViewController.h"
#import "TSEWebViewController.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEEventNews.h"
#import "TSEEventNewsCell.h"
#import "TSEEventNewsCellFrame.h"
#import "TSEHttpTool.h"

#import "Public.h"

@interface TSEEventViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *eventNewsFrame;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation TSEEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    // 下拉加载最新数据
    [self pullDownToRefreshEventNews];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshEventNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestEventNews)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

- (void)requestEventNews {
    [TSEHttpTool get:kGetSalesInfoURL params:nil success:^(id json) {
//        TSELog(@"carnews------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEEventNews模型
        NSArray *eventNewsArr = [TSEEventNews objectArrayWithKeyValuesArray:json];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEEventNews *news in eventNewsArr) {
            TSEEventNewsCellFrame *f = [[TSEEventNewsCellFrame alloc] init];
            f.eventNews = news;
            [newsArray addObject:f];
        }
        
        self.eventNewsFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error-------/n%@", error);
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventNewsFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 构造TSEEventNewsCell
    TSEEventNewsCell *cell = [TSEEventNewsCell cellWithTableView:tableView];
    // 设置数据
    cell.eventNewsCellFrame = self.eventNewsFrame[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEEventNewsCellFrame *enf = self.eventNewsFrame[indexPath.row];
    return enf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEEventNewsCellFrame *enf = self.eventNewsFrame[indexPath.row];
    TSEEventNews *news = enf.eventNews;
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = news.eventLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 20.0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    // 取消cell的分割线
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 为tableView增加额外的滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
