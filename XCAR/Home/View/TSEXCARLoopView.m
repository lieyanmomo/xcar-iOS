//
//  TSELatestNewsLoopView.m
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEXCARLoopView.h"

#import "Public.h"

#define kPageH 20

@interface TSEXCARLoopView() <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *currentImages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *placeHodlerView;

@end

@implementation TSEXCARLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:[UIImage imageNamed:@"zhanwei2_1"]];
        [self addSubview:imageView];
        self.placeHodlerView = imageView;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval {
    self = [super initWithFrame:frame];
    if (self) {
        _autoPlay = isAuto;
        _timeInterval = timeInterval;
        _images = images;
        _currentPage = 0;
        
        [self addScrollView];
        [self addPageControl];
        if (_autoPlay == YES) {
            [self toPlay];
        }
    }
    return self;
}

- (void)setLoopViewImages:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval {
    _autoPlay = isAuto;
    _timeInterval = timeInterval;
    _images = images;
    _currentPage = 0;
    
    [self addScrollView];
    [self addPageControl];
    
    if (self.autoPlay == YES) {
        [self toPlay];
    }
}

#pragma mark - Public Methods
- (void)addPageControl {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height-kPageH, width, kPageH)];
    bgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.2];
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(bgView.frame.origin.x, 0, width / 3, kPageH)];
    pageControl.numberOfPages = self.images.count;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    [pageControl setCurrentPageIndicatorTintColor:TSEColor(39, 178, 228)];
    self.pageControl = pageControl;
    [bgView addSubview:self.pageControl];
    [self addSubview:bgView];
}

#pragma mark - Private Methods
- (void)toPlay{
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

- (void)autoPlayToNextPage {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoPlayToNextPage) object:nil];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

- (NSMutableArray *)currentImages {
    if (_currentImages == nil) {
        _currentImages = [[NSMutableArray alloc] init];
    }
    [_currentImages removeAllObjects];
    NSInteger count = self.images.count;
    int i = (int)(_currentPage + count - 1)%count;
    [_currentImages addObject:self.images[i]];
    [_currentImages addObject:self.images[_currentPage]];
    i = (int)(_currentPage + 1)%count;
    [_currentImages addObject:self.images[i]];
    return _currentImages;
}

- (void)addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
//        imageView.image = [UIImage imageNamed:self.currentImages[i]];
        imageView.image = self.currentImages[i];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(3*width, height);
    scrollView.contentOffset = CGPointMake(width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    [scrollView addGestureRecognizer:tap];
    
    [self addSubview:scrollView];
    _scrollView = scrollView;
}
- (void)refreshImages {
    [self.placeHodlerView removeFromSuperview];
    NSArray *subViews = self.scrollView.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIImageView *imageView = (UIImageView *)subViews[i];
//        imageView.image = [UIImage imageNamed:self.currentImages[i]];
        imageView.image = [UIImage imageNamed:@"zhanwei2_1"];
        imageView.image = self.currentImages[i];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}
#pragma mark - delegate
- (void)singleTapped:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(loopViewDidSelectedImage:index:)]) {
        [self.delegate loopViewDidSelectedImage:self index:_currentPage];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = self.frame.size.width;
    if (x >= 2 * width) {
        _currentPage = (++_currentPage) % self.images.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
    if (x <= 0) {
        _currentPage = (int)(_currentPage + self.images.count - 1)%self.images.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}

@end


