//
//  LimitFreeCell.m
//  IAppFree
//
//  Created by yangyong on 12-11-22.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "LimitFreeCell.h"
//#import "EGOImageView.h"
#import <QuartzCore/QuartzCore.h>
#define kAppListTableViewCellHeight 171.0/2

#define kAppIconSize CGSizeMake(64,64)
@implementation LimitFreeCell
@synthesize iconImage,bgImageView,fgImageView,lastTime,price,priceImage,name,rating = _rating,classify,comment;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"set...");
        self.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0  blue:233.0/255.0  alpha:1];
        UIImageView *ivSelectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appproduct_loadingviewcell_light_2.png"]];
        ivSelectedBackgroundView.frame = CGRectMake(0, 0, 320, 80);
        [self setSelectedBackgroundView:ivSelectedBackgroundView];
        iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appproduct_appdefault.png"]];
        

        
        iconImage.frame = (CGRect){12,23.0/2,kAppIconSize};
        CALayer * layer = [iconImage layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:10.0];
        [self addSubview:iconImage];
        [iconImage release];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(12 + 64 + 11, 10, 205, 35.0/2)];
        name.font = [UIFont boldSystemFontOfSize:15.0];

        name.textColor = [UIColor colorWithRed:.0/255.0 green:.0/255.0 blue:.0/255.0 alpha:1.0];
        name.shadowOffset = CGSizeMake(0, 0);
        name.shadowColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        name.backgroundColor = [UIColor clearColor];
        name.highlightedTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];

        [self addSubview:name];
        [name release];
        
        lastTime = [[UILabel alloc] initWithFrame:CGRectMake(12 + 64 + 55.0/2 , 13 + 6 + 15, 231.0/2, 15)];
        
        lastTime.backgroundColor = [UIColor clearColor];

        lastTime.textColor = [UIColor colorWithRed: 100.0/255.0f green: 100.0/255.0f blue: 100.0/255.0f alpha: 1.0];


        lastTime.font = [UIFont boldSystemFontOfSize:14.0];

        [self addSubview:lastTime];
       
        priceImage = [[UIView alloc] initWithFrame:CGRectMake( 64 + 55.0/2 + 231.0/2 +12  + 20, 13 + 6 + 15 - 4 + 12, 40, 1)];
       

        priceImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_line.png"]];
         [self addSubview:priceImage];
        [priceImage release];
        price = [[UILabel alloc] initWithFrame:CGRectMake(8 + 64 + 55.0/2 + 231.0/2 +8 + 20, 13 + 6 + 15, 59, 15)];
        price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont boldSystemFontOfSize:11.0];
        price.textColor = [UIColor colorWithRed: 85.0/255.0f green: 85.0/255.0f blue: 85.0/255.0f alpha: 1.0];

        [self addSubview:price];
        bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stdar_none.png"]];
        bgImageView.frame = CGRectMake(12 + 64 + 55.0/2,13 + 6 + 30 + 6 ,52,15 );
        NSLog(@"x %f y %f w %d h %d",kAppIconSize.width + 11, lastTime.frame.size.height + 4, 82,23);
        bgImageView.clipsToBounds = YES;
        [self addSubview:bgImageView];

        fgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stdar_full.png"]];
        fgImageView.frame = CGRectMake(12 + 64 + 55.0/2,13 + 6 + 30 + 6,52,15 );
        fgImageView.clipsToBounds = YES;
        [self addSubview:fgImageView];

        classify = [[UILabel alloc] initWithFrame:CGRectMake(12 + 64 + 55.0/2 + 231.0/2 +8 + 15 + 4, 13 + 6 + 30 + 6, 59, 15)];
        classify.backgroundColor = [UIColor clearColor];
        classify.font = [UIFont boldSystemFontOfSize:11.0f];
        classify.textColor = [UIColor colorWithRed: 144.0/255.0f green: 143.0/255.0f  blue: 143.0/255.0f  alpha: 1.0];
        [self addSubview:classify];

        UIImageView *imagerowview = [[UIImageView alloc] initWithFrame:CGRectMake(12 + 64 + 55.0/2 + 103.0 +3 + 35./2 +59 +9, 13 + 15 + 6, 17,15)];
        imagerowview.image = [UIImage imageNamed:@"srrow.png"];
        [self addSubview:imagerowview];
        [imagerowview release];
        
        comment = [[UILabel alloc] initWithFrame:CGRectMake(12 + 64 + 55.0/2 + 103.0/2 + 3,13 + 6 + 30 + 6 ,103.0/2,15 )];
        comment.backgroundColor = [UIColor clearColor];
        comment.font = [UIFont boldSystemFontOfSize:11.0f];
        comment.textColor = [UIColor colorWithRed: 187.0/255.0f green: 187.0/255.0f  blue: 187.0/255.0f  alpha: 1.0];
        [self addSubview:comment];
        
         [lastTime release];
        [fgImageView release];
        [bgImageView release];
        [classify release];
        [comment release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (float) rating
{
    return _rating;
}
- (void) setRating:(float)rating
{
    _rating = rating;
    CGFloat newWidth = bgImageView.frame.size.width*rating/5.0f;
    CGRect rect = CGRectMake(12 + 64 + 55.0/2,13 + 6 + 30 + 6 , newWidth, bgImageView.frame.size.height);
    fgImageView.frame = rect;
    NSLog( @"rating is %f ,%@",rating,NSStringFromCGRect(rect));
    fgImageView.clipsToBounds = YES;
    [fgImageView setContentMode:UIViewContentModeTopLeft];
}
- (void) dealloc
{
    [iconImage release];
    [bgImageView release];
    [fgImageView release];
    [lastTime release];
    [price release];
    [name release];
    [priceImage release];
    [classify release];
    [super dealloc];
}
@end
