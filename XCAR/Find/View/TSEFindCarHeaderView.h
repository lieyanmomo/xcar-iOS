//
//  TSEFindCarHeaderView.h
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEFindCarHeaderView : UIView

@property (nonatomic, assign, readonly) CGFloat cellHeight;

- (instancetype)initHeaderViewWithSeriesImage:(NSString *)seriesImage carName:(NSString *)carName cheapRange:(NSString *)cheapRange dealerName:(NSString *)dealerName;

@end
