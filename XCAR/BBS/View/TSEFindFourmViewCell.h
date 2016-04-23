//
//  TSEFindFourmViewCell.h
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEFindFourmViewCell : UICollectionViewCell

/** 图片信息 */
@property (nonatomic, strong) UILabel *infoLabel;

/**
 *  根据cell的tag属性依次设置图片对应的文字
 *
 *  @param tag cell所对应的位置（indexPath.item）
 */
- (void)setInfoLabelTextWithTag:(NSInteger)tag;

@end
