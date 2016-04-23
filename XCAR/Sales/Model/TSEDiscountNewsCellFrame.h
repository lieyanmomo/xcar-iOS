//
//  TSEDiscountNewsCellFrame.h
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kDiscountNewsCellMargin 6
#define kDiscountTitleFont [UIFont systemFontOfSize:16]
#define kDiscountSubSeriesTitleFont [UIFont systemFontOfSize:15]
#define kDiscountNewsViewMargin 5

@class TSEDiscountNews;
@interface TSEDiscountNewsCellFrame : NSObject

@property (nonatomic, strong) TSEDiscountNews *discountNews;

/** 父视图 */
@property (nonatomic, assign, readonly) CGRect discountNewsViewFrame;

/** 促销活动图片 */
@property (nonatomic, assign, readonly) CGRect salePicImgViewFrame;

/** 促销活动标题 */
@property (nonatomic, assign, readonly) CGRect saleTitleLabelFrame;

/** 副标题 */
@property (nonatomic, assign, readonly) CGRect subSeriesLabelFrame;

/** 报名人数 */
@property (nonatomic, assign, readonly) CGRect numberLabelFrame;

/** 活动详情 */
@property (nonatomic, assign, readonly) CGRect detailLabelFrame;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
