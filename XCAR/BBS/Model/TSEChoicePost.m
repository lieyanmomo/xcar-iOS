//
//  TSEChoicePost.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEChoicePost.h"

@implementation TSEChoicePost

- (void)setViewCount:(NSString *)viewCount {
    
    double num = [viewCount doubleValue];
    
    double viewCountNum = roundf(num / 1000.0) * 0.1;
    
    _viewCount = [NSString stringWithFormat:@"%.1fw", viewCountNum];
}

@end
