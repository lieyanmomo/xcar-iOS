//
//  TSESubBrand.h
//  XCAR
//
//  Created by Morris on 10/10/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSESubBrand : NSObject

/** 子品牌数量 */
@property (nonatomic, copy) NSString *subBrandNum;

/** 子品牌名称 */
@property (nonatomic, copy) NSString *subBrandName;

/** 子品牌车型系列 */
@property (nonatomic, strong) NSMutableArray *series;

/** 子品牌车型系列数量 */
@property (nonatomic, copy) NSString *seriesNum;

@end
