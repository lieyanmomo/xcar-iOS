//
//  TSEDepreciateNewsCell.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateNewsCell.h"

#import "TSEDepreciateNewsView.h"
#import "TSEDepreciateNewsCellFrame.h"

#import "Public.h"

@interface TSEDepreciateNewsCell ()

@property (nonatomic, weak) TSEDepreciateNewsView *depreciateNewsView;

@end

@implementation TSEDepreciateNewsCell

static NSString * const kCellIdentifier = @"DEPRECIATE";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEDepreciateNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEDepreciateNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消点击cell时候的效果
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:TSEColor(235, 235, 235)];
        
        // 设置DepreciateNewsCell
        [self setupDepreciateNewsCell];
    }
    return self;
}

/**
 *  设置DepreciateNewsCell
 */
- (void)setupDepreciateNewsCell {
    /** DepreciateNewsCell父视图 */
    TSEDepreciateNewsView *depreciateNewsView = [[TSEDepreciateNewsView alloc] init];
    [self.contentView addSubview:depreciateNewsView];
    self.depreciateNewsView = depreciateNewsView;
}

/**
 *  override setter
 */
- (void)setDepreciateNewsCellFrame:(TSEDepreciateNewsCellFrame *)depreciateNewsCellFrame {
    _depreciateNewsCellFrame = depreciateNewsCellFrame;
    [self setupDepreciateNewsData];
}

/**
 *  设置DepreciateNews数据
 */
- (void)setupDepreciateNewsData {
    self.depreciateNewsView.depreciateNewsCellFrame = self.depreciateNewsCellFrame;
    self.depreciateNewsView.frame = self.depreciateNewsCellFrame.depreciateNewsViewFrame;
}

@end