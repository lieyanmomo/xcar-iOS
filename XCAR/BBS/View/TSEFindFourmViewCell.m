//
//  TSEFindFourmViewCell.m
//  XCAR
//
//  Created by Morris on 10/4/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEFindFourmViewCell.h"
#import "Public.h"

@interface TSEFindFourmViewCell ()

@property (nonatomic, strong) NSMutableDictionary *forumTitles;

@end

@implementation TSEFindFourmViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setBorderWidth:0.3f];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.layer setCornerRadius:5.0];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setInfoLabelTextWithTag:(NSInteger)tag {
    [self.forumTitles enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        key = [NSNumber numberWithInteger:tag];
        self.infoLabel = [[UILabel alloc] init];
        [self.infoLabel setText:self.forumTitles[key]];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]};
        CGSize size = [_infoLabel.text sizeWithAttributes:attrs];
        CGFloat x = self.frame.size.width / 2 - size.width / 2;
        CGFloat y = self.frame.size.height / 2 - size.height / 2;
        CGFloat w = size.width;
        CGFloat h = size.height;
        [_infoLabel setFrame:CGRectMake(x, y, w, h)];
        [_infoLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_infoLabel setTextColor:TSEColor(160, 166, 174)];
        [self.contentView addSubview:_infoLabel];
    }];
}

- (NSMutableDictionary *)forumTitles {
    if (!_forumTitles) {
        _forumTitles = [NSMutableDictionary dictionary];
        [_forumTitles setObject:@"北京论坛" forKey:@0];
        [_forumTitles setObject:@"四川论坛" forKey:@1];
        [_forumTitles setObject:@"上海论坛" forKey:@2];
        [_forumTitles setObject:@"深圳论坛" forKey:@3];
        [_forumTitles setObject:@"速腾论坛" forKey:@4];
        [_forumTitles setObject:@"明锐论坛" forKey:@5];
        [_forumTitles setObject:@"卡罗拉论坛" forKey:@6];
        [_forumTitles setObject:@"爱卡自助游论坛" forKey:@7];
        [_forumTitles setObject:@"妞开妞车论坛" forKey:@8];
        [_forumTitles setObject:@"二手车市场论坛" forKey:@9];
    }
    return _forumTitles;
}

@end
