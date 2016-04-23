//
//  TSEChoicePostCellFrame.m
//  XCAR
//
//  Created by Morris on 10/3/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEChoicePostCellFrame.h"
#import "TSEChoicePost.h"

#import "Public.h"

@implementation TSEChoicePostCellFrame

- (void)setChoicePost:(TSEChoicePost *)choicePost {
    
    _choicePost = choicePost;
    
    CGFloat cellWidth = ScreenWidth - 2 * kChoicePostTableViewMargin;
    
    /** 父视图 */
    CGFloat choicePostViewX = 7.0;
    CGFloat choicePostViewY = 0.0;
    CGFloat choicePostViewW = cellWidth - 2 * kChoicePostCellMargin;
    CGFloat choicePostViewH = 0.0;
    
    /** 帖子图片 */
    CGFloat postImageViewX = kChoicePostCellMargin;
    CGFloat postImageViewY = kChoicePostCellMargin;
    CGSize postImageSize = CGSizeMake(90.0, 70.0);
    _postImageViewFrame = CGRectMake(postImageViewX, postImageViewY, postImageSize.width, postImageSize.height);
    
    /** 帖子标题 */
    CGFloat postTitleLabelX = CGRectGetMaxX(_postImageViewFrame) + kChoicePostCellMargin;
    CGFloat postTitleLabelY = postImageViewY;
    CGFloat postTitleLabelW = choicePostViewW - postImageSize.width - 4 * kChoicePostCellMargin;
    NSDictionary *postTitleAttrs = @{NSFontAttributeName : kChoicePostTitleFont};
    CGSize postTitleSize = [choicePost.postTitle sizeWithAttributes:postTitleAttrs];
    NSInteger rows = ceil(postTitleSize.width / postTitleLabelW + 0.5);
    CGFloat postTitleLabelH = postTitleSize.height * rows;
    _postTitleLabelFrame = CGRectMake(postTitleLabelX, postTitleLabelY, postTitleLabelW, postTitleLabelH);
    
    /** 论坛名 */
    CGFloat forumNameLabelX = postTitleLabelX;
    CGFloat forumNameLabelW = 120.0;
    CGFloat forumNameLabelH = 30.0;
    CGFloat forumNameLabelY = CGRectGetMaxY(_postImageViewFrame) - forumNameLabelH / 1.3;
    _forumNameLabelFrame = CGRectMake(forumNameLabelX, forumNameLabelY, forumNameLabelW, forumNameLabelH);
    
    /** 浏览人数view */
    CGFloat viewCountViewX = 0.0;
    if (ScreenWidth == ScreenWidth5S) {
        viewCountViewX = CGRectGetMaxX(_forumNameLabelFrame) + 3 * kChoicePostCellMargin;
    } else if (ScreenWidth == ScreenWidth6) {
        viewCountViewX = CGRectGetMaxX(_forumNameLabelFrame) + 9 * kChoicePostCellMargin;
    } else if (ScreenWidth == ScreenWidth6plus) {
        viewCountViewX = CGRectGetMaxX(_forumNameLabelFrame) + 15 * kChoicePostCellMargin;
    }
    CGFloat viewCountViewH = 18.0;
    CGFloat viewCountViewY = forumNameLabelY + viewCountViewH / 2.4;
    CGFloat viewCountViewW = 18.0;
    _viewCountViewFrame = CGRectMake(viewCountViewX, viewCountViewY, viewCountViewW, viewCountViewH);
    
    /** 浏览人数label */
    CGFloat viewCountLabelX = CGRectGetMaxX(_viewCountViewFrame) + kChoicePostCellMargin;
    CGFloat viewCountLabelY = forumNameLabelY;
    CGFloat viewCountLabelW = 50.0;
    CGFloat viewCountLabelH = 30.0;
    _viewCountLabelFrame = CGRectMake(viewCountLabelX, viewCountLabelY, viewCountLabelW, viewCountLabelH);
    
    /** 分割线 */
    CGFloat separatorViewFrameX = choicePostViewX - kChoicePostCellMargin;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_viewCountLabelFrame) + kChoicePostCellMargin;
    CGFloat separatorViewFrameW = choicePostViewW - kChoicePostCellMargin;
    CGFloat separatorViewFrameH = 1.0;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /** 父视图 */
    choicePostViewH = CGRectGetMaxY(_separatorViewFrame);
    _choicePostViewFrame = CGRectMake(choicePostViewX, choicePostViewY, choicePostViewW, choicePostViewH);
    
    /** cell的总高度 */
    _cellHeight = CGRectGetMaxY(_choicePostViewFrame) + kChoicePostCellMargin;
}

@end
