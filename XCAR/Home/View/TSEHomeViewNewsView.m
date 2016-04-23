//
//  TSEHomeViewNewsView.m
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEHomeViewNewsView.h"
#import "TSEHomeViewNewsCellFrame.h"
#import "TSEHomeViewNews.h"
#import <UIImageView+WebCache.h>

#import "Public.h"

@interface TSEHomeViewNewsView ()

/** 新闻类别 */
@property (nonatomic, weak) UILabel *categoryLabel;

/** 新闻评论 */
@property (nonatomic, weak) UILabel *commentLabel;

/** 新闻评论(image) */
@property (nonatomic, weak) UIImageView *commentView;

/** 新闻图片 */
@property (nonatomic, weak) UIImageView *newsImageView;

/** 新闻标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** 新闻发布时间 */
@property (nonatomic, weak) UILabel *pubTimeLabel;

/** 分割线 */
@property (nonatomic, weak) UIView *separatorView;


@end

@implementation TSEHomeViewNewsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加主页新闻的各控件
        [self setupHomeViewNewsView];
        // 设置背景颜色
        [self setBackgroundColor:TSEColor(251, 251, 251)];
    }
    return self;
}

/**
 *  添加主页新闻的各控件
 */
- (void)setupHomeViewNewsView {
    /** 新闻标题 */
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:kHomeViewNewsTitleFont];
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** 新闻图片 */
    UIImageView *newsImageView = [[UIImageView alloc] init];
    newsImageView.layer.masksToBounds = YES;
    [newsImageView.layer setCornerRadius:5.0];
    newsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:newsImageView];
    self.newsImageView = newsImageView;
    
    /** 新闻类别 */
    UILabel *categoryLabel = [[UILabel alloc] init];
    [categoryLabel setFont:kHomeViewNewsCategoryFont];
    categoryLabel.textColor = kSubtitleColor;
    [self addSubview:categoryLabel];
    self.categoryLabel = categoryLabel;
    
    /** 新闻评论(image) */
    UIImageView *commentView = [[UIImageView alloc] init];
    [self addSubview:commentView];
//    [commentView setBackgroundColor:[UIColor orangeColor]];
    self.commentView = commentView;
    
    /** 新闻评论 */
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.textColor = kSubtitleColor;
    [commentLabel setFont:kHomeViewNewsCommentFont];
//    [commentLabel setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    /** 新闻发布时间 */
    UILabel *pubTimeLabel = [[UILabel alloc] init];
    pubTimeLabel.textColor = kSubtitleColor;
    [pubTimeLabel setFont:kHomeViewNewsCommentFont];
    [self addSubview:pubTimeLabel];
    self.pubTimeLabel = pubTimeLabel;
    
    /** 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    [separatorView setBackgroundColor:TSEColor(226, 226, 226)];
    [self addSubview:separatorView];
    self.separatorView = separatorView;
}

/**
 *  根据传入的homeViewNewsCellFrame对各控件进行赋值
 */
- (void)setHomeViewNewsCellFrame:(TSEHomeViewNewsCellFrame *)homeViewNewsCellFrame {
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    TSEHomeViewNews *news = homeViewNewsCellFrame.homeViewNews;
    
    /** 新闻标题 */
    self.titleLabel.frame = homeViewNewsCellFrame.titleFrame;
    [self.titleLabel setText:news.newsTitle];
    
    /** 新闻图片 */
    self.newsImageView.frame = homeViewNewsCellFrame.newsImageFrame;
    NSURL *newsImageURL = [NSURL URLWithString:news.newsImage];
    [self.newsImageView sd_setImageWithURL:newsImageURL placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    
    /** 新闻类别 */
    if (news.newsCategory) {
        self.categoryLabel.frame = homeViewNewsCellFrame.categotyFrame;
        [self.categoryLabel setText:news.newsCategory];
    }
    
    /** 新闻评论(image) */
    if (news.commentCount) {
        self.commentView.frame = homeViewNewsCellFrame.commentViewFrame;
        [self.commentView setImage:[UIImage imageNamed:@"6.0baitian_pinglun_old"]];
    }
    
    /** 新闻评论 */
    if (news.commentCount) {
        self.commentLabel.frame = homeViewNewsCellFrame.commentFrame;
        NSString *comment = [NSString stringWithFormat:@"%ld", news.commentCount];
        [self.commentLabel setText:comment];
    }
    
    /** 新闻发布时间 */
    if (news.pubTime) {
        
        // 20150924
        NSString *pubTimeStr = [NSString stringWithFormat:@"%ld", news.pubTime];
        NSInteger yLocation = 0;
        NSInteger yLength = 4;
        NSString *year = [pubTimeStr substringWithRange:NSMakeRange(yLocation, yLength)];
        
        NSInteger mLocation = 4;
        NSInteger mLength = 2;
        NSString *month = [pubTimeStr substringWithRange:NSMakeRange(mLocation, mLength)];
        
        NSInteger dLocation = 6;
        NSInteger dLength = 2;
        NSString *day = [pubTimeStr substringWithRange:NSMakeRange(dLocation, dLength)];
        
        self.pubTimeLabel.frame = homeViewNewsCellFrame.pubTimeLabelFrame;
        NSString *pubTime = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
        [self.pubTimeLabel setText:pubTime];
    }
    
    /** 分割线 */
    self.separatorView.frame = homeViewNewsCellFrame.separatorViewFrame;
}

@end

