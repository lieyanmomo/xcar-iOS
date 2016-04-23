//
//  TSEDiscountViewController.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEDiscountViewController.h"
#import "TSEWebViewController.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEDiscountNewsCell.h"
#import "TSEDiscountNewsCellFrame.h"
#import "TSEDiscountNews.h"
#import "TSESlideCityView.h"

#import "TSEHttpTool.h"
#import "Public.h"

@interface TSEDiscountViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *discountNewsCellFrame;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation TSEDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    // 下拉加载最新数据
    [self pullDownToRefreshSalesListData];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshSalesListData {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestSalesListData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

- (void)requestSalesListData {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[CITYID] = @475;
    
    [TSEHttpTool get:kGetSalesByCityId params:paras success:^(id json) {
//        TSELog(@"salesList--------/n%@", json);
        
        // 通过数组字典返回模型，该数组中装的都是TSEDiscountNews模型
        NSArray *dicountNewsArr = [TSEDiscountNews objectArrayWithKeyValuesArray:json];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (TSEDiscountNews *news in dicountNewsArr) {
            TSEDiscountNewsCellFrame *f = [[TSEDiscountNewsCellFrame alloc] init];
            f.discountNews = news;
            [newsArray addObject:f];
        }
        
        self.discountNewsCellFrame = newsArray;
        // 刷新tableView
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error------%@", error);
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.discountNewsCellFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstRow"];
        [cell.textLabel setText:@"当前城市：北京"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    } else {
        TSEDiscountNewsCell *cell = [TSEDiscountNewsCell cellWithTableView:tableView];
        cell.discountNewsCellFrame = self.discountNewsCellFrame[indexPath.row];
        return cell;
    }
}

#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40.0f;
    } else {
        TSEDiscountNewsCellFrame *dnf = self.discountNewsCellFrame[indexPath.row];
        return dnf.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    TSEDiscountNewsCellFrame *dnf = self.discountNewsCellFrame[indexPath.row];
//    TSEDiscountNews *news = dnf.discountNews;
    
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.title = @"活动详情";
//        webVC.urlStr = news.;
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
