//
//  TSEGuideViewController.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEGuideViewController.h"

#import "TSENavigationController.h"
#import "TSEWebViewController.h"
#import "TSEBarButtonItem.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEHttpTool.h"
#import "TSEHomeViewNews.h"
#import "TSEHomeViewNewsCell.h"
#import "TSEHomeViewNewsCellFrame.h"

#import "Public.h"

#define kGuideNewsNum @10

@interface TSEGuideViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *guideNewsFrame;

@property (nonatomic, weak) TSEWebViewController *webVC;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;
@end

@implementation TSEGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
// 1 13 1 313 13 
    // 设置tableView
    [self setupTableView];
    
    // 下拉加载最新数据
    [self pullDownToRefreshGuideNews];
    
    // 上拉加载更多数据
    [self pullUpToLoadMoreVideoNews];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshGuideNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requesGuideNews)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/**
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreVideoNews {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreGuideNews];
    }];
}

- (void)requesGuideNews {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = kGuideNewsNum;
    paras[OFFSET] = @0;
    paras[TYPE] = @4;
    paras[VER] = @"6.2";
    
    [TSEHttpTool get:kGetCarNewsURL params:paras success:^(id json) {
//        TSELog(@"carnews------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEHomeViewNews模型
        NSArray *guideNewsArr = [TSEHomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEHomeViewNews *news in guideNewsArr) {
            TSEHomeViewNewsCellFrame *f = [[TSEHomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        self.guideNewsFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新状态
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error-------/n%@", error);
        // 结束刷新状态
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreGuideNews {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @4;
    paras[VER] = @"6.2";
    
    [TSEHttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是XZMDoesticCarNews模型
        NSArray *guideNewsArr = [TSEHomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEHomeViewNews *news in guideNewsArr) {
            TSEHomeViewNewsCellFrame *f = [[TSEHomeViewNewsCellFrame alloc] init];
            f.homeViewNews = news;
            [newsArray addObject:f];
        }
        
        [self.guideNewsFrame addObjectsFromArray:newsArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"fail------%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guideNewsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建TSEHomeViewNewsCell
    TSEHomeViewNewsCell *cell = [TSEHomeViewNewsCell cellWithTableView:tableView];
    // 2.设置cell的属性
    cell.homeViewNewsCellFrame = self.guideNewsFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHomeViewNewsCellFrame *lnf = self.guideNewsFrame[indexPath.row];
    return lnf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHomeViewNewsCellFrame *f = self.guideNewsFrame[indexPath.row];
    TSEHomeViewNews *news = f.homeViewNews;
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = news.newsLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 20.0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    [tableView setBackgroundColor:TSEColor(248, 248, 248)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end
