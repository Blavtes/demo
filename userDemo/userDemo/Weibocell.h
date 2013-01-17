//
//  Weibocell.h
//  userDemo
//
//  Created by yangyong on 12-12-28.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Weibocell : UITableViewCell
{
    UIImageView *imagView;
    UILabel *nameLable;
    UIButton *btn;
}
@property (nonatomic, retain) UIImageView *imagView;
@property (nonatomic, retain) UILabel *nameLable;
@property (nonatomic, retain)  UIButton *btn;
- (void) setImageView:(UIImage*)image;
@end
