//
//  TSEHotPostCell.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPostCell.h"

#import "TSEHotPostCellFrame.h"
#import "TSEHotPostsView.h"

#import "Public.h"

@interface TSEHotPostCell ()

/** 父视图 */
@property (nonatomic, weak) TSEHotPostsView *hotPostView;

@end

@implementation TSEHotPostCell

static NSString * const kCellIdentifier = @"HOTPOST";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEHotPostCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEHotPostCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置背景颜色
        [self setBackgroundColor:TSEColor(251, 251, 251)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置热门帖子视图的frame
        [self setupHotPostsView];
    }
    return self;
}

/**
 *  设置热门帖子视图的frame
 */
- (void)setupHotPostsView {
    /** 父视图 */
    TSEHotPostsView *hotPostView = [[TSEHotPostsView alloc] init];
    [self.contentView addSubview:hotPostView];
    self.hotPostView = hotPostView;
}

/**
 *  override setter
 */
- (void)setHotPostCellFrame:(TSEHotPostCellFrame *)hotPostCellFrame {
    _hotPostCellFrame = hotPostCellFrame;
    // 设置热门帖子数据
    [self setupHotPostData];
}

/**
 *  设置热门帖子数据
 */
- (void)setupHotPostData {
    self.hotPostView.hotPostCellFrame = self.hotPostCellFrame;
    self.hotPostView.frame = self.hotPostCellFrame.hotPostViewFrame;
}

/**
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kHotPostTableViewMargin;
    frame.origin.y += kHotPostTableViewMargin;
    frame.size.width -= kHotPostTableViewMargin;
    frame.size.height -= kHotPostTableViewMargin;
    [super setFrame:frame];
}

@end
