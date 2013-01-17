//
//  AppDelegate.h
//  userDemo
//
//  Created by yangyong on 12-12-21.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "DeviceSender.h"
#import "RootViewController.h"
#import "SinaWeibo.h"
#define kAppKey             @"3177863434"
#define kAppSecret          @"3756948eaed3a355c8f726ce5d476b51"
#define kAppRedirectURI     @"http://techweb.com.cn"
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,DeviceSenderDelegate>
{
    SinaWeibo *_sinaWeiBo;
    
    RootViewController *rot;
}
@property (nonatomic,retain) RootViewController *rot;
@property (readonly, nonatomic) SinaWeibo *sinaWeiBo;

@property (strong, nonatomic) UIWindow *window;

@end
