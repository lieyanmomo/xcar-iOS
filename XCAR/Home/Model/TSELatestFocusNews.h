//
//  TSELatestFocusNews.h
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSELatestFocusNews : NSObject

/** 图片链接 */
@property (nonatomic, copy) NSString *imgURL;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 详细新闻链接 */
@property (nonatomic, copy) NSString *newsLink;

@end
