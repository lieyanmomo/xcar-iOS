//
//  TSEProfileCollectionCell.m
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEProfileCollectionCell.h"
#import "Public.h"

@interface TSEProfileCollectionCell ()

@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSMutableDictionary *infoDict;
@property (nonatomic, strong) NSMutableDictionary *picDict;

@end

@implementation TSEProfileCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setBorderWidth:0.3f];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self setBackgroundColor:TSEColor(248, 248, 248)];
        [self setupPicView];
    }
    return self;
}

/**
 *  设置图片
 */
- (void)setupPicView {
    self.picView = [[UIImageView alloc] init];
    [self.picView setUserInteractionEnabled:YES];
    CGFloat x = self.contentView.center.x;
    CGFloat y = self.contentView.center.y - 7.0f;
    [self.picView setCenter:CGPointMake(x, y)];
    [self.picView setBounds:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    [self.contentView addSubview:self.picView];
}

/**
 *  根据cell的tag属性依次设置图片对应的文字
 */
- (void)setInfoLabelTextWithTag:(NSInteger)tag {
    [self.infoDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        self.infoLabel = [[UILabel alloc] init];
        key = [NSNumber numberWithInteger:tag];
        [self.infoLabel setText:self.infoDict[key]];
        
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]};
        CGSize size = [self.infoLabel.text sizeWithAttributes:attrs];
        CGFloat x = self.frame.size.width / 2 - size.width / 2;
        CGFloat y = self.frame.size.height - size.height * 1.8;
        CGFloat w = size.width;
        CGFloat h = size.height;
        
        [self.infoLabel setFrame:CGRectMake(x, y, w, h)];
        [self.infoLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.infoLabel setTextColor:TSEColor(101, 101, 101)];
        [self.contentView addSubview:self.infoLabel];
    }];
}

- (void)setPicViewImageWithTag:(NSInteger)tag {
    [self.picDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        key = [NSNumber numberWithInteger:tag];
        [self.picView setImage:self.picDict[key]];
    }];
}

/**
 *  根据cell的tag属性依次设置图片
 */
#pragma mark - lazy load
- (NSMutableDictionary *)picDict {
    if (!_picDict) {
        _picDict = [NSMutableDictionary dictionary];
    }
    
    for (int i = 0; i < 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"plugin_profile_%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        [_picDict setObject:image forKey:@(i)];
    }
    return _picDict;
}

- (NSMutableDictionary *)infoDict {
    if (!_infoDict) {
        _infoDict = [NSMutableDictionary dictionary];
        [self.infoDict setObject:@"今日推荐" forKey:@0];
        [self.infoDict setObject:@"系统通知" forKey:@1];
        [self.infoDict setObject:@"收到的回复" forKey:@2];
        [self.infoDict setObject:@"私信" forKey:@3];
        [self.infoDict setObject:@"草稿" forKey:@4];
        [self.infoDict setObject:@"我的收藏" forKey:@5];
        [self.infoDict setObject:@"签到" forKey:@6];
        [self.infoDict setObject:@"添加工具" forKey:@7];
    }
    return _infoDict;
}

@end
