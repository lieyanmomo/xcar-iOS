//
//  TSEBrandFindCarViewCell.h
//  XCAR
//
//  Created by Morris on 10/5/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEBrandFindCarViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *brandLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
