//
//  TSEHotPostsViewController.m
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPostsViewController.h"

#import "TSENavigationController.h"
#import "TSEWebViewController.h"
#import "TSEBarButtonItem.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEHotPostCellFrame.h"
#import "TSEHotPostCell.h"
#import "TSEHotPost.h"
#import "TSEHotPostHeaderView.h"

#import "TSEHttpTool.h"

#import "Public.h"

@interface TSEHotPostsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) TSEWebViewController *webVC;
@property (nonatomic, weak) TSEHotPostHeaderView *headerView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *hotPostFrame;
@property (nonatomic, strong) NSMutableDictionary *paras;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation TSEHotPostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    [self setupHeaderView];
    
    // 下拉刷新最新数据
    [self pullDownToRefreshHotPostData];
    // 上拉加载更多数据
    [self pullUpToLoadMoreHotPostData];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshHotPostData {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHotPostData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/**
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreHotPostData {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreHotPostData];
    }];
}

- (void)requestHotPostData {
    [TSEHttpTool get:kGetHotPostURL params:self.paras success:^(id json) {
//        TSELog(@"success-------%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEHotPost模型
        NSArray *postsArr = [TSEHotPost objectArrayWithKeyValuesArray:json[@"postList"]];

        // 创建frame模型对象
        NSMutableArray *hotPostArray = [NSMutableArray array];
        for (TSEHotPost *post in postsArr) {
            TSEHotPostCellFrame *f = [[TSEHotPostCellFrame alloc] init];
            f.hotPost = post;
            [hotPostArray addObject:f];
        }
        
        self.hotPostFrame = hotPostArray;
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error-------%@", error);
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreHotPostData {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[VER] = @"6.2";
    
    [TSEHttpTool get:kGetHotPostURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是TSEHotPost模型
        NSArray *postsArr = [TSEHotPost objectArrayWithKeyValuesArray:json[@"postList"]];
        
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (TSEHotPost *post in postsArr) {
            TSEHotPostCellFrame *f = [[TSEHotPostCellFrame alloc] init];
            f.hotPost = post;
            [postArray addObject:f];
        }
        
        [self.hotPostFrame addObjectsFromArray:postArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"fail------%@", error);
        [self.tableView.footer endRefreshing];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hotPostFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHotPostCell *cell = [TSEHotPostCell cellWithTableView:tableView];
    cell.hotPostCellFrame = self.hotPostFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table View delegate
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHotPostCellFrame *hpf = self.hotPostFrame[indexPath.row];
    return hpf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHotPostCellFrame *f = self.hotPostFrame[indexPath.row];
    TSEHotPost  *post = f.hotPost;TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = post.postLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy loading
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @20;
        _paras[OFFSET] = @0;
        _paras[VER] = @"6.2";
    }
    return _paras;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 20.0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset - 30.0, 0.0)];
    [tableView setBackgroundColor:TSEColor(248, 248, 248)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupHeaderView {
    TSEHotPostHeaderView *headerView = [[TSEHotPostHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 40.0)];
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
