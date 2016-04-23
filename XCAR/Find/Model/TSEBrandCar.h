//
//  TSEBrandCar.h
//  XCAR
//
//  Created by Morris on 10/5/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEBrandCar : NSObject

/** 汽车品牌 */
@property (nonatomic, strong) NSMutableArray *brands;

/** 所有品牌数目 */
@property (nonatomic, assign) NSInteger letterNum;

/** 品牌所有车型数目 */
@property (nonatomic, assign) NSInteger brandNum;

/** 品牌首字母 */
@property (nonatomic, copy) NSString *letter;


@end
