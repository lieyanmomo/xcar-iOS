//
//  TSEHomeViewNewsCell.h
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSEHomeViewNewsCellFrame;
@interface TSEHomeViewNewsCell : UITableViewCell

/** homeViewNewsCell的frame */
@property (nonatomic, strong) TSEHomeViewNewsCellFrame *homeViewNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end