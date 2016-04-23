//
//  TSESubBrandCarCell.m
//  XCAR
//
//  Created by Morris on 10/9/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSESubBrandCarCell.h"
#import "Public.h"

#define kSubBrandCarCellMargin 6

@interface TSESubBrandCarCell ()

@end

@implementation TSESubBrandCarCell

static NSString * const kCellIdentifier = @"SUBBRANDCAR";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSESubBrandCarCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSESubBrandCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:TSEColor(248, 248, 248)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    /** 汽车图片 */
    self.carImageView = [[UIImageView alloc] init];
    CGFloat carImageViewX = 8.0;
    CGFloat carImageViewY = 10.0;
    CGFloat carImageViewW = 100.0;
    CGFloat carImageViewH = 70.0;
    [self.carImageView setFrame:CGRectMake(carImageViewX, carImageViewY, carImageViewW, carImageViewH)];
    [self.contentView addSubview:self.carImageView];
    
    /** 汽车名称 */
    self.carNameLabel = [[UILabel alloc] init];
    [self.carNameLabel setFont:[UIFont systemFontOfSize:18.0]];
    [self.carNameLabel setTextColor:TSEColor(44, 48, 57)];
    CGFloat carNameX = CGRectGetMaxX(self.carImageView.frame) + kSubBrandCarCellMargin;
    CGFloat carNameH = 20.0;
    CGFloat carNameY = carImageViewY + carNameH / 2;
    CGFloat carNameW = 180.0;
    [self.carNameLabel setFrame:CGRectMake(carNameX, carNameY, carNameW, carNameH)];
    [self.contentView addSubview:self.carNameLabel];
    
    /** 汽车价钱 */
    self.carPriceLabel = [[UILabel alloc] init];
    [self.carPriceLabel setFont:[UIFont systemFontOfSize:18.0]];
    [self.carPriceLabel setTextColor:TSEColor(222, 114, 55)];
    CGFloat carPriceX = carNameX;
    CGFloat carPriceH = 20.0;
    CGFloat carPriceY = CGRectGetMaxY(self.carImageView.frame) - carPriceH * 1.5;
    CGFloat carPriceW = 180.0;
    [self.carPriceLabel setFrame:CGRectMake(carPriceX, carPriceY, carPriceW, carPriceH)];
    [self.contentView addSubview:self.carPriceLabel];
}

@end
