//
//  TSEDepreciateNewsCell.h
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSEDepreciateNewsCellFrame;
@interface TSEDepreciateNewsCell : UITableViewCell

@property (nonatomic, strong) TSEDepreciateNewsCellFrame *depreciateNewsCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
