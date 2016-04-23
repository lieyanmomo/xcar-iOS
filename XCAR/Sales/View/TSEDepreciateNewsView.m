//
//  TSEDepreciateNewsView.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateNewsView.h"

#import "TSEDepreciateNews.h"
#import "TSEDepreciateNewsCellFrame.h"
#import "UIImageView+WebCache.h"

#import "Public.h"

@interface TSEDepreciateNewsView ()

/** 降价汽车图片 */
@property (nonatomic, weak) UIImageView *imageURLView;

/** 降价汽车名称 */
@property (nonatomic, weak) UILabel *carNameLabel;

/** 降价幅度 */
@property (nonatomic, weak) UILabel *discountLabel;

/** 现价 */
@property (nonatomic, weak) UILabel *currentPriceLabel;

/** 有无现车 */
@property (nonatomic, weak) UILabel *tagLabel;

/** 购车计算 */
@property (nonatomic, weak) UIButton *buyCarBtn;

/** 拨打电话 */
@property (nonatomic, weak) UIButton *telBtn;

/** 问最低价 */
@property (nonatomic, weak) UIButton *lowestPriceBtn;

@end

@implementation TSEDepreciateNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:YES];
        // 设置DepreciateNewsView
        [self setupDepreciateNewsView];
    }
    
    return self;
}

- (void)setupDepreciateNewsView {
    /** 降价汽车图片 */
    UIImageView *imageURLView = [[UIImageView alloc] init];
    [imageURLView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:imageURLView];
    self.imageURLView = imageURLView;
    
    /** 降价汽车名称 */
   UILabel *carNameLabel = [[UILabel alloc] init];
    [carNameLabel setFont:kDepreciateNewsTitleFont];
    [carNameLabel setNumberOfLines:0];
    [carNameLabel setTextColor:TSEColor(44, 47, 52)];
    [self addSubview:carNameLabel];
    self.carNameLabel = carNameLabel;
    
    /** 降价幅度 */
    UILabel *discountLabel = [[UILabel alloc] init];
    [discountLabel setFont:kDepreciateNewsSubTitleFont];
    [discountLabel setTextColor:TSEColor(236, 114, 51)];
    [self addSubview:discountLabel];
    self.discountLabel = discountLabel;
    
    /** 现价 */
    UILabel *currentPriceLabel = [[UILabel alloc] init];
    [currentPriceLabel setFont:kDepreciateNewsSubTitleFont];
    [currentPriceLabel setTextColor:TSEColor(138, 142, 145)];
    [self addSubview:currentPriceLabel];
    self.currentPriceLabel = currentPriceLabel;
    
    /** 有无现车 */
    UILabel *tagLabel = [[UILabel alloc] init];
    [tagLabel setFont:kDepreciateNewsSubTitleFont];
    [tagLabel setTextColor:TSEColor(138, 142, 145)];
    [self addSubview:tagLabel];
    self.tagLabel = tagLabel;
    
    /** 购车计算 */
    UIButton *buyCarBtn = [[UIButton alloc] init];
    [buyCarBtn setTitle:@"购车计算" forState:UIControlStateNormal];
    [buyCarBtn setTitleColor:TSEColor(40, 177, 219) forState:UIControlStateNormal];
    [buyCarBtn.titleLabel setFont:kDepreciateNewsTitleFont];
    [buyCarBtn.layer setBorderColor:TSEColor(40, 177, 219).CGColor];
    [buyCarBtn.layer setBorderWidth:0.4];
    [buyCarBtn.layer setCornerRadius:5.0];
    [buyCarBtn addTarget:self action:@selector(buyCarBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self addSubview:buyCarBtn];
    self.buyCarBtn = buyCarBtn;
    
    /** 拨打电话 */
    UIButton *telBtn = [[UIButton alloc] init];
    [telBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [telBtn setTitleColor:TSEColor(40, 177, 219) forState:UIControlStateNormal];
    [telBtn.titleLabel setFont:kDepreciateNewsTitleFont];
    [telBtn.layer setBorderColor:TSEColor(40, 177, 219).CGColor];
    [telBtn.layer setBorderWidth:0.4];
    [telBtn.layer setCornerRadius:5.0];
    [telBtn addTarget:self action:@selector(telBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self addSubview:telBtn];
    self.telBtn = telBtn;
    
    /** 问最低价 */
    UIButton *lowestPriceBtn = [[UIButton alloc] init];
    [lowestPriceBtn setTitle:@"问最低价" forState:UIControlStateNormal];
    [lowestPriceBtn setBackgroundColor:TSEColor(40, 177, 219)];
    [lowestPriceBtn.titleLabel setFont:kDepreciateNewsTitleFont];
    [lowestPriceBtn.layer setBorderColor:TSEColor(40, 177, 219).CGColor];
    [lowestPriceBtn.layer setBorderWidth:0.4];
    [lowestPriceBtn.layer setCornerRadius:5.0];
    [lowestPriceBtn addTarget:self action:@selector(lowestPriceBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self addSubview:lowestPriceBtn];
    self.lowestPriceBtn = lowestPriceBtn;
}

- (void)setDepreciateNewsCellFrame:(TSEDepreciateNewsCellFrame *)depreciateNewsCellFrame {
    _depreciateNewsCellFrame = depreciateNewsCellFrame;
    TSEDepreciateNews *news = depreciateNewsCellFrame.depreciateNews;
    
    /** 降价汽车图片 */
    self.imageURLView.frame = depreciateNewsCellFrame.imageURLViewFrame;
    NSURL *url = [NSURL URLWithString:news.imageUrl];
    [self.imageURLView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
    
    /** 降价汽车名称 */
    self.carNameLabel.frame = depreciateNewsCellFrame.carNameLabelFrame;
    [self.carNameLabel setText:news.carName];
    
    /** 降价幅度 */
    self.discountLabel.frame = depreciateNewsCellFrame.discountLabelFrame;
    [self.discountLabel setText:news.discount];
    
    /** 现价 */
    self.currentPriceLabel.frame = depreciateNewsCellFrame.currentPriceLabelFrame;
    [self.currentPriceLabel setText:news.currentPrice];
    
    /** 有无现车 */
    self.tagLabel.frame = depreciateNewsCellFrame.tagLabelFrame;
    [self.tagLabel setText:news.tag];
    
    /** 购车计算 */
    self.buyCarBtn.frame = depreciateNewsCellFrame.buyCarBtnFrame;
    
    /** 拨打电话 */
    self.telBtn.frame = depreciateNewsCellFrame.telBtnFrame;
    
    /** 问最低价 */
    self.lowestPriceBtn.frame = depreciateNewsCellFrame.lowestPriceBtnFrame;
}

#pragma mark - button method 
- (void)buyCarBtnClicked {
    TSELog(@"buyCarBtnClicked");
}

- (void)telBtnClicked {
    TSELog(@"telBtnClicked");
}

- (void)lowestPriceBtnClicked {
    TSELog(@"lowestPriceBtnClicked");
}


@end
