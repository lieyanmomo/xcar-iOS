//
//  TSEDiscountNewsCell.m
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEDiscountNewsCell.h"

#import "TSEDiscountNewsView.h"
#import "TSEDiscountNewsCellFrame.h"
#import "Public.h"

@interface TSEDiscountNewsCell ()

@property (nonatomic, weak) TSEDiscountNewsView *discountNewsView;

@end

@implementation TSEDiscountNewsCell

static NSString * const kCellIdentifier = @"DISCOUNT";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEDiscountNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEDiscountNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:TSEColor(235, 235, 235)];
        
        // 设置DiscountNewsView
        [self setupDiscountNewsView];
    }
    return self;
}

/**
 *  设置DiscountNewsView
 */
- (void)setupDiscountNewsView {
    /** DiscountNewsView父视图 */
    TSEDiscountNewsView *discountNewsView = [[TSEDiscountNewsView alloc] init];
    [self.contentView addSubview:discountNewsView];
    self.discountNewsView = discountNewsView;
}

/**
 *  override setter
 */
- (void)setDiscountNewsCellFrame:(TSEDiscountNewsCellFrame *)discountNewsCellFrame {
    _discountNewsCellFrame = discountNewsCellFrame;
    [self setupDiscountNewsData];
}

/**
 *  设置eventNews数据
 */
- (void)setupDiscountNewsData {
    self.discountNewsView.discountNewsCellFrame = self.discountNewsCellFrame;
    self.discountNewsView.frame = self.discountNewsCellFrame.discountNewsViewFrame;
}

@end
