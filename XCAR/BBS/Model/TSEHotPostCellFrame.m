//
//  TSEHotPostCellFrame.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHotPostCellFrame.h"
#import "TSEHotPost.h"
#import "Public.h"

@implementation TSEHotPostCellFrame

- (void)setHotPost:(TSEHotPost *)hotPost {
    
    _hotPost = hotPost;
    
    CGFloat cellWidth = ScreenWidth - 2 * kHotPostTableViewMargin;
    
    /** 父视图 */
    CGFloat hotPostViewX = 2 * kHotPostCellMargin;
    CGFloat hotPostViewY = kHotPostCellMargin;
    CGFloat hotPostViewW = cellWidth - 2 * kHotPostCellMargin;
    CGFloat hotPostViewH = 0.0;
    
    /** 帖子标题 */
    CGFloat postTitleLabelX = 0.0;
    CGFloat postTitleLabelY = 0.0;
    CGFloat postTitleLabelW = hotPostViewW - 2 * kHotPostCellMargin;
    NSDictionary *postTitleAttrs = @{NSFontAttributeName : kHotPostTitleFont};
    CGSize postTitleSize = [hotPost.postTitle sizeWithAttributes:postTitleAttrs];
    NSInteger rows = ceil(postTitleSize.width / postTitleLabelW + 0.5);
    CGFloat postTitleLabelH = postTitleSize.height * rows;
    _postTitleLabelFrame = CGRectMake(postTitleLabelX, postTitleLabelY, postTitleLabelW, postTitleLabelH);
    
    /** 创建时间 */
    CGFloat createDateLabelX = postTitleLabelX;
    CGFloat createDateLabelY = CGRectGetMaxY(_postTitleLabelFrame) + 2 * kHotPostCellMargin;
    CGFloat createDateLabelW = 78.0;
    NSDictionary *createDateAttrs = @{NSFontAttributeName : kHotPostCreateDateFont};
    CGSize createDateSize = [hotPost.createDate sizeWithAttributes:createDateAttrs];
    _createDateLabelFrame = CGRectMake(createDateLabelX, createDateLabelY, createDateLabelW, createDateSize.height);
    
    /** 最新回复时间 */
    CGFloat replyDateLabelX = CGRectGetMaxX(_createDateLabelFrame) + 3.0;
    CGFloat replyDateLabelY = createDateLabelY;
    CGFloat replyDateLabelW = 34.0;
    NSDictionary *replyDateAttrs = @{NSFontAttributeName : kHotPostCreateDateFont};
    CGSize replyDateSize = [hotPost.replyDate sizeWithAttributes:replyDateAttrs];
    _replyDateLabelFrame = CGRectMake(replyDateLabelX, replyDateLabelY, replyDateLabelW, replyDateSize.height);
    
    /** 是否显示图片 */
    CGFloat hasImageViewX = CGRectGetMaxX(_replyDateLabelFrame) + 6.0;
    CGFloat hasImageViewY = replyDateLabelY + 3.0;
    CGFloat hasImageViewW = 22.0;
    CGFloat hasImageViewH = 13.0;
    if (hotPost.hasImage) {
        _hasImageViewFrame = CGRectMake(hasImageViewX, hasImageViewY, hasImageViewW, hasImageViewH);
    }
    
    /** 论坛名 */
    CGFloat forumNameLabelX = 0.0;
    if (hotPost.hasImage) {
        forumNameLabelX = CGRectGetMaxX(_hasImageViewFrame) + 6.0;
    } else {
        forumNameLabelX = CGRectGetMaxX(_replyDateLabelFrame) + 6.0 + hasImageViewW;
    }
    CGFloat forumNameLabelY = createDateLabelY;
    CGFloat forumNameLabelW = 73.0;
    NSDictionary *forumNameAttrs = @{NSFontAttributeName : kHotPostCreateDateFont};
    CGSize forumNameSize = [hotPost.forumName sizeWithAttributes:forumNameAttrs];
    _forumNameLabelFrame = CGRectMake(forumNameLabelX, forumNameLabelY, forumNameLabelW, forumNameSize.height);
    
    /** 浏览人数view */
    CGFloat viewCountViewX = CGRectGetMaxX(_forumNameLabelFrame) + 3 * kHotPostCellMargin;
    CGFloat viewCountViewH = 18.0;
    CGFloat viewCountViewY = forumNameLabelY;
    CGFloat viewCountViewW = 18.0;
    _viewCountViewFrame = CGRectMake(viewCountViewX, viewCountViewY, viewCountViewW, viewCountViewH);
    
    /** 浏览人数label */
    CGFloat viewCountLabelX = CGRectGetMaxX(_viewCountViewFrame) + hotPostViewX;
    CGFloat viewCountLabelY = createDateLabelY;
    CGFloat viewCountLabelW = 50.0;
    CGFloat viewCountLabelH = 17.0;
    _viewCountLabelFrame = CGRectMake(viewCountLabelX, viewCountLabelY, viewCountLabelW, viewCountLabelH);
    
    /** 分割线 */
    CGFloat separatorViewFrameX = hotPostViewX - hotPostViewX;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_viewCountLabelFrame) + hotPostViewX;
    CGFloat separatorViewFrameW = hotPostViewW - hotPostViewX;
    CGFloat separatorViewFrameH = 1.0;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /** 父视图 */
    hotPostViewH = CGRectGetMaxY(_separatorViewFrame);
    _hotPostViewFrame = CGRectMake(hotPostViewX, hotPostViewY, hotPostViewW, hotPostViewH);
    
    /** cell的总高度 */
    _cellHeight = CGRectGetMaxY(_hotPostViewFrame) + kHotPostCellMargin;
}

@end
