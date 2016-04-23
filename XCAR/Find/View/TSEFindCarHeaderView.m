//
//  TSEFindCarHeaderView.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEFindCarHeaderView.h"
#import <UIImageView+WebCache.h>
#import "Public.h"

#define kFindCarHeaderViewMargin 10
#define kFindCarHeaderViewGap 6
#define kFindCarheaderViewTitleFont [UIFont systemFontOfSize:16.0]

@interface TSEFindCarHeaderButton : UIButton

@end

@implementation TSEFindCarHeaderButton

/**
 *  设置图片在button中的layout
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 25.0;
    CGFloat imageH = 20.0;
    CGFloat imageY = contentRect.size.height / 2 - imageH / 2;
    CGFloat imageW = 16.0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end

@interface TSEFindCarHeaderView ()
{
    /** 车图片 */
    UIImageView *_seriesImageView;
    
    /** 角标 */
    UIImageView *_badgeImageView;
    
    /** 车名字 */
    UILabel *_carNameLabel;
    
    /** 降价幅度 */
   UILabel *_cheapRangeLabel;
    
    /** 销售商 */
    UILabel *_dealerNameLabel;
    
    /** 问最低价 */
    TSEFindCarHeaderButton *_lowestPriceBtn;
    
    /** 拨打电话 */
    TSEFindCarHeaderButton *_dealerTelBtn;
}

@end

@implementation TSEFindCarHeaderView

- (instancetype)initHeaderViewWithSeriesImage:(NSString *)seriesImage carName:(NSString *)carName cheapRange:(NSString *)cheapRange dealerName:(NSString *)dealerName {
    
    self = [super init];
    
    if (self) {
        
        [self setBackgroundColor:TSEColor(248, 248, 248)];
        
        // main view
        UIView *mainView = [[UIView alloc] init];
        [mainView setBackgroundColor:[UIColor whiteColor]];
        
         /** 车图片 */
        _seriesImageView = [[UIImageView alloc] init];
        [_seriesImageView setFrame:CGRectMake(kFindCarHeaderViewMargin, kFindCarHeaderViewMargin, 120.0, 90.0)];
        NSURL *url = [NSURL URLWithString:seriesImage];
        [_seriesImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
        [mainView addSubview:_seriesImageView];
        
        /** 角标 */
        _badgeImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"jrth"];
        [_badgeImageView setImage:image];
        [_badgeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_badgeImageView setFrame:CGRectMake(0.0, 0.0, 95, 46)];
        [mainView addSubview:_badgeImageView];
        
        /** 车名字 */
        _carNameLabel = [[UILabel alloc] init];
        [_carNameLabel setText:carName];
        CGFloat carNameX = CGRectGetMaxX(_seriesImageView.frame) + 5.0;
        CGFloat carNameY = _seriesImageView.frame.origin.y;
        CGFloat carNameW = ScreenWidth - 2 * kFindCarHeaderViewMargin - _seriesImageView.frame.size.width;
        NSDictionary *attrs = @{NSFontAttributeName : kFindCarheaderViewTitleFont};
        CGSize size = [_carNameLabel.text sizeWithAttributes:attrs];
        NSInteger row = ceil(size.width / carNameW + 0.5);
        CGFloat carNameH = size.height * row;
        [_carNameLabel setFrame:CGRectMake(carNameX, carNameY, carNameW, carNameH)];
        [mainView addSubview:_carNameLabel];
        
        /** 降价幅度 */
        _cheapRangeLabel = [[UILabel alloc] init];
        [_cheapRangeLabel setText:cheapRange];
        [_cheapRangeLabel setTextColor:TSEColor(241, 79, 86)];
        [_cheapRangeLabel setFont:[UIFont systemFontOfSize:18.0]];
        CGFloat cheapRangeX = carNameX;
        CGFloat cheapRangeY = CGRectGetMaxY(_carNameLabel.frame) + kFindCarHeaderViewMargin;
        CGFloat cheapRangeW = 100.0;
        CGFloat cheapRangeH = 16.0;
        [_cheapRangeLabel setFrame:CGRectMake(cheapRangeX, cheapRangeY, cheapRangeW, cheapRangeH)];
        [mainView addSubview:_cheapRangeLabel];
        
        /** 销售商 */
        _dealerNameLabel = [[UILabel alloc] init];
        [_dealerNameLabel setText:dealerName];
        [_dealerNameLabel setTextColor:TSEColor(135, 136, 145)];
        [_dealerNameLabel setFont:[UIFont systemFontOfSize:14.0]];
        CGFloat dealerNameX = cheapRangeX;
        CGFloat dealerNameY = CGRectGetMaxY(_cheapRangeLabel.frame) + kFindCarHeaderViewMargin;
        CGFloat dealerNameW = ScreenWidth - _seriesImageView.frame.size.width - kFindCarHeaderViewMargin;
        CGFloat dealerNameH = 16.0;
        [_dealerNameLabel setFrame:CGRectMake(dealerNameX, dealerNameY, dealerNameW, dealerNameH)];
        [mainView addSubview:_dealerNameLabel];
        
        /** 问最低价 */
        _lowestPriceBtn = [[TSEFindCarHeaderButton alloc] init];
        [_lowestPriceBtn setBackgroundColor:TSEColor(40, 177, 229)];
        [_lowestPriceBtn.layer setCornerRadius:5.0];
        [_lowestPriceBtn setTitle:@"问最低价" forState:UIControlStateNormal];
        [_lowestPriceBtn setImage:[UIImage imageNamed:@"zuidijia_white"] forState:UIControlStateNormal];
        CGFloat lowestPriceX = _seriesImageView.frame.origin.x;
        CGFloat lowestPriceY = CGRectGetMaxY(_dealerNameLabel.frame) + 2.5 * kFindCarHeaderViewGap;
        CGFloat lowestPriceW = (ScreenWidth - 3 * kFindCarHeaderViewMargin) / 2;
        CGFloat lowestPriceH = 40.0;
        [_lowestPriceBtn setFrame:CGRectMake(lowestPriceX, lowestPriceY, lowestPriceW, lowestPriceH)];
        [mainView addSubview:_lowestPriceBtn];
        
        /** 拨打电话 */
        _dealerTelBtn = [[TSEFindCarHeaderButton alloc] init];
        [_dealerTelBtn setBackgroundColor:TSEColor(40, 177, 229)];
        [_dealerTelBtn.layer setCornerRadius:5.0];
        [_dealerTelBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [_dealerTelBtn setImage:[UIImage imageNamed:@"tel_white"] forState:UIControlStateNormal];
        CGFloat dealerTelX = CGRectGetMaxX(_lowestPriceBtn.frame) + kFindCarHeaderViewMargin;
        CGFloat dealerTelY = lowestPriceY;
        CGFloat dealerTelW = lowestPriceW;
        CGFloat dealerTelH = lowestPriceH;
        [_dealerTelBtn setFrame:CGRectMake(dealerTelX, dealerTelY, dealerTelW, dealerTelH)];
        [mainView addSubview:_dealerTelBtn];
        
        _cellHeight = CGRectGetMaxY(_dealerTelBtn.frame) + kFindCarHeaderViewGap;
        
        [mainView setFrame:CGRectMake(0.0, 15.0, ScreenWidth, _cellHeight)];
        [self addSubview:mainView];
    }
    return self;
}

@end
