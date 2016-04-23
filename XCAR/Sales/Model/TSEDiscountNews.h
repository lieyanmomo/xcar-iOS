//
//  TSEDiscountNews.h
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEDiscountNews : NSObject

/** 促销活动图片 */
@property (nonatomic, copy) NSString *salePic;

/** 促销活动标题 */
@property (nonatomic, copy) NSString *saleTitle;

/** 副标题 */
@property (nonatomic, strong) NSArray *subSeries;

@property (nonatomic, copy) NSString *subSerie;

/** 报名人数 */
@property (nonatomic, copy) NSString *number;


@end
