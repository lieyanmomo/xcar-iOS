//
//  TSEHotNewsViewController.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSELatestNewsViewController.h"

#import "TSENavigationController.h"
#import "TSEWebViewController.h"
#import "TSEBarButtonItem.h"

#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>

#import "TSEHttpTool.h"
#import "TSEHomeViewNews.h"
#import "TSEHomeViewNewsCell.h"
#import "TSEHomeViewNewsCellFrame.h"

#import "TSELatestFocusNews.h"

#import "TSEXCARLoopView.h"

#import "Public.h"

@interface TSELatestNewsViewController () <UITableViewDataSource, UITableViewDelegate, TSEXCARLoopViewDelegate>

@property (nonatomic, strong) NSMutableArray *latestNewsFrame;
@property (nonatomic, strong) NSMutableDictionary *paras;
@property (nonatomic, strong) NSArray *latestNews;
@property (nonatomic, strong) NSArray *foucsNews;
@property (nonatomic, strong) NSMutableArray *imgsArr;

@property (nonatomic, weak) TSEWebViewController *webVC;
@property (nonatomic, weak) TSEXCARLoopView *loopView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int imgIndex;

@end

@implementation TSELatestNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    // 下拉加载最新数据
    [self pullDownToRefreshLatestNews];
    // 上拉加载更多数据
    [self pullUpToLoadMoreNews];
    // haibin shabi
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshLatestNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestLatestNews)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/**
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreNews {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreLatestNews];
    }];
}

- (void)requestLatestNews {
    [TSEHttpTool get:kGetCarNewsURL params:self.paras success:^(id json) {
//        TSELog(@"carnews------/n%@", json);
        
        // 获取滚动新闻
        self.foucsNews = [TSELatestFocusNews objectArrayWithKeyValuesArray:json[@"focusList"][@"focusImgs"]];
        // 设置tableView header
        [self setupTableHeaderViewWithFocusNews:self.foucsNews];
        
        // 通过数组字典返回模型，该数组中装的都是TSEHomeViewNews模型
        NSArray *latestNewsArr = [TSEHomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEHomeViewNews *news in latestNewsArr) {
            // 判断是否为广告
            if (!news.adIndex) { // 不是的话加进数组
                TSEHomeViewNewsCellFrame *f = [[TSEHomeViewNewsCellFrame alloc] init];
                f.homeViewNews = news;
                [newsArray addObject:f];
            }
        }
        
        self.latestNewsFrame = newsArray;
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

- (void)requestMoreLatestNews {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @1;
    paras[VER] = @"6.2";
    
    [TSEHttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        
        // 通过数组字典返回模型，该数组中装的都是XZMDoesticCarNews模型
        NSArray *latestNewsArr = [TSEHomeViewNews objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEHomeViewNews *news in latestNewsArr) {
            // 判断是否为广告
            if (!news.adIndex) { // 不是的话加进数组
                TSEHomeViewNewsCellFrame *f = [[TSEHomeViewNewsCellFrame alloc] init];
                f.homeViewNews = news;
                [newsArray addObject:f];
            }
        }
        
        [self.latestNewsFrame addObjectsFromArray:newsArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"fail------%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

/**
 *  设置tableHeaderView
 *
 *  @param focusNewsArr 装有TSELatestFocusNews模型的数组
 */
- (void)setupTableHeaderViewWithFocusNews:(NSArray *)focusNewsArr {
    
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.imgsArr = [NSMutableArray array];
        for (TSELatestFocusNews *news in focusNewsArr) {
            NSString *urlStr = news.imgURL;
            NSURL *imageUrl = [NSURL URLWithString:urlStr];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            [self.imgsArr addObject:image];
        }
        
        // 当图片下载完成后，在主线程设置tableHeaderView的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
        });
    });
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 20.0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    // 设置tableView的额外滚动区域
    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:TSEColor(248, 248, 248)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    TSEXCARLoopView *loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.loopView = loopView;
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.latestNewsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建TSEHomeViewNewsCell
    TSEHomeViewNewsCell *cell = [TSEHomeViewNewsCell cellWithTableView:tableView];
    // 2.设置cell的属性
    cell.homeViewNewsCellFrame = self.latestNewsFrame[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHomeViewNewsCellFrame *f = self.latestNewsFrame[indexPath.row];
    return f.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEHomeViewNewsCellFrame *f = self.latestNewsFrame[indexPath.row];
    TSEHomeViewNews *news = f.homeViewNews;
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = news.newsLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Loop View delegate 
- (void)loopViewDidSelectedImage:(TSEXCARLoopView *)loopView index:(int)index {
    TSELog(@"selected index:%d", index);
    TSELatestFocusNews *news = self.foucsNews[index];
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = news.newsLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy load
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @30;
        _paras[OFFSET] = @0;
        _paras[TYPE] = @1;
        _paras[VER] = @"6.2";
    }
    
    return _paras;
}

@end
