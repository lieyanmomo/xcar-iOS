//
//  TSEDepreciateNewsCellFrame.h
//  XCAR
//
//  Created by Morris on 10/4/15.
//  assign, readonlyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kDepreciateNewsCellMargin 12
#define kDepreciateNewsTitleFont [UIFont systemFontOfSize:16]
#define kDepreciateNewsSubTitleFont [UIFont systemFontOfSize:15]
#define kDepreciateNewsViewMargin 5

@class TSEDepreciateNews;
@interface TSEDepreciateNewsCellFrame : NSObject

@property (nonatomic, strong) TSEDepreciateNews *depreciateNews;

/** 父视图 */
@property (nonatomic, assign, readonly) CGRect depreciateNewsViewFrame;

/** 降价汽车图片 */
@property (nonatomic, assign, readonly) CGRect imageURLViewFrame;

/** 降价汽车名称 */
@property (nonatomic, assign, readonly) CGRect carNameLabelFrame;

/** 降价幅度 */
@property (nonatomic, assign, readonly) CGRect discountLabelFrame;

/** 现价 */
@property (nonatomic, assign, readonly) CGRect currentPriceLabelFrame;

/** 有无现车 */
@property (nonatomic, assign, readonly) CGRect tagLabelFrame;

/** 购车计算 */
@property (nonatomic, assign, readonly) CGRect buyCarBtnFrame;

/** 拨打电话 */
@property (nonatomic, assign, readonly) CGRect telBtnFrame;

/** 问最低价 */
@property (nonatomic, assign, readonly) CGRect lowestPriceBtnFrame;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
