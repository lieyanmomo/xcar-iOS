//
//  TSEDiscountNewsView.m
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEDiscountNewsView.h"
#import "UIImageView+WebCache.h"
#import "TSEDiscountNewsCellFrame.h"
#import "TSEDiscountNews.h"
#import "Public.h"

@interface TSEDiscountNewsView ()

/** 促销活动图片 */
@property (nonatomic, weak) UIImageView *salePicImgView;

/** 促销活动标题 */
@property (nonatomic, weak) UILabel *saleTitleLabel;

/** 副标题 */
@property (nonatomic, weak) UILabel *subSeriesLabel;

/** 报名人数 */
@property (nonatomic, weak) UILabel *numberLabel;

/** 活动详情 */
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation TSEDiscountNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:TSEColor(248, 248, 248)];
        [self setUserInteractionEnabled:YES];
    
        // 设置DiscountNewsView
        [self setupDiscountNewsView];
    }
    
    return self;
}

/**
 *  设置DiscountNewsView
 */
- (void)setupDiscountNewsView {
    /** 促销活动图片 */
    UIImageView *salePicImgView = [[UIImageView alloc] init];
    [salePicImgView setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:salePicImgView];
    self.salePicImgView = salePicImgView;
    
    /** 促销活动标题 */
    UILabel *saleTitleLabel = [[UILabel alloc] init];
    [saleTitleLabel setFont:kDiscountTitleFont];
    [self addSubview:saleTitleLabel];
    self.saleTitleLabel = saleTitleLabel;
    
    /** 副标题 */
    UILabel *subSeriesLabel = [[UILabel alloc] init];
    [subSeriesLabel setFont:kDiscountSubSeriesTitleFont];
    [subSeriesLabel setTextColor:TSEColor(140, 140, 151)];
    subSeriesLabel.numberOfLines = 0;
    [self addSubview:subSeriesLabel];
    self.subSeriesLabel = subSeriesLabel;
    
    /** 报名人数 */
    UILabel *numberLabel = [[UILabel alloc] init];
    [numberLabel setTextAlignment:NSTextAlignmentRight];
    [numberLabel setFont:kDiscountTitleFont];
    [self addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    /** 活动详情 */
    UILabel *detailLabel = [[UILabel alloc] init];
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    [detailLabel setFont:kDiscountTitleFont];
    [detailLabel setText:@"查看详情"];
    [detailLabel setTextColor:TSEColor(69, 171, 207)];
    [detailLabel.layer  setBorderWidth:0.4];
    [detailLabel.layer setBorderColor:TSEColor(222, 222, 222).CGColor];
    [self addSubview:detailLabel];
    self.detailLabel = detailLabel;
}

- (void)setDiscountNewsCellFrame:(TSEDiscountNewsCellFrame *)discountNewsCellFrame {
    _discountNewsCellFrame = discountNewsCellFrame;
    TSEDiscountNews *news = discountNewsCellFrame.discountNews;
    
    /** 促销活动图片 */
    [self.salePicImgView setFrame:discountNewsCellFrame.salePicImgViewFrame];
    NSURL *imageURl = [NSURL URLWithString:news.salePic];
    [self.salePicImgView sd_setImageWithURL:imageURl placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    
    /** 促销活动标题 */
    [self.saleTitleLabel setFrame:discountNewsCellFrame.saleTitleLabelFrame];
    [self.saleTitleLabel setText:news.saleTitle];
    
    /** 副标题 */
    [self.subSeriesLabel setFrame:discountNewsCellFrame.subSeriesLabelFrame];
    NSArray *subSeries = news.subSeries;
    NSMutableArray *tmpARR = [NSMutableArray array];
    NSString *subSerieSTR = @"";
    for (NSDictionary *dict in subSeries) {
        NSString *tmpSTR = dict[@"serName"];
        [tmpARR addObject:tmpSTR];
    }
    
    for (int i = 0; i < [tmpARR count]; i++) {
        NSString *tmpSTR = tmpARR[i];
        subSerieSTR = [subSerieSTR stringByAppendingFormat:@"%@/", tmpSTR];
    }
    [self.subSeriesLabel setText:subSerieSTR];
    
    /** 报名人数 */
    [self.numberLabel setFrame:discountNewsCellFrame.numberLabelFrame];
    [self.numberLabel setText:[NSString stringWithFormat:@"%@人报名", news.number]];
    
    /** 活动详情 */
    [self.detailLabel setFrame:discountNewsCellFrame.detailLabelFrame];
}

@end
