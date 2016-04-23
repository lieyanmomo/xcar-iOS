//
//  TSEChoicePost.h
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEChoicePost : NSObject

/** 论坛名 */
@property (nonatomic, copy) NSString *forumName;

/** 浏览人数 */
@property (nonatomic, copy) NSString *viewCount;

/** 帖子标题 */
@property (nonatomic, copy) NSString *postTitle;

/** 帖子链接 */
@property (nonatomic, copy) NSString *postLink;

/** 帖子图片链接 */
@property (nonatomic, copy) NSString *postImage;

@end
