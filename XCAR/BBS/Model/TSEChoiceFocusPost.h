//
//  TSEChoiceFocusPost.h
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSEChoiceFocusPost : NSObject

/** 帖子图片链接 */
@property (nonatomic, copy) NSString *focusImage;

/** 帖子标题 */
@property (nonatomic, copy) NSString *focusTitle;

/** 帖子链接 */
@property (nonatomic, copy) NSString *focusLink;


@end
