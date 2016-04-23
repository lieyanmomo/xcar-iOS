//
//  TSEFindCarSpecialSales.h
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEFindCarSpecialSales : NSObject

/** 车图片 */
@property (nonatomic, copy) NSString *seriesImage;

/** 车名字 */
@property (nonatomic, copy) NSString *carName;

/** 降价幅度 */
@property (nonatomic, copy) NSString *cheapRange;

/** 销售商 */
@property (nonatomic, copy) NSString *dealerName;

/** 电话 */
@property (nonatomic, copy) NSString *dealerTel;

@end
