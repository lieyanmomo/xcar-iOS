//
//  TSEHotPostCell.h
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSEHotPostCellFrame;
@interface TSEHotPostCell : UITableViewCell

@property (nonatomic, strong) TSEHotPostCellFrame *hotPostCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
