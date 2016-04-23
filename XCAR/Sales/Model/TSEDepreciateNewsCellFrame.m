//
//  TSEDepreciateNewsCellFrame.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateNewsCellFrame.h"

#import "TSEDepreciateNews.h"
#import "Public.h"

@implementation TSEDepreciateNewsCellFrame

-(void)setDepreciateNews:(TSEDepreciateNews *)depreciateNews {
    
    _depreciateNews = depreciateNews;
    
    CGFloat cellWidth = ScreenWidth - 2 * kDepreciateNewsCellMargin;
    
    /** 父视图 */
    CGFloat depreciateNewsViewX = kDepreciateNewsCellMargin;
    CGFloat depreciateNewsViewY = kDepreciateNewsCellMargin;
    CGFloat depreciateNewsViewW = cellWidth;
    CGFloat depreciateNewsViewH = 0.0;
    
    /** 降价汽车图片 */
    CGFloat imageURLViewX = kDepreciateNewsCellMargin / 2;
    CGFloat imageURLViewY = kDepreciateNewsCellMargin  / 4 * 3;
    CGFloat imageURLViewW = 120.0;
    CGFloat imageURLViewH = 100.0;
    _imageURLViewFrame = CGRectMake(imageURLViewX, imageURLViewY, imageURLViewW, imageURLViewH);
    
    /** 降价汽车名称 */
    CGFloat carNameLabelX = CGRectGetMaxX(_imageURLViewFrame) + kDepreciateNewsCellMargin;
    CGFloat carNameLabelY = imageURLViewY;
    CGFloat carNameLabelW = depreciateNewsViewW - imageURLViewW - 2 * kDepreciateNewsCellMargin;
    NSDictionary *carNameAttrs = @{NSFontAttributeName : kDepreciateNewsTitleFont};
    CGSize carNameSize = [depreciateNews.carName sizeWithAttributes:carNameAttrs];
    NSInteger rows = ceil(carNameSize.width / carNameLabelW + 0.5);
    CGFloat carNameLabelH = carNameSize.height * rows;
    _carNameLabelFrame = CGRectMake(carNameLabelX, carNameLabelY, carNameLabelW, carNameLabelH);
    
    /** 降价幅度 */
    CGFloat discountLabelX = carNameLabelX;
    CGFloat discountLabelY = CGRectGetMaxY(_carNameLabelFrame)  + kDepreciateNewsCellMargin;
    CGFloat discountLabelW = 90.0;
    CGFloat discountLabelH = 16.0;
    _discountLabelFrame = CGRectMake(discountLabelX, discountLabelY, discountLabelW, discountLabelH);
    
    /** 现价 */
    CGFloat currentPriceLabelX = discountLabelX;
    CGFloat currentPriceLabelY = CGRectGetMaxY(_discountLabelFrame) + kDepreciateNewsCellMargin;
    CGFloat currentPriceLabelW = 90.0;
    CGFloat currentPriceLabelH = 16.0;
    _currentPriceLabelFrame = CGRectMake(currentPriceLabelX, currentPriceLabelY, currentPriceLabelW, currentPriceLabelH);
    
    /** 有无现车 */
    CGFloat tagLabelX = 0.0;
    if (ScreenWidth == ScreenWidth5S) {
        tagLabelX = CGRectGetMaxX(_discountLabelFrame) + kDepreciateNewsCellMargin / 2;
    } else {
        tagLabelX = CGRectGetMaxX(_discountLabelFrame) + discountLabelW / 5 * 3;
    }
    CGFloat tagLabelY = discountLabelY;
    CGFloat tagLabelW = 60.0;
    CGFloat tagLabelH = 16.0;
    _tagLabelFrame = CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH);
    
    /** 购车计算 */
    CGFloat buyCarBtnX = imageURLViewX;
    CGFloat buyCarBtnY = CGRectGetMaxY(_imageURLViewFrame) + kDepreciateNewsCellMargin;
    CGFloat buyCarBtnW = 100.0;
    CGFloat buyCarBtnH = 40.0;
    _buyCarBtnFrame = CGRectMake(buyCarBtnX, buyCarBtnY, buyCarBtnW, buyCarBtnH);
    
    /** 拨打电话 */
    CGFloat telBtnX = CGRectGetMaxX(_buyCarBtnFrame) + kDepreciateNewsCellMargin / 2;
    CGFloat telBtnY = buyCarBtnY;
    CGFloat telBtnW = (depreciateNewsViewW - buyCarBtnW - 2 * kDepreciateNewsCellMargin) / 2;
    CGFloat telBtnH = buyCarBtnH;
    _telBtnFrame = CGRectMake(telBtnX, telBtnY, telBtnW, telBtnH);
    
    /** 问最低价 */
    CGFloat lowestPriceBtnX = CGRectGetMaxX(_telBtnFrame) + kDepreciateNewsCellMargin / 2;
    CGFloat lowestPriceBtnY = telBtnY;
    CGFloat lowestPriceBtnW = telBtnW;
    CGFloat lowestPriceBtnH = telBtnH;
    _lowestPriceBtnFrame = CGRectMake(lowestPriceBtnX, lowestPriceBtnY, lowestPriceBtnW, lowestPriceBtnH);
    
    
    /** 父视图 */
    depreciateNewsViewH = CGRectGetMaxY(_buyCarBtnFrame) + kDepreciateNewsCellMargin;
    _depreciateNewsViewFrame = CGRectMake(depreciateNewsViewX, depreciateNewsViewY, depreciateNewsViewW, depreciateNewsViewH);
    
    /** cell的高度 */
    _cellHeight = CGRectGetMaxY(_depreciateNewsViewFrame);
}

@end
