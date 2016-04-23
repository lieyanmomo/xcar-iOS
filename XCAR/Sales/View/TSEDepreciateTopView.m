//
//  TSEDepreciateTopView.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEDepreciateTopView.h"

#import "Public.h"

#define TSETopViewButtonImageRatio 0.3

@interface TSETopViewButton : UIButton
{
    CGFloat imageX;
    CGFloat imageY;
    CGFloat imageW;
    CGFloat imageH;
    
    CGFloat titleX;
    CGFloat titleY;
    CGFloat titleW;
    CGFloat titleH;
}

@end

@implementation TSETopViewButton

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self.layer setBorderColor:TSEColor(248, 248, 248).CGColor];
    }
    return self;
}

/**
 *  设置图片在button中的layout
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    imageX = titleX + titleW + 3;
    imageH = 6;
    imageY = titleH / 2 - imageH / 2;
    imageW = 10;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    titleX = contentRect.size.width / 3;
    titleW = 30;
    titleH = contentRect.size.height;
    titleY = 0.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

#define kTopViewTextFont [UIFont systemFontOfSize:14.0]
#define kButtonWidth (ScreenWidth / 3)
#define kBUttonHeight 40.0

@interface TSEDepreciateTopView ()

@property (nonatomic, strong) UIButton *arrowBtn;

@end

@implementation TSEDepreciateTopView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.layer setBorderWidth:0.4];
        [self.layer setBorderColor:TSEColor(223, 223, 223).CGColor];
        [self setupTopView];
    }
    return self;
}

- (void)setupTopView {
    NSArray *titles = @[@"深圳", @"品牌", @"排序"];
    for (NSInteger i = 0 ; i < [titles count]; i++) {
        UIView *view = [self setupTopViewFrameWithTitle:titles[i] point:i];
        [self addSubview:view];
    }
}

- (TSETopViewButton *)setupTopViewFrameWithTitle:(NSString *)title point:(NSInteger)point {
    
    TSETopViewButton *view = [[TSETopViewButton alloc] init];
    [view setFrame:CGRectMake(kButtonWidth * point, 0.0, kButtonWidth, kBUttonHeight)];
    [view.titleLabel setFont:kTopViewTextFont];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:TSEColor(45, 50, 55) forState:UIControlStateNormal];
    [view setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
    [view setImage:[UIImage imageNamed:@"lansanjiao"] forState:UIControlStateSelected];
    view.tag = point;
    
    if (view.tag == 0) {
        [view addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchDown];
    } else if (view.tag == 1) {
        [view addTarget:self action:@selector(selectSeries) forControlEvents:UIControlEventTouchDown];
    } else {
        [view addTarget:self action:@selector(selectSort) forControlEvents:UIControlEventTouchDown];
    }
    
    return view;
}

- (void)selectCity {
    TSELog(@"city taped");
}

- (void)selectSeries {
    TSELog(@"Series taped");
}

- (void)selectSort {
    TSELog(@"Sort taped");
}

@end
