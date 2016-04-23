//
//  TSESubBrandCarViewController.m
//  XCAR
//
//  Created by Morris on 10/10/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSESubBrandCarViewController.h"
#import "TSESubBrandCarCell.h"
#import "TSEHttpTool.h"
#import "Public.h"

#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "TSEBrandCar.h"
#import "TSEBrand.h"

#import "TSESubBrand.h"
#import "TSESeries.h"

@interface TSESubBrandCarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *series;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *brands;

@end

@implementation TSESubBrandCarViewController

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath brands:(NSArray *)brands {
    self = [super init];
    if (self) {
        
        _indexPath = indexPath;
        _brands = brands;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestSubBrandCarDateWithIndex:self.indexPath brands:self.brands];
    [self setupTableView];
}

/**
 *  获取子品牌的所有数据
 */
- (void)requestSubBrandCarDateWithIndex:(NSIndexPath *)indexPath brands:(NSArray *)brands{
    // 获取当前品牌的id号
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    TSEBrandCar *car = brands[indexPath.section];
    TSEBrand *brand = car.brands[indexPath.row];
    paras[BRANDID] = brand.ID;
    
    [TSEHttpTool get:kGetCarSubBrandsURL params:paras success:^(id json) {
//        TSELog(@"%@", json);
        // 获取子品牌
        self.series = [TSESubBrand objectArrayWithKeyValuesArray:json[@"subBrands"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        TSELog(@"error----%@", error);
    }];
}

#pragma mark - Table View datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.series count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TSESubBrand *subBrand = self.series[section];
    return [subBrand.seriesNum integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 依照section取出subBrand
    TSESubBrand *subBrand = self.series[indexPath.section];
    // 依照当前section的当前row，取出serie
    TSESeries *serie = subBrand.series[indexPath.row];
    
    TSESubBrandCarCell *cell = [TSESubBrandCarCell cellWithTableView:tableView];
    [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:serie.seriesIcon] placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    [cell.carNameLabel setText:serie.seriesName];
    [cell.carPriceLabel setText:serie.seriesPrice];
    
    return cell;
}

#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSELog(@"haha");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"header";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *brandView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 20.0)];
    [brandView setBackgroundColor:[UIColor whiteColor]];
    UILabel *brandLabel = [[UILabel alloc] init];
    [brandLabel setFont:[UIFont systemFontOfSize:16.0]];
    [brandLabel setTextColor:TSEColor(83, 163, 196)];
    [brandLabel setFrame:CGRectMake(10.0, 5.0, 200.0, 20.0)];
    
    TSESubBrand *subBrand = self.series[section];
    [brandLabel setText:subBrand.subBrandName];
    [brandView addSubview:brandLabel];
    
    return brandView;
}

#pragma mark - private methods
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth / 4 * 3, ScreenHeight - 100.0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:TSEColor(248, 248, 248)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end
