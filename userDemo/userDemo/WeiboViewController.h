//
//  WeiboViewController.h
//  userDemo
//
//  Created by yangyong on 12-12-28.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDNavigationBar;


#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
@interface WeiboViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
     CDNavigationBar *_nbNavigationBar;
    UITableView *myTable;
    NSArray *array;
    NSMutableArray *favArray;

    NSDictionary *userInfo;
    NSArray *statuses;
}

@property (nonatomic, retain) NSMutableArray *favArray;
@property (nonatomic, retain) UITableView *myTable;
@property (nonatomic, retain) CDNavigationBar *nbNavigationBar;
@end
