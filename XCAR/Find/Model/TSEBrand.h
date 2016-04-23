//
//  TSEBrand.h
//  XCAR
//
//  Created by Morris on 10/5/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEBrand : NSObject

/** 车型图标 */
@property (nonatomic, copy) NSString *icon;

/** 车型名字 */
@property (nonatomic, copy) NSString *name;

/** 子品牌id */
@property (nonatomic, copy) NSString *ID;

@end
