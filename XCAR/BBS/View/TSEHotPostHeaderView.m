//
//  TSEHotPostHeaderView.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPostHeaderView.h"

@implementation TSEHotPostHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"retie_header-1"]];
        [self setContentMode:UIViewContentModeScaleToFill];
        [self setupWidget];
    }
    return self;
}

- (void)setupWidget {
    UIImageView *hotFire = [[UIImageView alloc] init];
    [hotFire setContentMode:UIViewContentModeScaleAspectFit];
    UIImage *image = [UIImage imageNamed:@"retie_hot"];
    [hotFire setImage:image];
    [hotFire setFrame:CGRectMake(15.0, 0.0, image.size.width, self.frame.size.height)];
    [self addSubview:hotFire];
    
    UILabel *retieLabel = [[UILabel alloc] init];
    [retieLabel setFrame:CGRectMake(CGRectGetMaxX(hotFire.frame) + 10, 0.0, 120.0, self.frame.size.height)];
    [retieLabel setText:@"24小时热帖"];
    [retieLabel setFont:[UIFont systemFontOfSize:18]];
    [retieLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:retieLabel];
}

@end
