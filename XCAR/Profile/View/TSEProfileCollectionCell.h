//
//  TSEProfileCollectionCell.h
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEProfileCollectionCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIImageView *picView;
/** 图片信息 */
@property (nonatomic, strong) UILabel *infoLabel;

/**
 *  根据cell的tag属性依次设置图片对应的文字
 *
 *  @param tag cell所对应的位置（indexPath.item）
 */
- (void)setInfoLabelTextWithTag:(NSInteger)tag;

/**
 *  根据cell的tag属性依次设置图片
 *
 *  @param tag cell所对应的位置（indexPath.item）
 */
- (void)setPicViewImageWithTag:(NSInteger)tag;

@end
