//
//  TSEProfileSectionView.m
//  XCAR
//
//  Created by Morris on 10/7/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEProfileSectionView.h"
#import "Public.h"

@implementation TSEProfileSectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0.0, 0.0, ScreenWidth, 20.0)];
        [self setBackgroundColor:TSEColor(235, 235, 235)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dongtai"]];
        [imageView setFrame:CGRectMake(15.0, self.frame.size.height / 2 - 4, 18.0, 18.0)];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        [label setText:@"好友动态"];
        [label setFont:[UIFont systemFontOfSize:18.0]];
        [label setTextColor:TSEColor(136, 139, 147)];
        [label setFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10.0, self.frame.size.height / 2 - 5, 100.0, 20.0)];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
    }
    return self;
}

@end
