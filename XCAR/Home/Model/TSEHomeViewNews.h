//
//  TSEHomeViewNews.h
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEHomeViewNews : NSObject

/** 新闻图片链接 */
@property (nonatomic, copy) NSString *newsImage;

/** 新闻链接（手机端） */
@property (nonatomic, copy) NSString *newsLink;

/** 新闻链接（电脑端） */
@property (nonatomic, copy) NSString *webLink;

/** 新闻类别 */
@property (nonatomic, copy) NSString *newsCategory;

/** 新闻标题 */
@property (nonatomic, copy) NSString *newsTitle;

/** 评论数 */
@property (nonatomic, assign) NSInteger commentCount;

/** 新闻创建时间 */
@property (nonatomic, copy) NSString *newsCreateTime;

/** 新闻标示 */
@property (nonatomic, copy) NSString *newsId;

/** 广告位 */
@property (nonatomic, assign) NSInteger adIndex;

/** 新闻发布时间 */
@property (nonatomic, assign) NSInteger pubTime;

@end
