//
//  TSEEventNewsCell.h
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSEEventNewsCellFrame;
@interface TSEEventNewsCell : UITableViewCell

@property (nonatomic, strong) TSEEventNewsCellFrame *eventNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
