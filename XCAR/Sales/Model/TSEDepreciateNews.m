//
//  TSEDepreciateNews.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateNews.h"

@implementation TSEDepreciateNews

- (void)setDiscount:(NSString *)discount {
    _discount = [NSString stringWithFormat:@"直降%@", discount];
}

- (void)setCurrentPrice:(NSString *)currentPrice {
    _currentPrice = [NSString stringWithFormat:@"现价%@", currentPrice];
}

@end
