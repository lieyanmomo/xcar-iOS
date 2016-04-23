//
//  TSEEventNewsCell.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEEventNewsCell.h"
#import "TSEEventNewsView.h"
#import "TSEEventNewsCellFrame.h"

#import "Public.h"

@interface TSEEventNewsCell ()

/**
 *  eventNews父视图
 */
@property (nonatomic, weak) TSEEventNewsView *eventNewsView;

@end

@implementation TSEEventNewsCell

static NSString * const kCellIdentifier = @"EVENT";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEEventNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEEventNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:TSEColor(235, 235, 235)];
        // 设置EventNewsView
        [self setupEventNewsView];
    }
    return self;
}

/**
 *  设置EventNewsView
 */
- (void)setupEventNewsView {
    /** eventNews父视图 */
    TSEEventNewsView *eventNewsView = [[TSEEventNewsView alloc] init];
    [self.contentView addSubview:eventNewsView];
    self.eventNewsView = eventNewsView;
}

/**
 *  override setter
 */
- (void)setEventNewsCellFrame:(TSEEventNewsCellFrame *)eventNewsCellFrame {
    _eventNewsCellFrame = eventNewsCellFrame;
    // 设置eventNews数据
    [self setupEventNewsData];
}

/**
 *  设置eventNews数据
 */
- (void)setupEventNewsData {
    self.eventNewsView.eventNewsCellFrame = self.eventNewsCellFrame;
    self.eventNewsView.frame = self.eventNewsCellFrame.eventNewsViewFrame;
}

@end
