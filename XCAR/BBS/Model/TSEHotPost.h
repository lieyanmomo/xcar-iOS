//
//  TSEHotPost.h
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEHotPost : NSObject

/** 创建时间 */
@property (nonatomic, copy) NSString *createDate;

/** 有无图片 */
@property (nonatomic, assign) BOOL hasImage;

/** 论坛名 */
@property (nonatomic, copy) NSString *forumName;

/** 浏览人数 */
@property (nonatomic, copy) NSString *viewCount;

/** 帖子标题 */
@property (nonatomic, copy) NSString *postTitle;

/** 帖子链接 */
@property (nonatomic, copy) NSString *postLink;

/** 最新回复时间 */
@property (nonatomic, copy) NSString *replyDate;

@end
