//
//  TSEBrandCar.m
//  XCAR
//
//  Created by Morris on 10/5/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEBrandCar.h"
#import "MJExtension.h"

@implementation TSEBrandCar

// 字典中包含字典
// 将返回的json的字典的key作为为key，字典中的字典的数据类作为值
+ (NSDictionary *)objectClassInArray {
    return @{@"brands" : @"TSEBrand"};
}

- (void)setLetter:(NSString *)letter {
    _letter = letter.uppercaseString;
}

@end
