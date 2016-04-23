//
//  TSESubBrandCarViewController.h
//  XCAR
//
//  Created by Morris on 10/10/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSESubBrandCarViewController : UIViewController

/**
 *  @param indexPath 获取当前点击的品牌
 *  @param brands    获取所有品牌的数据
 */
- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath brands:(NSArray *)brands;

@end
