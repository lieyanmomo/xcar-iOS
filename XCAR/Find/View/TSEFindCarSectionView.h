//
//  TSEFindCarSectionView.h
//  XCAR
//
//  Created by Morris on 10/7/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEFindCarSectionView : UIView

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, copy) NSString *sectionTitles;

- (instancetype)initWithSectionTitles:(NSString *)sectionTitles;

@end
