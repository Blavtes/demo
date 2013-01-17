//
//  LimitFreeCell.h
//  IAppFree
//
//  Created by yangyong on 12-11-22.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
//@class EGOImageView;
@interface LimitFreeCell : UITableViewCell
{
    UIImageView *iconImage;
//    EGOImageView *iconImage;
    UILabel *name;
    UILabel *lastTime;
    UIImageView *bgImageView;
    UIImageView *fgImageView;
    UILabel *price;
    UIView *priceImage;
    UILabel *classify;
    UILabel *comment;

    float _rating;
    
}

@property (nonatomic,retain) UILabel *comment;
@property (nonatomic,retain) UILabel *classify;
@property (nonatomic,retain) UIImageView *iconImage;
@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *lastTime;
@property (nonatomic,retain) UIImageView *bgImageView;
@property (nonatomic,retain) UIImageView *fgImageView;
@property (nonatomic,retain) UILabel *price;
@property (nonatomic,retain) UIView *priceImage;
@property (nonatomic,assign) float rating;

- (void)setFlickrPhoto:(NSString*)flickrPhoto;
@end
