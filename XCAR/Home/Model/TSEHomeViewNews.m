//
//  TSEHomeViewNews.m
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEHomeViewNews.h"

@implementation TSEHomeViewNews

/**
 *  新闻的发布时间不会变，override setter方法即可
 */
- (void)setNewsCreateTime:(NSString *)newsCreateTime {
    
    // 服务器返回的时间数据
    // 144 302,4000 2015-09-24
    // 144 293,7600 2015-09-23
    // 302,4000 - 293,7600 = 86400 = 24h * 60mins * 60s = 1 day
    NSInteger location = 3;
    NSInteger length = 7;
    NSString *strDate = [newsCreateTime substringWithRange:NSMakeRange(location, length)];
    
    NSInteger date = [strDate integerValue];

    NSInteger day = date / 86400;
    
    if (day > 41) {
        day = day - 41;
    } else {
        day = day - 11;
    }
    
    if (day % 10 < 1) {
        _newsCreateTime = [NSString stringWithFormat:@"%ld", day];
    } else {
        _newsCreateTime = [NSString stringWithFormat:@"0%ld", day];
    }
}

- (void)setPubTime:(NSInteger)pubTime {
    
    // 服务器返回的时间数据
    // 201509
    NSString *pubTimeStr = [NSString stringWithFormat:@"%ld%@", pubTime, _newsCreateTime];
    
    _pubTime = [pubTimeStr integerValue];
}

@end
