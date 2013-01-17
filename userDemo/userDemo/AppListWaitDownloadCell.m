//
//  AppListWaitDownloadCell.m
//  userDemo
//
//  Created by yangyong on 12-12-31.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "AppListWaitDownloadCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation AppListWaitDownloadCell
@synthesize iconImage,nameLabel,imageFree,des;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        CALayer *layer = [iconImage layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 10.0;
        [self addSubview:iconImage];
        nameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, 200, 20)];
        nameLabel.font = [UIFont systemFontOfSize:12.0];
        nameLabel.textColor = [UIColor colorWithRed:22.0/255.0 green:22.0/255.0 blue:22.0/255.0 alpha:1];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        des  = [[UILabel alloc] initWithFrame:CGRectMake(60, 26, 200, 32)];
        des.font = [UIFont systemFontOfSize:10.0];
        des.numberOfLines = 0;
        des.backgroundColor = [UIColor clearColor];
        des.textColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1];
        [self addSubview:des];
        imageFree = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 30, 30)];
        imageFree.image = [UIImage imageNamed:@"right.png"];
        [self addSubview:imageFree];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) dealloc
{
    self.iconImage = nil;
    [iconImage release];
    self.nameLabel = nil;
    [nameLabel release];
    self.des = nil;
    [des release];
    self.imageFree = nil;
    [imageFree release];
    [super dealloc];
}
@end
