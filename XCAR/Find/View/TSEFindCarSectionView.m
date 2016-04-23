//
//  TSEFindCarSectionView.m
//  XCAR
//
//  Created by Morris on 10/7/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEFindCarSectionView.h"
#import "Public.h"

@implementation TSEFindCarSectionView

- (instancetype)initWithSectionTitles:(NSString *)sectionTitles {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(18.0, 0.0, ScreenWidth, 23.0)];
        [self setBackgroundColor:TSEColor(248, 248, 248)];
        [self.layer setBorderColor:TSEColor(221, 221, 221).CGColor];
        [self.layer setBorderWidth:0.4];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:sectionTitles];
        [attrStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName : TSEColor(142, 142, 142)} range:NSMakeRange(0, attrStr.length)];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self.headerLabel setBackgroundColor:TSEColor(248, 248, 248)];
        self.headerLabel.opaque = NO;
        [self.headerLabel setAttributedText:attrStr];
        [self addSubview:self.headerLabel];
    }
    return self;
}

@end
