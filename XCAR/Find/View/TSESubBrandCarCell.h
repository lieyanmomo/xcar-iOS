//
//  TSESubBrandCarCell.h
//  XCAR
//
//  Created by Morris on 10/9/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSESubBrandCarCell : UITableViewCell

/** 汽车图片 */
@property (nonatomic, strong) UIImageView *carImageView;
/** 汽车名称 */
@property (nonatomic, strong) UILabel *carNameLabel;
/** 汽车价钱 */
@property (nonatomic, strong) UILabel *carPriceLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
