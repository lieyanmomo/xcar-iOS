//
//  TSEProfileHeaderView.m
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import "TSEProfileHeaderView.h"
#import "TSEProfileCollectionCell.h"

#import "Public.h"

#define kProfileUIGap 6

@interface TSEProfileHeaderView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TSEProfileHeaderView

static NSString *const CollectionViewCellIdentifier = @"CollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 设置背景图片
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setUserInteractionEnabled:YES];
        UIImage *backgroundImage = [UIImage imageNamed:@"bg"];
        [imageView setImage:backgroundImage];
        
        // 设置按钮
        UIButton *settingBtn = [[UIButton alloc] init];
        [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [settingBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [settingBtn addTarget:self action:@selector(settingBtnClicked) forControlEvents:UIControlEventTouchDown];
        CGFloat settingBtnY = 20.0f;
        CGFloat settingBtnW = 40.0f;
        CGFloat settingBtnH = 40.0f;
        CGFloat settingBtnX = ScreenWidth - settingBtnW - 10;
        [settingBtn setFrame:CGRectMake(settingBtnX, settingBtnY, settingBtnW, settingBtnH)];
        [imageView addSubview:settingBtn];
        
        // 头像
        UIImageView *avatarView = [[UIImageView alloc] init];
        UIImage *avatarPlaceHolder = [UIImage imageNamed:@"man"];
        [avatarView setImage:avatarPlaceHolder];
        [avatarView setUserInteractionEnabled:YES];
        CGFloat avatarViewX = 30.0f;
        CGFloat avatarViewY = CGRectGetMaxY(settingBtn.frame) + 10;
        CGFloat avatarViewW = 65.0f;
        CGFloat avatarViewH = 65.0f;
        [avatarView setFrame:CGRectMake(avatarViewX, avatarViewY, avatarViewW, avatarViewH)];
        [imageView addSubview:avatarView];
        
        //
        UIButton *containBtn = [[UIButton alloc] init];
        [containBtn setBackgroundColor:[UIColor clearColor]];
        [containBtn addTarget:self action:@selector(clickToSetPersonalInfo) forControlEvents:UIControlEventTouchDown];
        CGFloat containBtnX = CGRectGetMaxX(avatarView.frame) + 12;
        CGFloat containBtnY = avatarViewY;
        CGFloat containBtnW = ScreenWidth - avatarViewW;
        CGFloat containBtnH = avatarViewH;
        [containBtn setFrame:CGRectMake(containBtnX, containBtnY, containBtnW, containBtnH)];
        [imageView addSubview:containBtn];
        
        // 用户名
        UILabel *userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:@"Samtse"];
        [userNameLabel setFont:[UIFont systemFontOfSize:19]];
        [userNameLabel setTextColor:[UIColor whiteColor]];
        CGFloat userNameX = 0;
        CGFloat userNameY = 0;
        NSDictionary *userNameAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:19]};
        CGSize userNameSize = [userNameLabel.text sizeWithAttributes:userNameAttrs];
        [userNameLabel setFrame:CGRectMake(userNameX, userNameY, userNameSize.width, userNameSize.height)];
        [containBtn addSubview:userNameLabel];
        
        // 男/女
        UIImageView *genderView = [[UIImageView alloc] init];
        [genderView setImage:[UIImage imageNamed:@"nan"]];
        CGFloat genderX = CGRectGetMaxX(userNameLabel.frame) + 3.0f;
        CGFloat genderY = userNameY + 3;
        CGFloat genderW = 18.0f;
        CGFloat genderH = 18.0f;
        [genderView setFrame:CGRectMake(genderX, genderY, genderW, genderH)];
        [containBtn addSubview:genderView];
        
        // 爱卡币
        UILabel *moneyLabel = [[UILabel alloc] init];
        [moneyLabel setText:@"爱卡币：66"];
        [moneyLabel setFont:[UIFont systemFontOfSize:15]];
        [moneyLabel setTextColor:[UIColor whiteColor]];
        CGFloat moneyX = userNameX;
        CGFloat moneyY = CGRectGetMaxY(genderView.frame) + 3.0f;
        NSDictionary *moneyAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGSize moneySize = [moneyLabel.text sizeWithAttributes:moneyAttrs];
        [moneyLabel setFrame:CGRectMake(moneyX, moneyY, moneySize.width, moneySize.height)];
        [containBtn addSubview:moneyLabel];
        
        // 提示
        UIImageView *accessoryView = [[UIImageView alloc] init];
        [accessoryView setImage:[UIImage imageNamed:@"baijiantou"]];
        [accessoryView setUserInteractionEnabled:YES];
        [accessoryView setFrame:CGRectMake(3 * moneySize.width, moneyY, 12.0f, 21.0f)];
        [containBtn addSubview:accessoryView];
        
        // 等级
        UILabel *levelLabel = [[UILabel alloc] init];
        [levelLabel setText:@"新手上路"];
        [levelLabel setFont:[UIFont systemFontOfSize:17]];
        [levelLabel setTextColor:[UIColor whiteColor]];
        CGFloat levelX = moneyX;
        CGFloat levelY = CGRectGetMaxY(moneyLabel.frame) + 3.0f;
        NSDictionary *levelAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGSize levelSize = [moneyLabel.text sizeWithAttributes:levelAttrs];
        [levelLabel setFrame:CGRectMake(levelX, levelY, levelSize.width, levelSize.height)];
        [containBtn addSubview:levelLabel];
        
        // 等级图片
        UIImageView *levelView = [[UIImageView alloc] init];
        [levelView setImage:[UIImage imageNamed:@"xing"]];
        CGFloat levelViewX = CGRectGetMaxX(levelLabel.frame);
        CGFloat levelViewY = levelY + 2.0f;
        CGFloat levelViewW = 18.0f;
        CGFloat levelViewH = 18.0f;
        [levelView setFrame:CGRectMake(levelViewX, levelViewY, levelViewW, levelViewH)];
        [containBtn addSubview:levelView];
        
        // 帖子
        UIButton *tieziBtn = [[UIButton alloc] init];
        [tieziBtn setBackgroundColor:TSEAColor(160, 160, 160, 0.3)];
        [tieziBtn addTarget:self action:@selector(tieziBtnCLicked) forControlEvents:UIControlEventTouchDown];
        [tieziBtn setFrame:CGRectMake(0.0, CGRectGetMaxY(avatarView.frame) + 20, ScreenWidth / 3, 50.0f)];
        [imageView addSubview:tieziBtn];
        
        UILabel *tieziNumLabel = [[UILabel alloc] init];
        [tieziNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [tieziNumLabel setFont:[UIFont systemFontOfSize:18]];
        [tieziNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *tieziNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize tieziNumSize = [tieziNumLabel.text sizeWithAttributes:tieziNumAttrs];
        [tieziNumLabel setFrame:CGRectMake(tieziBtn.frame.size.width / 2 - tieziNumSize.width / 2, tieziBtn.frame.size.height / 2 - tieziNumSize.height, tieziNumSize.width, tieziNumSize.height)];
        [tieziBtn addSubview:tieziNumLabel];
        
        
        UILabel *tieziLabel = [[UILabel alloc] init];
        [tieziLabel setText:@"帖子"];
        [tieziLabel setFont:[UIFont systemFontOfSize:18]];
        [tieziLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *tieziAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize tieziSize = [tieziLabel.text sizeWithAttributes:tieziAttrs];
        [tieziLabel setFrame:CGRectMake(tieziBtn.frame.size.width / 2 - tieziSize.width / 2, tieziBtn.frame.size.height * 2 / 3 - tieziSize.height / 2, tieziSize.width, tieziSize.height)];
        [tieziBtn addSubview:tieziLabel];
        
        // 粉丝
        UIButton *followerBtn = [[UIButton alloc] init];
        [followerBtn setBackgroundColor:TSEAColor(160, 160, 160, 0.3)];
        [followerBtn addTarget:self action:@selector(followerBtnCLicked) forControlEvents:UIControlEventTouchDown];
        [followerBtn setFrame:CGRectMake(tieziBtn.frame.size.width, CGRectGetMaxY(avatarView.frame) + 20, ScreenWidth / 3, 50.0f)];
        [imageView addSubview:followerBtn];
        
        UILabel *follerNumLabel = [[UILabel alloc] init];
        [follerNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [follerNumLabel setFont:[UIFont systemFontOfSize:18]];
        [follerNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *follerNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize follerNumSize = [follerNumLabel.text sizeWithAttributes:follerNumAttrs];
        [follerNumLabel setFrame:CGRectMake(followerBtn.frame.size.width / 2 - follerNumSize.width / 2, followerBtn.frame.size.height / 2 - follerNumSize.height, follerNumSize.width, follerNumSize.height)];
        [followerBtn addSubview:follerNumLabel];
        
        
        UILabel *follerLabel = [[UILabel alloc] init];
        [follerLabel setText:@"粉丝"];
        [follerLabel setFont:[UIFont systemFontOfSize:18]];
        [follerLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *follerAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize follerSize = [tieziLabel.text sizeWithAttributes:follerAttrs];
        [follerLabel setFrame:CGRectMake(followerBtn.frame.size.width / 2 - follerSize.width / 2, followerBtn.frame.size.height * 2 / 3 - follerSize.height / 2, follerSize.width, follerSize.height)];
        [followerBtn addSubview:follerLabel];
        
        // 关注
        UIButton *gzBtn = [[UIButton alloc] init];
        [gzBtn setBackgroundColor:TSEAColor(160, 160, 160, 0.3)];
        [gzBtn addTarget:self action:@selector(followingBtnCLicked) forControlEvents:UIControlEventTouchDown];
        [gzBtn setFrame:CGRectMake(CGRectGetMaxX(followerBtn.frame), CGRectGetMaxY(avatarView.frame) + 20, ScreenWidth / 3, 50.0f)];
        [imageView addSubview:gzBtn];
        
        UILabel *gzNumLabel = [[UILabel alloc] init];
        [gzNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [gzNumLabel setFont:[UIFont systemFontOfSize:18]];
        [gzNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *gzNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize gzNumSize = [follerNumLabel.text sizeWithAttributes:gzNumAttrs];
        [gzNumLabel setFrame:CGRectMake(gzBtn.frame.size.width / 2 - gzNumSize.width / 2, gzBtn.frame.size.height / 2 - gzNumSize.height, gzNumSize.width, gzNumSize.height)];
        [gzBtn addSubview:gzNumLabel];
        
        
        UILabel *gzLabel = [[UILabel alloc] init];
        [gzLabel setText:@"关注"];
        [gzLabel setFont:[UIFont systemFontOfSize:18]];
        [gzLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *gzAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize gzSize = [tieziLabel.text sizeWithAttributes:gzAttrs];
        [gzLabel setFrame:CGRectMake(gzBtn.frame.size.width / 2 - gzSize.width / 2, gzBtn.frame.size.height * 2 / 3 - gzSize.height / 2, gzSize.width, gzSize.height)];
        [gzBtn addSubview:gzLabel];
        
        // 彩色带
        UIImageView *colorView = [[UIImageView alloc] init];
        [colorView setImage:[UIImage imageNamed:@"qiandaotishi"]];
        [colorView setFrame:CGRectMake(0.0, CGRectGetMaxY(gzBtn.frame), ScreenWidth, 5.0f)];
        [imageView addSubview:colorView];
        
        // collection view
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(ScreenWidth / 4, 100.0)];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(colorView.frame), ScreenWidth, 200.0) collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView setBackgroundColor:TSEColor(248, 248, 248)];
        [collectionView registerClass:[TSEProfileCollectionCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        [imageView addSubview:collectionView];
        
        _viewHeight = CGRectGetMaxY(collectionView.frame);
        [imageView setFrame:CGRectMake(0.0, 0.0, ScreenWidth, _viewHeight)];
        [self addSubview:imageView];
    }
    return self;
}

#pragma mark - Collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSEProfileCollectionCell *cell = (TSEProfileCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setInfoLabelTextWithTag:indexPath.item];
    [cell setPicViewImageWithTag:indexPath.item];
    
    if (indexPath.item == 6) {
        [cell setBackgroundColor:TSEColor(253, 179, 44)];
    }
    
    return cell;
}

#pragma mark - Collection View delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TSELog(@"collection view selected index%ld", indexPath.item);
}

/**
 *  设置按钮事件
 */
- (void)settingBtnClicked {
    TSELog(@"settingBtnClicked");
}

- (void)clickToSetPersonalInfo {
    TSELog(@"clickToSetPersonalInfo");
}

- (void)tieziBtnCLicked {
    TSELog(@"tieziBtnCLicked");
}

- (void)followerBtnCLicked {
    TSELog(@"followerBtnCLicked");
}

- (void)followingBtnCLicked {
    TSELog(@"followingBtnCLicked");
}

@end
