//
//  TSEHotPost.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPost.h"

@implementation TSEHotPost

- (void)setCreateDate:(NSString *)createDate {
    
    // 假数据
    _createDate = @"2015-10-03";
}

- (void)setReplyDate:(NSString *)replyDate {
    
    // 假数据
    _replyDate = @"12:18";
}

- (void)setViewCount:(NSString *)viewCount {
    
    double num = [viewCount doubleValue];
    
    double viewCountNum = roundf(num / 1000.0) * 0.1;
    
    _viewCount = [NSString stringWithFormat:@"%.1fw", viewCountNum];
}

@end
