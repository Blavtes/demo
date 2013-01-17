//
//  AppListWaitDownloadCell.h
//  userDemo
//
//  Created by yangyong on 12-12-31.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListWaitDownloadCell : UITableViewCell
{
    UIImageView *iconImage;
    UILabel *nameLabel;
    UILabel *des;
    UIImageView *imageFree;
}
@property (nonatomic,retain) UIImageView *iconImage;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *des;
@property (nonatomic,retain) UIImageView *imageFree;
@end
