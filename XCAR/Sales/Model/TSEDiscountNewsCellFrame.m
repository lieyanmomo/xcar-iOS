//
//  TSEDiscountNewsCellFrame.m
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEDiscountNewsCellFrame.h"
#import "TSEDiscountNews.h"
#import "Public.h"

@implementation TSEDiscountNewsCellFrame

- (void)setDiscountNews:(TSEDiscountNews *)discountNews {
    
    _discountNews = discountNews;
    
    /** 父视图 */
    CGFloat discountNewsViewX = kDiscountNewsCellMargin;
    CGFloat discountNewsViewY = kDiscountNewsCellMargin;
    CGFloat discountNewsViewW = ScreenWidth - 2 * kDiscountNewsCellMargin;
    CGFloat discountNewsViewH;
    
    /** 促销活动图片 */
    CGFloat salePicImgViewX = kDiscountNewsViewMargin;
    CGFloat salePicImgViewY = kDiscountNewsViewMargin;
    CGFloat salePicImgViewW = discountNewsViewW - 2 * kDiscountNewsViewMargin;
    CGFloat salePicImgViewH = 200.0f;
    _salePicImgViewFrame = CGRectMake(salePicImgViewX, salePicImgViewY, salePicImgViewW, salePicImgViewH);
    
    /** 促销活动标题 */
    CGFloat saleTitleLabelX = salePicImgViewX;
    CGFloat saleTitleLabelY = CGRectGetMaxY(_salePicImgViewFrame) + kDiscountNewsViewMargin;
    CGFloat saleTitleLabelW = salePicImgViewW;
    CGFloat saleTitleLabelH = 30;
    _saleTitleLabelFrame = CGRectMake(saleTitleLabelX, saleTitleLabelY, saleTitleLabelW, saleTitleLabelH);
    
    /** 副标题 */
    CGFloat subSeriesLabelX = saleTitleLabelX;
    CGFloat subSeriesLabelY = CGRectGetMaxY(_saleTitleLabelFrame) + kDiscountNewsViewMargin;
    CGFloat subSeriesLabelW = saleTitleLabelW;
    NSArray *subSeries = discountNews.subSeries;
    
    // 获取完整的字符串
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
    
    NSDictionary *subSeriesTitleAttrs = @{NSFontAttributeName : kDiscountSubSeriesTitleFont};
    CGSize subSeriesTitleSize = [subSerieSTR sizeWithAttributes:subSeriesTitleAttrs];
    CGFloat subSeriesLabelH = subSeriesTitleSize.height;
    _subSeriesLabelFrame = CGRectMake(subSeriesLabelX, subSeriesLabelY, subSeriesLabelW, subSeriesLabelH);
    
    /** 报名人数 */
    CGFloat numberLabelX = discountNewsViewW / 1.4;
    CGFloat numberLabelY = CGRectGetMaxY(_subSeriesLabelFrame) + 2 * kDiscountNewsViewMargin;
    CGFloat numberLabelW = 80;
    CGFloat numberLabelH = 30;
    _numberLabelFrame = CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    /** 活动详情 */
    CGFloat detailLabelX = 0.0f;
    CGFloat detailLabelY = CGRectGetMaxY(_numberLabelFrame) + 2 * kDiscountNewsViewMargin;
    CGFloat detailLabelW = discountNewsViewW;
    CGFloat detailLabelH = 44.0f;;
    _detailLabelFrame = CGRectMake(detailLabelX, detailLabelY, detailLabelW, detailLabelH);
    
    /** 父视图高度 */
    discountNewsViewH = CGRectGetMaxY(_detailLabelFrame);
    _discountNewsViewFrame = CGRectMake(discountNewsViewX, discountNewsViewY, discountNewsViewW, discountNewsViewH);
    
    /** cell的高度 */
    _cellHeight = CGRectGetMaxY(_discountNewsViewFrame) + kDiscountNewsCellMargin;
}

@end
