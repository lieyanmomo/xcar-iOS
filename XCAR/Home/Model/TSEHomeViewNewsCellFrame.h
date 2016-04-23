//
//  TSEHomeViewNewsCellFrame.h
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Public.h"

/** HomeViewNewsCell的间距 */
#define kHomeViewNewsCellMargin 6
#define kHomeViewNewsTableViewMargin 1

/** 副标题的颜色 */
#define kSubtitleColor TSEColor(137, 138, 142)

/** 新闻标题字体大小 */
#define kHomeViewNewsTitleFont [UIFont systemFontOfSize:16]

/** 新闻类型字体大小 */
#define kHomeViewNewsCategoryFont [UIFont systemFontOfSize:14]

/** 新闻评论字体大小 */
#define kHomeViewNewsCommentFont kHomeViewNewsCategoryFont

@class TSEHomeViewNews;
@interface TSEHomeViewNewsCellFrame : NSObject
@property (nonatomic, strong) TSEHomeViewNews *homeViewNews;

/** 父视图 */
@property (nonatomic, assign, readonly) CGRect homeViewNewsViewFrame;

/** 新闻类别 */
@property (nonatomic, assign, readonly) CGRect categotyFrame;

/** 新闻评论(image) */
@property (nonatomic, assign, readonly) CGRect commentViewFrame;

/** 新闻评论 */
@property (nonatomic, assign, readonly) CGRect commentFrame;

/** 新闻图片 */
@property (nonatomic, assign, readonly) CGRect newsImageFrame;

/** 新闻标题 */
@property (nonatomic, assign, readonly) CGRect titleFrame;

/** 新闻发布时间 */
@property (nonatomic, assign, readonly) CGRect pubTimeLabelFrame;

/** 分割线 */
@property (nonatomic, assign, readonly) CGRect separatorViewFrame;

/** cell的总高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
