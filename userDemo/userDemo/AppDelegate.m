//
//  AppDelegate.m
//  userDemo
//
//  Created by yangyong on 12-12-21.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "WXApi.h"
#import "DeviceSender.h"
#import "SinaWeibo.h"
@implementation AppDelegate
@synthesize sinaWeiBo = _sinaWeiBo;

#define alert_tag_push 10
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    self.rot = [[RootViewController alloc] initWithNibName:nil bundle:nil];

    
   
    [self.window setRootViewController:self.rot];
    
  
     [WXApi registerApp: @"wxbc8162785a65c154"];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    _sinaWeiBo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:rot];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] &&
        [sinaweiboInfo objectForKey:@"UserIDKey"]) {
        _sinaWeiBo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeiBo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeiBo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }    /** 注册推送通知功能, */
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    //判断程序是不是由推送服务完成的                                                                                                                                                                
    if (launchOptions) {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送通知"
                                                           message:@"这是通过推送窗口启动的程序，你可以在这里处理推送内容"
                                                          delegate:nil
                                                 cancelButtonTitle:@"知道了"
                                                 otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
     NSLog(@"[self.sinaweibo handleOpenURL:url] ;");
    [self.sinaWeiBo applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [self.sinaweibo handleOpenURL:url];
//}
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    NSLog(@"handleOpenURLhandleOpenURLhandleOpenURL");
//    if ([self.sinaweibo handleOpenURL:URL]) {
//        return YES;
//    }
//    if ([WXApi handleOpenURL: URL delegate: self]) {
//        return YES;
//    }
    return [self.sinaWeiBo handleOpenURL:URL];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"sourceApplicationsourceApplication");
//    if ([self.sinaweibo handleOpenURL:url]) {
//        return YES;
//    }
//    if ([WXApi handleOpenURL: url delegate: self]) {
//        return YES;
//    }
    return [self.sinaWeiBo handleOpenURL:url];
    
}
- (NSString*) tokenCreat:(NSString*)token
{
    NSArray *array = [token componentsSeparatedByString:@" "];
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:0];
    for (int i = 0;  i < array.count; i++) {
        [str appendString:[array objectAtIndex:i]];
    }
    NSString *strr = [str substringWithRange:NSMakeRange(1, 64)];
    return strr;
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString* token = [NSString stringWithFormat:@"%@",deviceToken];
    NSLog(@"apns -> 生成的devToken:%@", token);
    //把deviceToken发送到我们的推送服务器

    DeviceSender* sender = [[[DeviceSender alloc]initWithDelegate:self ]autorelease];
    [sender sendDeviceToPushServer:[self tokenCreat:token] ];
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"apns -> 注册推送功能时发生错误， 错误信息:\n %@", err);
    //    [self alertNotice:@"注册推送功能时发生错误" withMSG:[err localizedDescription] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
}
//程序处于启动状态，或者在后台运行时，会接收到推送消息，解析处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"\napns -> didReceiveRemoteNotification,Receive Data:\n%@", userInfo);
    //把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"**推送消息**"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"处理推送内容",nil];
        alert.tag = alert_tag_push;
        [alert show];
    }
}

#pragma mark - 处理推送服务器push过来的数据
-(void) pushAlertButtonClicked:(NSInteger)buttonIndex
{
    NSLog(@"响应推送对话框");
    if (buttonIndex == 0) {
        NSLog(@"--->点了第一个按钮");
    } else {
        NSLog(@"--->点了第二个按钮");
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case alert_tag_push:
        {
            [self pushAlertButtonClicked:buttonIndex];
        }
            break;
        default:
            break;
    }
}

-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView *alert;
    if(!otherTitle || [otherTitle isEqualToString:@""])
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
    [alert show];
    [alert release];
}

#pragma mark - 实现代理接口：DeviceSenderDelegate
- (void)didSendDeviceFailed:(DeviceSender *)sender withError:(NSError *)error
{
    NSLog(@"apns -> 发送设备标识到服务器失败:%@", error);
    //    [self alertNotice:@"错误" withMSG:@"发送设备标识到服务器失败" cancleButtonTitle:@"确定" otherButtonTitle:nil ];
//    [sender release ];
}

- (void)didSendDeviceSuccess:(DeviceSender *)sender
{
    NSLog(@"apns -> 设备标识已发送到服务器");
    //    [self alertNotice:@"" withMSG:@"设备标识已发送到服务器" cancleButtonTitle:@"确定" otherButtonTitle:nil ];
//    [sender release];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



@end
