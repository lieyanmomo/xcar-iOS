//
//  TSEHomeViewNewsCellFrame.m
//  XCAR
//
//  Created by Morris on 9/24/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEHomeViewNewsCellFrame.h"
#import "TSEHomeViewNews.h"
#import "Public.h"

@implementation TSEHomeViewNewsCellFrame

- (void)setHomeViewNews:(TSEHomeViewNews *)homeViewNews {
    
    _homeViewNews = homeViewNews;
    
    CGFloat cellWidth = ScreenWidth - 2 * kHomeViewNewsTableViewMargin;
        
    /** 父视图 */
    CGFloat homeViewNewsViewX = 7.0;
    CGFloat homeViewNewsViewY = 0.0;
    CGFloat homeViewNewsViewW = cellWidth - 2 * kHomeViewNewsCellMargin;
    CGFloat homeViewNewsViewH = 0.0;
    
    /** 新闻图片 */
    CGFloat newsImageX = kHomeViewNewsCellMargin;
    CGFloat newsImageY = kHomeViewNewsCellMargin;
    CGSize newsImageSize = CGSizeMake(90.0, 70.0);
    _newsImageFrame = (CGRect){{newsImageX, newsImageY}, newsImageSize};
    
    /** 新闻标题 */
    CGFloat newsTitleX = CGRectGetMaxX(_newsImageFrame) + kHomeViewNewsCellMargin;
    CGFloat newsTitleY = newsImageY;
    CGFloat newsTitleW = homeViewNewsViewW - newsImageSize.width - 4 * kHomeViewNewsCellMargin;
    NSDictionary *newsTitleAttrs = @{NSFontAttributeName : kHomeViewNewsTitleFont};
    CGSize newsTitleSize = [homeViewNews.newsTitle sizeWithAttributes:newsTitleAttrs];
    NSInteger rows = ceil(newsTitleSize.width / newsTitleW + 0.5);
    CGFloat newsTitleH = newsTitleSize.height * rows;
    _titleFrame = CGRectMake(newsTitleX, newsTitleY, newsTitleW, newsTitleH);
    
    /** 新闻发布时间 */
    CGFloat pubTimeX = newsTitleX;
    CGFloat pubTimeY = CGRectGetMaxY(_newsImageFrame) - 3 * kHomeViewNewsCellMargin;
    NSString *punTime = [NSString stringWithFormat:@"%ld---", homeViewNews.pubTime];
    NSDictionary *pubTimeAttrs = @{NSFontAttributeName : kHomeViewNewsCategoryFont};
    CGSize pubTimeSize = [punTime sizeWithAttributes:pubTimeAttrs];
    if (homeViewNews.pubTime) {
        _pubTimeLabelFrame = (CGRect){{pubTimeX, pubTimeY}, pubTimeSize};
    }
    
    /** 新闻评论(image) */
    CGFloat commentViewX = CGRectGetMaxX(_pubTimeLabelFrame);
    CGFloat commentViewH = 11.0;
    CGFloat commentViewY = pubTimeY + commentViewH / 2.7;
    CGFloat commentViewW = 11.0;
    if (homeViewNews.pubTime) {
        if (ScreenWidth == ScreenWidth5S) {
            _commentViewFrame = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
        } else if (ScreenWidth == ScreenWidth6) {
            _commentViewFrame = CGRectMake(commentViewX + 3 * kHomeViewNewsCellMargin, commentViewY, commentViewW, commentViewH);
        } else if (ScreenWidth == ScreenWidth6plus) {
            _commentViewFrame = CGRectMake(commentViewX + 5 * kHomeViewNewsCellMargin, commentViewY, commentViewW, commentViewH);
        }
    } else {
        if (ScreenWidth == ScreenWidth5S) {
            commentViewX = CGRectGetMaxX(_newsImageFrame) + 2 * kHomeViewNewsCellMargin;
            commentViewY = CGRectGetMaxY(_newsImageFrame) - 2.7 * kHomeViewNewsCellMargin;
            _commentViewFrame = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
        } else if (ScreenWidth == ScreenWidth6) {
            commentViewX = CGRectGetMaxX(_newsImageFrame) + 5 * kHomeViewNewsCellMargin;
            commentViewY = CGRectGetMaxY(_newsImageFrame) - 2.7 * kHomeViewNewsCellMargin;
            _commentViewFrame = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
        } else if (ScreenWidth == ScreenWidth6plus) {
            commentViewX = CGRectGetMaxX(_newsImageFrame) + 7 * kHomeViewNewsCellMargin;
            commentViewY = CGRectGetMaxY(_newsImageFrame) - 2.7 * kHomeViewNewsCellMargin;
            _commentViewFrame = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
        }
    }
    
    /** 新闻评论 */
    CGFloat commentX = CGRectGetMaxX(_commentViewFrame) + kHomeViewNewsCellMargin;
    CGFloat commentY = pubTimeY;;
    NSDictionary *commentAttrs = @{NSFontAttributeName : kHomeViewNewsCommentFont};
    NSString *comment = [NSString stringWithFormat:@"%ld", homeViewNews.commentCount];
    CGSize commentSize = [comment sizeWithAttributes:commentAttrs];
    if (homeViewNews.commentCount) {
        _commentFrame = CGRectMake(commentX, commentY, commentSize.width, pubTimeSize.height);
    }
    
    /** 新闻类别 */
    CGFloat categotyX = 0.0;
    if (ScreenWidth == ScreenWidth5S) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 3;
    } else if (ScreenWidth == ScreenWidth6) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 7;
    } else if (ScreenWidth == ScreenWidth6plus) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 11;
    }
    CGFloat categotyY = commentY;
    NSDictionary *categotyAttrs = @{NSFontAttributeName : kHomeViewNewsCategoryFont};
    CGSize categotySize = [homeViewNews.newsCategory sizeWithAttributes:categotyAttrs];
    if (![homeViewNews.newsCreateTime isEqualToString:@""]) {
        _categotyFrame = (CGRect){{categotyX, categotyY}, categotySize};
    }
    
    /** 分割线 */
    CGFloat separatorViewFrameX = homeViewNewsViewX - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_categotyFrame) + kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameW = homeViewNewsViewW - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameH = 1.0;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /** 父视图的高度 */
    homeViewNewsViewH = CGRectGetMaxY(_separatorViewFrame);
    _homeViewNewsViewFrame = CGRectMake(homeViewNewsViewX, homeViewNewsViewY, homeViewNewsViewW, homeViewNewsViewH);
    
    /** cell的高度 */
    _cellHeight = CGRectGetMaxY(_homeViewNewsViewFrame) + kHomeViewNewsCellMargin;
}

@end
