//
//  TSEChoicePostsCell.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEChoicePostsCell.h"

#import "TSEChoicePostsView.h"
#import "TSEChoicePostCellFrame.h"

#import "UIImageView+WebCache.h"

@interface TSEChoicePostsCell ()

/** 父视图 */
@property (nonatomic, weak) TSEChoicePostsView *choicePostView;

@end

@implementation TSEChoicePostsCell

static NSString * const kCellIdentifier = @"CHOICEPOST";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.从重用对象池中找不用的cell对象
    TSEChoicePostsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    // 2.如果没有找到就自己创建对象
    if (cell == nil) {
        cell = [[TSEChoicePostsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        // 设置精选帖子视图的frame
        [self setupChoicePostsView];
    }
    return self;
}

/**
 *  设置精选帖子视图的frame
 */
- (void)setupChoicePostsView {
    /** 父视图 */
    TSEChoicePostsView *choicePostView = [[TSEChoicePostsView alloc] init];
    [self.contentView addSubview:choicePostView];
    self.choicePostView = choicePostView;
}

/**
 *  override setter
 */
- (void)setChoicePostCellFrame:(TSEChoicePostCellFrame *)choicePostCellFrame {
    _choicePostCellFrame = choicePostCellFrame;
    // 设置精选帖子数据
    [self setupChoicePostData];
}

/**
 *  设置精选帖子数据
 */
- (void)setupChoicePostData {
    self.choicePostView.choicePostCellFrame = self.choicePostCellFrame;
    self.choicePostView.frame = self.choicePostCellFrame.choicePostViewFrame;
}

/**
 *  在系统初始化cell的frame之前拦截设置cell的frame
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kChoicePostTableViewMargin;
    frame.origin.y += kChoicePostTableViewMargin;
    frame.size.width -= kChoicePostTableViewMargin;
    frame.size.height -= kChoicePostTableViewMargin;
    [super setFrame:frame];
}

@end
