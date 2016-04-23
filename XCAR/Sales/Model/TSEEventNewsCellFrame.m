//
//  TSEEventNewsCellFrame.m
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEEventNewsCellFrame.h"
#import "TSEEventNews.h"

@implementation TSEEventNewsCellFrame


- (void)setEventNews:(TSEEventNews *)eventNews {
 
    _eventNews = eventNews;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 父视图 */
    CGFloat eventNewsViewX = kEventNewsCellMargin;
    CGFloat eventNewsViewY = kEventNewsCellMargin;
    CGFloat eventNewsViewW = cellW - 2 * kEventNewsCellMargin;
    CGFloat eventNewsViewH = 0.0f;
    
    /** 活动大图 */
    CGFloat eventBigImgViewX = kEventNewsViewMargin;
    CGFloat eventBigImgViewY = kEventNewsViewMargin;
    CGFloat eventBigImgViewW = eventNewsViewW - 2 * kEventNewsViewMargin;
    CGFloat eventBigImgViewH = 200.0f;
    _eventBigImgViewFrame = CGRectMake(eventBigImgViewX, eventBigImgViewY, eventBigImgViewW, eventBigImgViewH);
    
    /** 左上角标 */
    CGFloat topLeftBadgeViewX = eventBigImgViewX;
    CGFloat topLeftBadgeViewY = eventBigImgViewY;
    CGFloat topLeftBadgeViewW = 43.0;
    CGFloat topLeftBadgeViewH = 43.0;
    _topLeftBadgeViewFrame = CGRectMake(topLeftBadgeViewX, topLeftBadgeViewY, topLeftBadgeViewW, topLeftBadgeViewH);
    
    /** 右下角标 */
    CGFloat bottomRightBadgeViewW = 55.0;
    CGFloat bottomRightBadgeViewH = 30.0;
    CGFloat bottomRightBadgeViewX = CGRectGetMaxX(_eventBigImgViewFrame) - bottomRightBadgeViewW + 10;
    CGFloat bottomRightBadgeViewY = CGRectGetMaxY(_eventBigImgViewFrame) - bottomRightBadgeViewH + 8;
    _bottomRightBadgeViewFrame = CGRectMake(bottomRightBadgeViewX, bottomRightBadgeViewY, bottomRightBadgeViewW, bottomRightBadgeViewH);
    
    /** 活动标题 */
    CGFloat eventTitleLabelX = 3 * kEventNewsViewMargin;
    CGFloat eventTitleLabelY = CGRectGetMaxY(_eventBigImgViewFrame) + 2 * kEventNewsViewMargin;
    CGFloat eventTitleLabelW = eventNewsViewW - 6 * kEventNewsViewMargin;
    NSDictionary *eventTitleAttrs = @{NSFontAttributeName : kEventNewsTitleFont};
    CGSize eventTitleSize = [eventNews.eventTitle sizeWithAttributes:eventTitleAttrs];
    CGFloat eventTitleLabelH = eventTitleSize.height;
    _eventTitleLabelFrame = CGRectMake(eventTitleLabelX, eventTitleLabelY, eventTitleLabelW, eventTitleLabelH);
    
    /** 活动截至时间 */
    CGFloat eventEndTimeLabelX = eventTitleLabelX;
    CGFloat eventEndTimeLabelY = CGRectGetMaxY(_eventTitleLabelFrame) + 2 * kEventNewsViewMargin;
    CGFloat eventEndTimeLabelW = eventBigImgViewW - 2 * kEventNewsViewMargin;
    CGFloat eventEndTimeLabelH = 30;
    _eventEndTimeLabelFrame = CGRectMake(eventEndTimeLabelX, eventEndTimeLabelY, eventEndTimeLabelW, eventEndTimeLabelH);
    
    /** 活动地点 */
    CGFloat eventPlaceLabelX = eventEndTimeLabelX;
    CGFloat eventPlaceLabelY = CGRectGetMaxY(_eventEndTimeLabelFrame) + kEventNewsViewMargin;
    CGFloat eventPlaceLabelW = eventEndTimeLabelW;
    CGFloat eventPlaceLabelH = eventEndTimeLabelH;
    _eventPlaceLabelFrame = CGRectMake(eventPlaceLabelX, eventPlaceLabelY, eventPlaceLabelW, eventPlaceLabelH);
    
    /** 感兴趣人数 */
    CGFloat eventInterestBtnX = 0.0;
    CGFloat eventInterestBtnY = CGRectGetMaxY(_eventPlaceLabelFrame) + kEventNewsViewMargin;
    CGFloat eventInterestBtnW = eventNewsViewW / 2;
    CGFloat eventInterestBtnH = 44;
    _eventInterestBtnFrame = CGRectMake(eventInterestBtnX, eventInterestBtnY, eventInterestBtnW, eventInterestBtnH);
    
    /** 活动分享 */
    CGFloat eventShareBtnX = eventInterestBtnW;
    CGFloat eventShareBtnY = eventInterestBtnY;
    CGFloat eventShareBtnW = eventInterestBtnW;
    CGFloat eventShareBtnH = eventInterestBtnH;
    _eventShareBtnFrame = CGRectMake(eventShareBtnX, eventShareBtnY, eventShareBtnW, eventShareBtnH);
    
    /** 父视图高度 */
    eventNewsViewH = CGRectGetMaxY(_eventShareBtnFrame);
    _eventNewsViewFrame = CGRectMake(eventNewsViewX, eventNewsViewY, eventNewsViewW, eventNewsViewH);
    
    /** cell的高度 */
    _cellHeight = CGRectGetMaxY(_eventNewsViewFrame) + kEventNewsCellMargin;
}

@end
