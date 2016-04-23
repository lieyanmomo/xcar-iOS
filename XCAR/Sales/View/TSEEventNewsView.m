//
//  TSEEventNewsView.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEEventNewsView.h"

#import "TSEEventNewsCellFrame.h"
#import "TSEEventNews.h"
#import "TSEShareEventSheet.h"

#import "UIImageView+WebCache.h"

#import "Public.h"

#define TSEEventNewsButtonImageRatio 0.3

@interface TSEEventNewsButton : UIButton
{
    CGFloat imageX;
    CGFloat imageY;
    CGFloat imageW;
    CGFloat imageH;
    
    CGFloat titleX;
    CGFloat titleY;
    CGFloat titleW;
    CGFloat titleH;
}

@end

@implementation TSEEventNewsButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.layer setBorderWidth:0.4];
        [self.layer setBorderColor:TSEColor(235, 235, 235).CGColor];
    }
    return self;
}

/**
 *  设置图片在button中的layout
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    imageX = contentRect.size.width / 7;
    imageY = contentRect.size.height / 3.5;
    imageW = 26;
    imageH = 18;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    titleX = imageX + imageW + 3;
    titleW = contentRect.size.width * (1 - TSEEventNewsButtonImageRatio);
    titleH = imageH;
    titleY = imageY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

@interface TSEEventNewsView () <UIActionSheetDelegate>
{
    NSInteger likeCount;
}

/** 活动大图 */
@property (nonatomic, weak) UIImageView *eventBigImgView;

/** 活动标题 */
@property (nonatomic, weak) UILabel *eventTitleLabel;

/** 活动截至时间 */
@property (nonatomic, weak) UILabel *eventEndTimeLabel;

/** 活动地点 */
@property (nonatomic, weak) UILabel *eventPlaceLabel;

/** 感兴趣人数 */
@property (nonatomic, weak) TSEEventNewsButton *eventInterestBtn;

/** 活动分享 */
@property (nonatomic, weak) TSEEventNewsButton *eventShareBtn;

/** 左上角标 */
@property (nonatomic, weak) UIImageView *topLeftBadgeView;

/** 右下角标 */
@property (nonatomic, weak) UIImageView *bottomRightBadgeView;

@end

@implementation TSEEventNewsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:YES];
        // 设置MarketNewsView
        [self setupEventNewsView];
    }
    return self;
}

// 设置EventNewsView
- (void)setupEventNewsView {
    /** 活动大图 */
    UIImageView *eventBigImgView = [[UIImageView alloc] init];
    [self addSubview:eventBigImgView];
    self.eventBigImgView = eventBigImgView;
    
    /** 活动标题 */
    UILabel *eventTitleLabel = [[UILabel alloc] init];
    [eventTitleLabel setFont:kEventNewsTitleFont];
    eventTitleLabel.numberOfLines = 0;
    [self addSubview:eventTitleLabel];
    self.eventTitleLabel = eventTitleLabel;
    
    /** 活动截至时间 */
    UILabel *eventEndTimeLabel = [[UILabel alloc] init];
    [eventEndTimeLabel setFont:[UIFont systemFontOfSize:15]];
    [eventEndTimeLabel setTextColor:TSEColor(136, 137, 145)];
    eventEndTimeLabel.numberOfLines = 0;
    [self addSubview:eventEndTimeLabel];
    self.eventEndTimeLabel = eventEndTimeLabel;
    
    /** 活动地点 */
    UILabel *eventPlaceLabel = [[UILabel alloc] init];
    [eventPlaceLabel setFont:[UIFont systemFontOfSize:15]];
    [eventPlaceLabel setTextColor:TSEColor(136, 137, 145)];
    eventPlaceLabel.numberOfLines = 0;
    [self addSubview:eventPlaceLabel];
    self.eventPlaceLabel = eventPlaceLabel;
    
    /** 感兴趣人数 */
    TSEEventNewsButton *eventInterestBtn = [[TSEEventNewsButton alloc] init];
    [eventInterestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eventInterestBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:eventInterestBtn];
    self.eventInterestBtn = eventInterestBtn;
    
    /** 活动分享 */
    TSEEventNewsButton *eventShareBtn = [[TSEEventNewsButton alloc] init];
    [eventShareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eventShareBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:eventShareBtn];
    self.eventShareBtn = eventShareBtn;
    
    /** 左上角标 */
    UIImageView *topLeftBadgeView = [[UIImageView alloc] init];
    [self addSubview:topLeftBadgeView];
    self.topLeftBadgeView = topLeftBadgeView;
    
    /** 右下角标 */
    UIImageView *bottomRightBadgeView = [[UIImageView alloc] init];
    [self addSubview:bottomRightBadgeView];
    self.bottomRightBadgeView = bottomRightBadgeView;
}

- (void)setEventNewsCellFrame:(TSEEventNewsCellFrame *)eventNewsCellFrame {
    _eventNewsCellFrame = eventNewsCellFrame;
    TSEEventNews *news = eventNewsCellFrame.eventNews;
    
    /** 活动大图 */
    self.eventBigImgView.frame = eventNewsCellFrame.eventBigImgViewFrame;
    NSURL *url = [NSURL URLWithString:news.eventBigImg];
    [self.eventBigImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    
    /** 活动标题 */
    self.eventTitleLabel.frame = eventNewsCellFrame.eventTitleLabelFrame;
    [self.eventTitleLabel setText:news.eventTitle];
    
    /** 活动截至时间 */
    self.eventEndTimeLabel.frame = eventNewsCellFrame.eventEndTimeLabelFrame;
    NSString *endTimeStr = [NSString stringWithFormat:@"活动截至时间：%@", news.eventEndTime];
    [self.eventEndTimeLabel setText:endTimeStr];
    
    /** 活动地点 */
    self.eventPlaceLabel.frame = eventNewsCellFrame.eventPlaceLabelFrame;
    NSString *placeStr = [NSString stringWithFormat:@"活动地点：%@", news.eventPlace];
    [self.eventPlaceLabel setText:placeStr];
    
    /** 感兴趣人数 */
    self.eventInterestBtn.frame = eventNewsCellFrame.eventInterestBtnFrame;
    [self.eventInterestBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.eventInterestBtn setImage:[UIImage imageNamed:@"zan_black"] forState:UIControlStateHighlighted];
    likeCount = news.eventInterest;
    NSString *interestStr = [NSString stringWithFormat:@"%ld人感兴趣", likeCount];
    [self.eventInterestBtn addTarget:self action:@selector(eventInterestBtnClicked:event:) forControlEvents:UIControlEventTouchDown];
    [self.eventInterestBtn setTitle:interestStr forState:UIControlStateNormal];
    
    /** 活动分享 */
    self.eventShareBtn.frame = eventNewsCellFrame.eventShareBtnFrame;
    [self.eventShareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [self.eventShareBtn setImage:[UIImage imageNamed:@"fenxiang_black"] forState:UIControlStateHighlighted];
    [self.eventShareBtn addTarget:self action:@selector(eventShareBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self.eventShareBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
    
    /** 左上角标 */
    self.topLeftBadgeView.frame = eventNewsCellFrame.topLeftBadgeViewFrame;
    [self.topLeftBadgeView setImage:[UIImage imageNamed:@"jinxing"]];
    
    /** 右下角标 */
    self.bottomRightBadgeView.frame = eventNewsCellFrame.bottomRightBadgeViewFrame;
    UILabel *lunTanLabel = [[UILabel alloc] init];
    [lunTanLabel setFrame:CGRectMake(2.0, 0.0, 50.0, 25.0)];
    [lunTanLabel setFont:[UIFont systemFontOfSize:12]];
    [lunTanLabel setText:@"论坛活动"];
    [lunTanLabel setTextColor:[UIColor whiteColor]];
    [self.bottomRightBadgeView addSubview:lunTanLabel];
    [self.bottomRightBadgeView setImage:[UIImage imageNamed:@"luntan"]];
}

/**
 *  点赞
 */
- (void)eventInterestBtnClicked:(TSEEventNewsButton *)sender event:(UIEvent *)event {
    UITouch* touch = [[event allTouches] anyObject];
    if (touch.tapCount == 1) {
        likeCount++;
        [self.eventInterestBtn setTitle:[NSString stringWithFormat:@"%ld人感兴趣", likeCount] forState:UIControlStateNormal];
        
        // 只给点赞，不给取消，坑爹呢
        sender.enabled = NO;
    } else {
        return;
    }
}

/**
 *  分享
 */
- (void)eventShareBtnClicked {
    TSEShareEventSheet *sheetView = [[TSEShareEventSheet alloc] init];
    [sheetView showInView:nil];
}

@end
