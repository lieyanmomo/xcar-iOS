//
//  TSEChoicePostsViewController.m
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEChoicePostsViewController.h"

#import "TSENavigationController.h"
#import "TSEWebViewController.h"
#import "TSEBarButtonItem.h"

#import <MJExtension.h>
#import <MJRefresh.h>

#import "TSEChoicePostCellFrame.h"
#import "TSEChoicePostsCell.h"
#import "TSEChoicePost.h"
#import "TSEChoiceFocusPost.h"
#import "TSEXCARLoopView.h"

#import "TSEHttpTool.h"

#import "Public.h"

@interface TSEChoicePostsViewController () <UITableViewDataSource, UITableViewDelegate, TSEXCARLoopViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *paras;
@property (nonatomic, strong) NSMutableArray *choicePostFrame;
@property (nonatomic, strong) NSArray *focusPost;
@property (nonatomic, strong) NSMutableArray *imgsArr;

@property (nonatomic, weak) TSEWebViewController *webVC;
@property (nonatomic, weak) TSEXCARLoopView *loopView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;

@end

@implementation TSEChoicePostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTopView];
    [self setupHeaderView];
    // 下拉加载最新数据
    [self pullDownToRefreshChoicePost];
    // 上拉加载更多数据
    [self pullUpToLoadMoreChoicePost];
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshChoicePost {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestChoiceNewsData)];
    // 设置header
    [self.tableView.header beginRefreshing];
}

/**
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreChoicePost {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreChoiceNewsData];
    }];
}

- (void)requestChoiceNewsData {
    [TSEHttpTool get:kGetForumInfoURL params:self.paras success:^(id json) {
//        TSELog(@"success:-----%@", json);
        
        // 获取滚动新闻
        self.focusPost = [TSEChoiceFocusPost objectArrayWithKeyValuesArray:json[@"focusPost"]];
        // 设置tableView header
        [self setupTableHeaderViewWithFocusPosts:self.focusPost];
        
        // 通过数组字典返回模型，该数组中装的都是TSEChoicePost模型
        NSArray *postsArr = [TSEChoicePost objectArrayWithKeyValuesArray:json[@"postList"]];
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (TSEChoicePost *post in postsArr) {
            TSEChoicePostCellFrame *f = [[TSEChoicePostCellFrame alloc] init];
            f.choicePost = post;
            [postArray addObject:f];
        }
        
        self.choicePostFrame = postArray;
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新状态
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"error:-----%@", error);
        // 结束刷新状态
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreChoiceNewsData {
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[LIMIT] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[OFFSET] = [NSString stringWithFormat:@"%d", _offset];
    paras[TYPE] = @1;
    paras[VER] = @"6.2";
    
    [TSEHttpTool get:kGetForumInfoURL params:paras success:^(id json) {
        // 通过数组字典返回模型，该数组中装的都是TSEChoicePost模型
        NSArray *postsArr = [TSEChoicePost objectArrayWithKeyValuesArray:json[@"postList"]];
        
        // 创建frame模型对象
        NSMutableArray *postArray = [NSMutableArray array];
        for (TSEChoicePost *post in postsArr) {
            TSEChoicePostCellFrame *f = [[TSEChoicePostCellFrame alloc] init];
            f.choicePost = post;
            [postArray addObject:f];
        }
        
        [self.choicePostFrame addObjectsFromArray:postArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        TSELog(@"fail------%@", error);
        [self.tableView.footer endRefreshing];
    }];
}

- (void)setupTableHeaderViewWithFocusPosts:(NSArray *)focusPosts {
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        self.imgsArr = [NSMutableArray array];
        for (TSEChoiceFocusPost *post in focusPosts) {
            NSString *urlStr = post.focusImage;
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.choicePostFrame count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEChoicePostsCell *cell = [TSEChoicePostsCell cellWithTableView:tableView];
    cell.choicePostCellFrame = self.choicePostFrame[indexPath.row];
    
    return cell;
}

#pragma mark - Table View delegate
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEChoicePostCellFrame *cpf = self.choicePostFrame[indexPath.row];
    return cpf.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSEChoicePostCellFrame *f = self.choicePostFrame[indexPath.row];
    TSEChoicePost  *post = f.choicePost;
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = post.postLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Loop View delegate
- (void)loopViewDidSelectedImage:(TSEXCARLoopView *)loopView index:(int)index {
    TSELog(@"selected index:%d", index);
    TSEChoiceFocusPost *post = self.focusPost[index];
    TSEWebViewController *webVC = [[TSEWebViewController alloc] init];
    webVC.urlStr = post.focusLink;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy load
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[LIMIT] = @20;
        _paras[OFFSET] = @0;
        _paras[TYPE] = @1;
        _paras[VER] = @"6.2";
    }
    return _paras;
}

#pragma mark - private
- (void)setupTopView {
    UIView *collectView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, ScreenWidth, 40.0)];
    [collectView setBackgroundColor:TSEColor(248, 248, 248)];
    
    UILabel *collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, 40.0, 44.0)];
    [collectLabel setText:@"收藏"];
    [collectLabel setTextColor:TSEColor(141, 142, 152)];
    [collectLabel setFont:[UIFont systemFontOfSize:13]];
    [collectLabel setBackgroundColor:TSEColor(248, 248, 248)];
    [collectView addSubview:collectLabel];
    
    UIButton *collectBtn = [[UIButton alloc] init];
    [collectBtn setFrame:CGRectMake(CGRectGetMaxX(collectLabel.frame), collectView.frame.size.height / 4.6, 80.0, 26.0)];
    [collectBtn.layer setBorderWidth:0.4];
    [collectBtn.layer setBorderColor:TSEColor(223, 223, 223).CGColor];
    [collectBtn.layer setCornerRadius:5];
    [collectBtn setTitle:@"奔驰C级论坛" forState:UIControlStateNormal];
    [collectBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [collectBtn setTitleColor:TSEColor(141, 142, 152) forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(goToFavouriteForum) forControlEvents:UIControlEventTouchDown];
    [collectView addSubview:collectBtn];
    [self.view addSubview:collectView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(collectView.frame), ScreenWidth, ScreenHeight - 3 * collectView.frame.size.height) style:UITableViewStyleGrouped];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 设置tableView的额外滚动区域
    [tableView setBackgroundColor:TSEColor(248, 248, 248)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)goToFavouriteForum {
    TSELog(@"go To Collect Forum");
}

- (void)setupHeaderView {
    TSEXCARLoopView *loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.loopView = loopView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
