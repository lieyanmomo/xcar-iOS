//
//  TSEChoicePostsView.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEChoicePostsView.h"

#import "TSEChoicePostCellFrame.h"
#import "TSEChoicePost.h"
#import <UIImageView+WebCache.h>

#import "Public.h"

@interface TSEChoicePostsView ()

/** 帖子图片 */
@property (nonatomic, weak) UIImageView *postImageView;

/** 帖子标题 */
@property (nonatomic, weak) UILabel *postTitleLabel;

/** 论坛名 */
@property (nonatomic, weak) UILabel *forumNameLabel;

/** 浏览人数 */
@property (nonatomic, weak) UIImageView *viewCountView;

/** 浏览人数 */
@property (nonatomic, weak) UILabel *viewCountLabel;

/** 分割线 */
@property (nonatomic, weak) UIView *separatorView;

@end

@implementation TSEChoicePostsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加精选帖子视图的各控件
        [self setupChoicePostView];
        // 设置背景颜色
        [self setBackgroundColor:TSEColor(251, 251, 251)];
    }
    return self;
}

/**
 *  添加精选帖子视图的各控件
 */
- (void)setupChoicePostView {
    /** 帖子图片 */
    UIImageView *postImageView = [[UIImageView alloc] init];
    [postImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:postImageView];
    self.postImageView = postImageView;
    
    /** 帖子标题 */
    UILabel *postTitleLabel = [[UILabel alloc] init];
    [postTitleLabel setTextColor:TSEColor(46, 49, 53)];
    [postTitleLabel setNumberOfLines:0];
    [postTitleLabel setFont:kChoicePostTitleFont];
    [self addSubview:postTitleLabel];
    self.postTitleLabel = postTitleLabel;
    
    /** 论坛名 */
    UILabel *forumNameLabel = [[UILabel alloc] init];
    [forumNameLabel setNumberOfLines:0];
    [forumNameLabel setTextColor:kSubtitleColor];
    [forumNameLabel setFont:kChoicePostForumFont];
    [self addSubview:forumNameLabel];
    self.forumNameLabel = forumNameLabel;
    
    /** 浏览人数 */
    UIImageView *viewCountView = [[UIImageView alloc] init];
    [viewCountView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:viewCountView];
    self.viewCountView = viewCountView;
    
    /** 浏览人数 */
    UILabel *viewCountLabel = [[UILabel alloc] init];
    [viewCountLabel setNumberOfLines:0];
    [viewCountLabel setTextColor:kSubtitleColor];
    [viewCountLabel setFont:kChoicePostViewCountFont];
    [self addSubview:viewCountLabel];
    self.viewCountLabel = viewCountLabel;
    
    /** 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    [separatorView setBackgroundColor:TSEColor(226, 226, 226)];
    [self addSubview:separatorView];
    self.separatorView = separatorView;
}

/**
 *  根据传入的homeViewNewsCellFrame对各控件进行赋值
 */
- (void)setChoicePostCellFrame:(TSEChoicePostCellFrame *)choicePostCellFrame {
    _choicePostCellFrame = choicePostCellFrame;
    TSEChoicePost *choicePost = choicePostCellFrame.choicePost;
    
    /** 帖子图片 */
    self.postImageView.frame = choicePostCellFrame.postImageViewFrame;
    NSURL *url = [NSURL URLWithString:choicePost.postImage];
    [self.postImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    
    /** 帖子标题 */
    self.postTitleLabel.frame = choicePostCellFrame.postTitleLabelFrame;
    [self.postTitleLabel setText:choicePost.postTitle];
    
    /** 论坛名 */
    self.forumNameLabel.frame = choicePostCellFrame.forumNameLabelFrame;
    [self.forumNameLabel setText:choicePost.forumName];
    
    /** 浏览人数 */
    self.viewCountView.frame = choicePostCellFrame.viewCountViewFrame;
    [self.viewCountView setImage:[UIImage imageNamed:@"dianji"]];
    
    /** 浏览人数 */
    self.viewCountLabel.frame = choicePostCellFrame.viewCountLabelFrame;
    [self.viewCountLabel setText:choicePost.viewCount];
    
    /** 分割线 */
    self.separatorView.frame = choicePostCellFrame.separatorViewFrame;
}
@end
