//
//  TSEBarButtonItem.h
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSEBarButtonItem : UIBarButtonItem

+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
