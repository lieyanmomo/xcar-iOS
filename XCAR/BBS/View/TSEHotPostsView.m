//
//  TSEHotPostsView.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPostsView.h"

#import "TSEHotPost.h"
#import "TSEHotPostCellFrame.h"
#import <UIImageView+WebCache.h>

#import "Public.h"

@interface TSEHotPostsView ()

/** 帖子标题 */
@property (nonatomic, weak) UILabel *postTitleLabel;

/** 论坛名 */
@property (nonatomic, weak) UILabel *forumNameLabel;

/** 浏览人数 */
@property (nonatomic, weak) UIImageView *viewCountView;

/** 浏览人数 */
@property (nonatomic, weak) UILabel *viewCountLabel;

/** 创建时间 */
@property (nonatomic, weak) UILabel *createDateLabel;

/** 最新回复时间 */
@property (nonatomic, weak) UILabel *replyDateLabel;

/** 有无图片 */
@property (nonatomic, weak) UIImageView *hasImageView;

/** 分割线 */
@property (nonatomic, weak) UIView *separatorView;

@end

@implementation TSEHotPostsView

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
    /** 帖子标题 */
    UILabel *postTitleLabel = [[UILabel alloc] init];
    [postTitleLabel setTextColor:TSEColor(46, 49, 53)];
    [postTitleLabel setNumberOfLines:0];
    [postTitleLabel setFont:kHotPostTitleFont];
    [self addSubview:postTitleLabel];
    self.postTitleLabel = postTitleLabel;
    
    /** 论坛名 */
    UILabel *forumNameLabel = [[UILabel alloc] init];
    [forumNameLabel setNumberOfLines:0];
    [forumNameLabel setTextColor:kSubtitleColor];
    [forumNameLabel setFont:kHotPostForumFont];
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
    [viewCountLabel setFont:kHotPostViewCountFont];
    [self addSubview:viewCountLabel];
    self.viewCountLabel = viewCountLabel;
    
    /** 创建时间 */
    UILabel *createDateLabel = [[UILabel alloc] init];
    [createDateLabel setNumberOfLines:0];
    [createDateLabel setTextColor:kSubtitleColor];
    [createDateLabel setFont:kHotPostCreateDateFont];
    [self addSubview:createDateLabel];
    self.createDateLabel = createDateLabel;
    
    /** 最新回复时间 */
    UILabel *replyDateLabel = [[UILabel alloc] init];
    [replyDateLabel setNumberOfLines:0];
    [replyDateLabel setTextColor:kSubtitleColor];
    [replyDateLabel setFont:kHotPostCreateDateFont];
    [self addSubview:replyDateLabel];
    self.replyDateLabel = replyDateLabel;
    
    /** 有无图片 */
    UIImageView *hasImageView = [[UIImageView alloc] init];
    [hasImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:hasImageView];
    self.hasImageView = hasImageView;
    
    /** 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    [separatorView setBackgroundColor:TSEColor(226, 226, 226)];
    [self addSubview:separatorView];
    self.separatorView = separatorView;
}

/**
 *  根据传入的homeViewNewsCellFrame对各控件进行赋值
 */
- (void)setHotPostCellFrame:(TSEHotPostCellFrame *)hotPostCellFrame {
    _hotPostCellFrame = hotPostCellFrame;
    TSEHotPost *hotPost = hotPostCellFrame.hotPost;
    
    /** 帖子标题 */
    self.postTitleLabel.frame = hotPostCellFrame.postTitleLabelFrame;
    [self.postTitleLabel setText:hotPost.postTitle];
    
    /** 论坛名 */
    self.forumNameLabel.frame = hotPostCellFrame.forumNameLabelFrame;
    [self.forumNameLabel setText:hotPost.forumName];
    
    /** 浏览人数 */
    self.viewCountView.frame = hotPostCellFrame.viewCountViewFrame;
    [self.viewCountView setImage:[UIImage imageNamed:@"dianji"]];
    
    /** 浏览人数 */
    self.viewCountLabel.frame = hotPostCellFrame.viewCountLabelFrame;
    [self.viewCountLabel setText:hotPost.viewCount];
    
    /** 创建时间 */
    self.createDateLabel.frame = hotPostCellFrame.createDateLabelFrame;
    [self.createDateLabel setText:hotPost.createDate];
    
     /** 最新回复时间 */
    self.replyDateLabel.frame = hotPostCellFrame.replyDateLabelFrame;
    [self.replyDateLabel setText:hotPost.replyDate];
    
    /** 有无图片 */
    self.hasImageView.frame = hotPostCellFrame.hasImageViewFrame;
    [self.hasImageView setImage:[UIImage imageNamed:@"xiaotupan"]];
    
    /** 分割线 */
    self.separatorView.frame = hotPostCellFrame.separatorViewFrame;
}

@end
