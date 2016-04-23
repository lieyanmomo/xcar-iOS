//
//  TSEDepreciateViewController.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateViewController.h"
#import "TSEDepreciateTopView.h"
#import "TSEWebViewController.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEDepreciateNews.h"
#import "TSEDepreciateNewsCell.h"
#import "TSEDepreciateNewsCellFrame.h"
#import "TSEHttpTool.h"

#import "Public.h"

@interface TSEDepreciateViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *paras;
@property (nonatomic, strong) NSMutableArray *depreciateNewsFrame;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation TSEDepreciateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseView];
    // 下拉加载最新数据
    [self pullDownToRefreshMarketNews];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshMarketNews {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDepreciateNewsData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

- (void)requestDepreciateNewsData {
    [TSEHttpTool get:kGetDiscountInfoURL params:self.paras success:^(id json) {
//        TSELog(@"success-------%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEDepreciateNews模型
        NSArray *depreciateArr = [TSEDepreciateNews objectArrayWithKeyValuesArray:json[@"discountList"]];
        
        // 创建frame模型对象
        NSMutableArray *depreciateArray = [NSMutableArray array];
        for (TSEDepreciateNews *news in depreciateArr) {
            TSEDepreciateNewsCellFrame *f = [[TSEDepreciateNewsCellFrame alloc] init];
            f.depreciateNews = news;
            [depreciateArray addObject:f];
        }
        
        self.depreciateNewsFrame = depreciateArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error-------%@", error);
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - Table view datasource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.depreciateNewsFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEDepreciateNewsCell *cell = [TSEDepreciateNewsCell cellWithTableView:tableView];
    cell.depreciateNewsCellFrame = self.depreciateNewsFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEDepreciateNewsCellFrame *dnf = self.depreciateNewsFrame[indexPath.row];
    return dnf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEDepreciateNewsCellFrame *dnf = self.depreciateNewsFrame[indexPath.row];
    TSEDepreciateNews *news = dnf.depreciateNews;
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = news.link;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy loading
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[BRANDID] = @0;
        _paras[CITYID] = @348;
        _paras[PROVINCEID] = @30;
        _paras[SERIESID] = @0;
        _paras[SORTTYPE] = @1;
    }
    return _paras;
}

- (void)setupBaseView {
    TSEDepreciateTopView *topView = [[TSEDepreciateTopView alloc] init];
    [topView setFrame:CGRectMake(0.0, 20.0, ScreenWidth, 35.0)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, topView.frame.size.height + 20.0, ScreenWidth, ScreenHeight - 4 * topView.frame.size.height + 5.0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [self.view addSubview:topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
