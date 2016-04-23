//
//  TSEHotPostCellFrame.h
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** HotPostCell的间距 */
#define kHotPostCellMargin 6
#define kHotPostTableViewMargin 1

/** 副标题的颜色 */
#define kSubtitleColor TSEColor(136, 139, 146)

/** 帖子标题字体大小 */
#define kHotPostTitleFont [UIFont systemFontOfSize:16]

/** 帖子论坛字体大小 */
#define kHotPostForumFont [UIFont systemFontOfSize:14]

/** 浏览人数字体大小 */
#define kHotPostViewCountFont kHotPostForumFont

/** 发布时间字体大小 */
#define kHotPostCreateDateFont kHotPostViewCountFont

@class TSEHotPost;
@interface TSEHotPostCellFrame : NSObject

@property (nonatomic, strong) TSEHotPost *hotPost;

/** 父视图 */
@property (nonatomic, assign, readonly) CGRect hotPostViewFrame;

/** 创建时间 */
@property (nonatomic, assign, readonly) CGRect createDateLabelFrame;

/** 最新回复时间 */
@property (nonatomic, assign, readonly) CGRect replyDateLabelFrame;

/** 是否显示图片 */
@property (nonatomic, assign, readonly) CGRect hasImageViewFrame;

/** 帖子标题 */
@property (nonatomic, assign, readonly) CGRect postTitleLabelFrame;

/** 论坛名 */
@property (nonatomic, assign, readonly) CGRect forumNameLabelFrame;

/** 浏览人数view */
@property (nonatomic, assign, readonly) CGRect viewCountViewFrame;

/** 浏览人数label */
@property (nonatomic, assign, readonly) CGRect viewCountLabelFrame;

/** 分割线 */
@property (nonatomic, assign, readonly) CGRect separatorViewFrame;

/** cell的总高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
