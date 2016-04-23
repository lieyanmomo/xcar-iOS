//
//  TSEFindCarSpecialSales.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEFindCarSpecialSales.h"

@implementation TSEFindCarSpecialSales

- (void)setCheapRange:(NSString *)cheapRange {
    _cheapRange = [NSString stringWithFormat:@"直降%@万", cheapRange];
}

- (void)setDealerName:(NSString *)dealerName {
    _dealerName = [NSString stringWithFormat:@"(4S)%@", dealerName];
}

@end
