//
//  RootViewController.h
//  userDemo
//
//  Created by yangyong on 12-12-21.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboViewController;

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <StoreKit/StoreKit.h>

#import "Renren.h"
#import "TencentOAuth.h"

//#define kAppKey             @"3177863434"
//#define kAppSecret          @"3756948eaed3a355c8f726ce5d476b51"
//#define kAppRedirectURI     @"http://techweb.com.cn"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "TCWBEngine.h"
@class SinaWeibo;
@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIApplicationDelegate,UIActionSheetDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,SKStoreProductViewControllerDelegate,RenrenDelegate,TencentSessionDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    UITableView *myTable;
    NSMutableArray *dataArray;
    NSArray *array;
    NSMutableArray *urlArray;
    NSMutableArray *canArray;

    UIScrollView *recommendthumbscrollview;
    WeiboViewController *web;
    UIActionSheet *_share;
    
  
     Renren *_renren;
    MFMailComposeViewController* _mfmailcontroller;
//     SinaWeibo *sinaweibo;
     TCWBEngine *_engine;
TencentOAuth *_tencentOAuth;
    
    
 
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
}
@property (nonatomic, retain)TCWBEngine *_engine;
//@property (readonly, nonatomic) SinaWeibo *sinaweibo;

@property (retain,nonatomic)Renren *renren;

@property (nonatomic,retain) NSMutableArray *urlArray;
@property (nonatomic,retain) UIScrollView *recommendthumbscrollview;
@property (nonatomic,retain) NSMutableArray *canArray;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) UITableView *myTable;
@end
