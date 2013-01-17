//
//  UICustomBarButtonItem.h
//  IAppfree
//
//  Created by Qingshancai on 4/20/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIBarButtonItemStyleBackEx     = -1, 
    UIBarButtonItemStyleEditEx     = -2,
    UIBarButtonItemStyleActionEx   = -3
} UIBarButtonItemStyleEx;

@interface UIBarButtonItem (CustomImage)

- (id)initWithTitleEx:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;

@end
