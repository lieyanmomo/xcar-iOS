//
//  TSEShareEventSheet.m
//  XCAR
//
//  Created by Morris on 9/22/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEShareEventSheet.h"

#import "Public.h"

#define TSEShareEventSheetMargin 8
#define TSEShareEventButtonImageRatio 0.9

@interface TSEShareEventButton : UIButton

@end

@implementation TSEShareEventButton

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 5.0f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * TSEShareEventButtonImageRatio;
    CGFloat titleY = titleH * TSEShareEventButtonImageRatio;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end

@interface TSEShareEventSheet () <UIGestureRecognizerDelegate>
{
    UIView *mainView;
    NSArray *shareTextArr;
    NSArray *sharePicArr;
    CGRect shareBtnFrame;
}
@end

@implementation TSEShareEventSheet

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = TSEAColor(160, 160, 160, 0);
        
        shareTextArr = @[@"新浪微薄", @"微信好友", @"朋友圈", @"QQ好友", @"QQ空间"];
        sharePicArr = @[@"weibo-1", @"weixin", @"pengyouquan", @"qq-1", @"zone"];
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight / 3)];
        [mainView setBackgroundColor:TSEColor(248, 248, 248)];
        
        UILabel *shareToLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
        [shareToLabel setText:@"分享到:"];
        [shareToLabel setFont:[UIFont systemFontOfSize:16]];
        [shareToLabel setTextColor:TSEColor(44, 59, 55)];
        [mainView addSubview:shareToLabel];
        
        // 添加分享媒体按钮
        for (NSInteger i = 0; i < [shareTextArr count]; i++) {
            TSEShareEventButton *shareBtn = [self addShareButton:shareToLabel.frame index:i];
            shareBtnFrame = shareBtn.frame;
            [mainView addSubview:shareBtn];
        }
        
        // 复制链接按钮
        UIButton *copyBtn = [[UIButton alloc] init];
        [copyBtn setTitleColor:TSEColor(53, 172, 222) forState:UIControlStateNormal];
        [copyBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [copyBtn setTitle:@"复制链接" forState:UIControlStateNormal];
        [copyBtn.layer setBorderWidth:0.7f];
        [copyBtn.layer setBorderColor:TSEColor(234, 234, 234).CGColor];
        [copyBtn addTarget:self action:@selector(copyEventNewsURL) forControlEvents:UIControlEventTouchDown];
        CGFloat copyBtnY = CGRectGetMaxY(shareBtnFrame) + 35;
        [copyBtn setFrame:CGRectMake(0.0f, copyBtnY, ScreenWidth, 44.0f)];
        [mainView addSubview:copyBtn];
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];\
        [cancelBtn setTitleColor:TSEColor(53, 172, 222) forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn.layer setBorderWidth:0.7f];
        [cancelBtn.layer setBorderColor:TSEColor(234, 234, 234).CGColor];
        [cancelBtn addTarget:self action:@selector(clickToDismissShareView) forControlEvents:UIControlEventTouchDown];
        CGFloat cancelBtnY = CGRectGetMaxY(copyBtn.frame);
        [cancelBtn setFrame:CGRectMake(0.0f, cancelBtnY, ScreenWidth, 44.0f)];
        [mainView addSubview:cancelBtn];
        
        [self addSubview:mainView];
        [self showShareEventSheetInView];
    }
    
    return self;
}

/**
 *  添加分享媒体按钮
 *
 *  @param frame 参照控件的frame
 *  @param index 按钮的序号
 *
 *  @return TSEShareEventButton
 */
- (TSEShareEventButton *)addShareButton:(CGRect)frame index:(NSInteger)index {
    UIImage *image = [UIImage imageNamed:sharePicArr[index]];
    NSString *str = shareTextArr[index];
    
    TSEShareEventButton *shareBtn = [[TSEShareEventButton alloc] init];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [shareBtn setTitleColor:TSEColor(150, 151, 156) forState:UIControlStateNormal];
    
    CGFloat shareBtnX = TSEShareEventSheetMargin;
    CGFloat shareBtnY = CGRectGetMaxY(frame) + 5;
    CGFloat shareBtnW = (ScreenWidth - 2 * TSEShareEventSheetMargin) / sharePicArr.count;
    CGFloat shareBtnH = image.size.height;
    [shareBtn setFrame:CGRectMake(shareBtnX + shareBtnW * index + TSEShareEventSheetMargin, shareBtnY, shareBtnW, shareBtnH)];
    
    [shareBtn setTitle:str forState:UIControlStateNormal];
    [shareBtn setImage:image forState:UIControlStateNormal];
    
    return shareBtn;
}

- (void)addCopyButton:(CGRect)frame {
    
}

/**
 *  复制活动网页链接
 */
- (void)copyEventNewsURL {
    TSELog(@"copyEventNewsURL");
}

- (void)clickToDismissShareView {
    [self tappedCancel];
}

/**
 *  展示shareSheet
 */
- (void)showShareEventSheetInView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = TSEAColor(160, 160, 160, .4);
        [UIView animateWithDuration:.25 animations:^{
            [mainView setFrame:CGRectMake(mainView.frame.origin.x, ScreenHeight - mainView.frame.size.height, mainView.frame.size.width, mainView.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

- (void)tappedCancel {
    [UIView animateWithDuration:.25 animations:^{
        [mainView setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

/**
 * 全屏展示
 */
- (void)showInView:(UIViewController *)showVC {
    if(!showVC){
        // 获取当前视图的控制器
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }else{
        [showVC.view addSubview:self];
    }
}

@end
