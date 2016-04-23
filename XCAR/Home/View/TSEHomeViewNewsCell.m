//
//  TSEHomeViewNewsCell.m
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEHomeViewNewsCell.h"
#import "TSEHomeViewNewsView.h"
#import "TSEHomeViewNewsCellFrame.h"

#import "UIImageView+WebCache.h"

@interface TSEHomeViewNewsCell ()

/** 父视图 */
@property (nonatomic, weak) TSEHomeViewNewsView *homeViewNewsView;

@end

@implementation TSEHomeViewNewsCell

static NSString * const kCellIdentifier = @"HOMEVIEWNEWS";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEHomeViewNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEHomeViewNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置主页新闻的frame
        [self setupHomeViewNewsView];
    }
    return self;
}

/**
 *  设置主页新闻的frame
 */
- (void)setupHomeViewNewsView {
    /** 父视图 */
    TSEHomeViewNewsView *homeViewNewsView = [[TSEHomeViewNewsView alloc] init];
    [self.contentView addSubview:homeViewNewsView];
    self.homeViewNewsView = homeViewNewsView;
}

/**
 *  override setter
 */
- (void)setHomeViewNewsCellFrame:(TSEHomeViewNewsCellFrame *)homeViewNewsCellFrame {
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    // 设置主页新闻数据
    [self setupHomeViewNewsData];
}

/**
 *  设置主页新闻数据
 */
- (void)setupHomeViewNewsData {
    self.homeViewNewsView.homeViewNewsCellFrame = self.homeViewNewsCellFrame;
    self.homeViewNewsView.frame = self.homeViewNewsCellFrame.homeViewNewsViewFrame;
}

/**
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kHomeViewNewsTableViewMargin;
    frame.origin.y += kHomeViewNewsTableViewMargin;
    frame.size.width -= kHomeViewNewsTableViewMargin;
    frame.size.height -= kHomeViewNewsTableViewMargin;
    [super setFrame:frame];
}

@end