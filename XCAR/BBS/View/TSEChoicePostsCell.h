//
//  TSEChoicePostsCell.h
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSEChoicePostCellFrame;
@interface TSEChoicePostsCell : UITableViewCell

/** choicePostCellFrame的frame */
@property (nonatomic, strong) TSEChoicePostCellFrame *choicePostCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
