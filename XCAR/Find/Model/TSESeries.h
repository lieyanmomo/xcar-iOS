//
//  TSESeries.h
//  XCAR
//
//  Created by Morris on 10/10/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSESeries : NSObject

/** 子品牌车型系列图标 */
@property (nonatomic, copy) NSString *seriesIcon;

/** 子品牌车型系列名字 */
@property (nonatomic, copy) NSString *seriesName;

/** 子品牌车型系列价钱 */
@property (nonatomic, copy) NSString *seriesPrice;

@end
