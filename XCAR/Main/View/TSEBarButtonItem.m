//
//  TSEBarButtonItem.m
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEBarButtonItem.h"

#import "Public.h"

#define TSEBarButtonButtonImageRatio 0.9

@interface TSEBarButton : UIButton

@end

@implementation TSEBarButton

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleW = contentRect.size.width + 30;
    CGFloat titleH = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleY = 0.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

@interface TSEBarButtonItem ()

@end

@implementation TSEBarButtonItem

+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action {
    TSEBarButton *barButton = [[TSEBarButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:TSEColor(81, 165, 192) forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:imageName]
               forState:UIControlStateNormal];
    barButton.bounds = (CGRect){CGPointZero, barButton.currentImage.size};
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *barButton = [[UIButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:TSEColor(81, 165, 192) forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    barButton.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

@end
