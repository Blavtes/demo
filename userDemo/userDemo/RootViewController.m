//
//  RootViewController.m
//  userDemo
//
//  Created by yangyong on 12-12-21.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <StoreKit/StoreKit.h>
#import "WeiboViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"

#import "UIDeviceHardware.h"

#import "AppListWaitDownloadCell.h"
#import "LimitFreeCell.h"
#import "APIResponse.h"
#import "TencentOAuth.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController


@synthesize myTable,dataArray,canArray,recommendthumbscrollview,urlArray,renren = _renren;
#define URLIAPPFREE @"myapp://IAppFree"
#define URLTECHWEB @"candou://iTechWeb"

#define  kSearchAppAppleItunesFormat		   @"http://itunes.apple.com/app/id%@?mt=8"
#define  kSearchAppAppleItunesCommentFormat    @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"
#define kAPPID  @"468587292"
#define SHARETEXT @"imagesssssss    "
//#define IMGAENAME @"camera_largeImage_1"
#define IMGAENAME @"xingzuo"
#define IMGURL @"http://ww1.sinaimg.cn/mw600/627b8afbjw1dig2y1zzv7g.gif"
#define UID_Sina_weibo @"冰梦影699"
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) btnClick:(UIButton*)sender
{
    NSLog(@"sender////");
    if (sender.tag == 101) {
        WeiboViewController *webs = [[WeiboViewController alloc] init];
        [self presentModalViewController:webs animated:YES];
    }else if(sender.tag == 100){
        NSLog(@"weixin");////
        [self weixin];
    }


}
- (void) weixin
{

    WXMediaMessage *message = [WXMediaMessage message];
        WXImageObject *ext = [WXImageObject object];
    if ([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]]) {
       [message setThumbImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",IMGAENAME]]];
         ext.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]];
    }else if([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]]){
     [message setThumbImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",IMGAENAME]]];
         ext.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]];
    }else{
      [message setThumbImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",IMGAENAME]]];
         ext.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"jpg"]];
    }

    message.mediaObject = ext;
    NSLog(@"ext...%@",ext);
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.text = SHARETEXT;
    req.scene = WXSceneSession;
    req.message = message;
    
    [WXApi sendReq:req];
}
- (void) shareClick:(id)sender
{
    [_share showInView:self.view];

    

}
- (void)viewDidLoad
{
    [super viewDidLoad];


    self.renren = [Renren sharedRenren];

    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 49)];
    
    view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"top_bar.png"]];
    
    [self.view addSubview: view];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(140, 0,200, 44)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"设置";
    title.font = [UIFont boldSystemFontOfSize:21.0];
    title.shadowOffset = CGSizeMake(0, 1);
    title.shadowColor = [UIColor colorWithRed:64.0/255.0 green:109.0/255.0 blue:49.0/255.0 alpha:1];
    title.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];

    [self.view addSubview:title];
    [title release];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = (CGRect){270,17/2,50,59/2};
     [btn setBackgroundImage: [UIImage imageNamed:@"btn_love.png"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_love.png"]]];


    [btn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:153.0/255.0 blue:98.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 98/2, 320, 460 - 92/2 - 98/2 ) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorColor = [UIColor colorWithRed:203.0/255.0 green:209.0/255.0 blue:213.0/255.0 alpha:1];

    
    [myTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:myTable];
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 295.0f+44, 320.0f, 98.0f)];
    
    UIScrollView *recommendscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 26, 320.0f, 78.0f)];
    recommendthumbscrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"defaultbackground.png"]];
	self.recommendthumbscrollview = recommendscrollview;
	views.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:225.0/255.0  blue:225.0/255.0  alpha:1];

	recommendscrollview.showsVerticalScrollIndicator = NO;
	recommendscrollview.showsHorizontalScrollIndicator = NO;
	recommendscrollview.pagingEnabled = YES;
    recommendscrollview.userInteractionEnabled = YES;
	recommendscrollview.bounces = YES;
	recommendscrollview.clipsToBounds = YES; // default is NO, we want to restrict drawing within our scrollview
	recommendscrollview.scrollEnabled = YES;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(14, 5, 200, 20)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1];
    lab.font = [UIFont systemFontOfSize:12.0];
    lab.text = @"我的应用 * My Clover Apps";
    [views addSubview:lab];
    [lab release];
    [views addSubview:self.recommendthumbscrollview];
    self.myTable.tableFooterView = views;
    [recommendscrollview release];
    UIView *fooldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 89 + 29)];

    NSArray *arrayWithImage = [NSArray arrayWithObjects:@"btn_setting.png",@"btn_weibo.png", @"btn_retalk.png",@"btn_support.png",nil];
    for (int i = 0;  i < 4; i++) {
        UIButton *con = [UIButton buttonWithType:UIButtonTypeCustom];
        con.frame = CGRectMake((i/2) * 160, (i %2)*92/2 + 2, 160, 46);

        [con setBackgroundImage:[UIImage imageNamed:[arrayWithImage objectAtIndex:i]] forState:UIControlStateNormal];
        [con setBackgroundImage:[UIImage imageNamed:@"grund.png"] forState:UIControlStateHighlighted];
        [con setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:1];
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        con.tag = i + 100;
        [fooldView addSubview:con];

    }
  
    
    UIView *viewp = [[UIView alloc] initWithFrame:CGRectMake(0, 89, 320, 58/2)];
    viewp.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0  blue:245.0/255.0  alpha:1];
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 207, 58/2)];
    labe.backgroundColor = [UIColor clearColor];
    labe.text = @"推荐应用 。Sepecial Honored";
    labe.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    labe.font = [UIFont systemFontOfSize:14];
    [viewp addSubview:labe];
    [fooldView addSubview:viewp];
    [viewp release];
    [labe release];
    self.myTable.tableHeaderView = fooldView;
    [fooldView release];
    

    _share = [[UIActionSheet alloc] initWithTitle:@"如果你喜欢本应用，你可以" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [_share addButtonWithTitle:@"到App Store 评价我们"];
    
    [_share addButtonWithTitle:@"新浪微博推荐给好友"];
    [_share addButtonWithTitle:@"腾讯微博推荐给好友"];
//    [_share addButtonWithTitle:@"推荐给好友"];
    [_share addButtonWithTitle:@"人人网推荐给好友"];
    [_share addButtonWithTitle:@"短信推荐给好友"];
    [_share addButtonWithTitle:@"Email推荐给好友"];
    [_share addButtonWithTitle:@"取消"];
//    _share.backgroundColor = [UIColor clearColor];
    _share.destructiveButtonIndex = _share.numberOfButtons -1 ;
    
  

    _share.actionSheetStyle = UIBarStyleBlackTranslucent;
    dataArray = [[NSMutableArray alloc] init];
    canArray = [[NSMutableArray alloc] initWithCapacity:0];
    array = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"IAppFree",@"name",@"1321321",@"id",@"他们有些人著书立说，有些人在科技创新上亲力亲为，他们都改变了整个科技产业界。这 13 位巨人虽然离世，",@"des", nil ],[NSDictionary dictionaryWithObjectsAndKeys:@"iTechWeb",@"name",@"324324324",@"id",@"但是他们在科技界留下自己的印记，继续教育和鼓舞着后来的技术爱好者。 如果你期待今年科技界的事件会成为全球的新闻头条，那你可能要失望了。",@"des", nil ],[NSDictionary dictionaryWithObjectsAndKeys:@"xingzuo",@"name",@"32432432",@"id",@"信息世界中充斥着有关各国选举和其它事件的新闻，甚少有人注意到几位科技专家的辞世。甚至，他们的成就在生前也没被世人所完全熟知。",@"des", nil ], nil];

    urlArray = [[NSMutableArray alloc] initWithObjects:@"myapp://IAppFree", @"candou://iTechWeb",@"doudou://xingzuo",nil];
    for (int i = 0; i < urlArray.count; i ++ ) {
          BOOL iscan =  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithString:[urlArray objectAtIndex:i]]]];

        if (iscan) {
            NSLog(@"..add. %d.",i);
            [canArray addObject:[array objectAtIndex:i]];
            NSLog(@"strin dd %@",canArray);
        }else{
            [dataArray addObject:[array objectAtIndex:i]];
        }
    }
    [self addMyappList];
    

}
- (void)shareArticle {
    
    [_share showInView:self.view];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	NSString *errorMessage = nil;
	switch (result)
	{
		case MessageComposeResultCancelled:
			errorMessage = nil;
			break;
		case MessageComposeResultSent:
			errorMessage = NSLocalizedString(@"短信已发送!", @"");
			break;
		case MessageComposeResultFailed:
			errorMessage = NSLocalizedString(@"短信发送失败!", @"");
			break;
		default:
			break;
	}
	
	if (errorMessage != nil ) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TechWeb资讯"
														message:errorMessage
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	[self dismissModalViewControllerAnimated:YES];
}
-(void ) shareMsg{
     [_share dismissWithClickedButtonIndex:-1 animated:YES];
    if(![[UIDevice currentDevice] hasMicrophone]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share"
														message:@"设备不支持发送短信功能"
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
        return;
    }
    
    NSString* messageAddress = nil;
	NSString* messageSubject = [[NSString alloc]initWithFormat:@"%@", NSLocalizedString(@"分享", @"")];
	NSString* messageBody = [[NSString alloc]initWithFormat:SHARETEXT];
	
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	if (messageClass != nil)
	{
		if ([messageClass canSendText])
		{
			[self displayMessageComposerSheet:messageAddress subject:messageSubject body:messageBody];
		}
		else
		{
			[self launchMessageAppOnDevice:messageAddress subject:messageSubject body:messageBody];
		}
	}
	else
	{
		[self launchMessageAppOnDevice:messageAddress subject:messageSubject body:messageBody];
	}
	
	[messageBody release];
}
- (void) launchMessageAppOnDevice:(NSString*)messageAddress subject:(NSString *)messageSubject body:(NSString*)messageBody
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://800888"]];
}
-(void)displayMessageComposerSheet:(NSString*)address subject:(NSString *)subject body:(NSString *)body
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
	picker.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[picker setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSArray* toRecipients = address?[NSArray arrayWithObject:address]:nil;
	[picker setRecipients:toRecipients];
	[picker setBody:body];
	[pool drain];
	
	[self presentModalViewController:picker animated:YES];
    [self setControllerTitle:picker.topViewController withTitle:subject];
    [picker release];
}
- (void)setControllerTitle:(UIViewController*)controller withTitle:(NSString*)title {
	
	UILabel* titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 155, 35)];
    titlelabel.textColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    titlelabel.backgroundColor = [UIColor clearColor];
	titlelabel.font = [UIFont systemFontOfSize:18];
    titlelabel.textAlignment = UITextAlignmentCenter;
    titlelabel.text = title;
	controller.title = title;
	controller.navigationItem.titleView = titlelabel;
    [titlelabel release];
}
#pragma mark ---Email----

-(void ) shareEmail{
    NSString* mailAddress = nil;
	NSString* mailSubject = [[NSString alloc]initWithFormat:@"%@", NSLocalizedString(@"分享", @"")];
	NSString* mailBody = [[NSString alloc]initWithFormat:SHARETEXT];
	
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		if ([mailClass canSendMail])
		{
			[self displayMailComposerSheet:mailAddress subject:mailSubject body:mailBody];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
	[mailSubject release];
	[mailBody release];
}
-(void)launchMailAppOnDevice {
   
    NSString *emailString = [NSString stringWithFormat:SHARETEXT];
    
  
    NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Here is your gear check list!";
    NSString *body = emailString;
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
- (void)cancelemail:(id)sender {
	
	UIBarButtonItem* cancelButton = _mfmailcontroller.navigationBar.topItem.leftBarButtonItem;;
    id target = cancelButton.target;
    [target performSelector:cancelButton.action withObject:cancelButton];
}

- (void)sendemail:(id)sender {
	
	UIBarButtonItem* sendButton = _mfmailcontroller.navigationBar.topItem.rightBarButtonItem;;
    id target = sendButton.target;
    [target performSelector:sendButton.action withObject:sendButton];
}

-(void)displayMailComposerSheet:(NSString*)address subject:(NSString *)subject body:(NSString *)body
{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *pathHome = [path objectAtIndex:0];
    NSString *filePath = [pathHome stringByAppendingPathComponent:@"info.txt"];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:nil] forBarMetrics:UIBarMetricsDefault];
    
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	_mfmailcontroller = picker;
	picker.mailComposeDelegate = self;
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[picker setSubject:subject];
    
    if ([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]]) {
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        [picker addAttachmentData:data mimeType:@"gif" fileName:[NSString stringWithFormat:@"%@.gif",IMGAENAME]];
    }else if([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]]){
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        [picker addAttachmentData:data mimeType:@"png" fileName:[NSString stringWithFormat:@"%@.png",IMGAENAME]];
    }else{
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        [picker addAttachmentData:data mimeType:@"jpg" fileName:[NSString stringWithFormat:@"%@.jpg",IMGAENAME]];
    }

   
	NSArray* toRecipients = address?[NSArray arrayWithObject:address]:nil;
	[picker setToRecipients:toRecipients];
	[picker setMessageBody:body isHTML:NO];

	[pool drain];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSString *errorMessage = nil;
	switch (result)
	{
		case MFMailComposeResultCancelled:
			errorMessage = nil;
			break;
		case MFMailComposeResultSaved:
			errorMessage = nil;
			break;
		case MFMailComposeResultSent:
			errorMessage = NSLocalizedString(@"邮件已发送!", @"");
			break;
		case MFMailComposeResultFailed:
			errorMessage = NSLocalizedString(@"邮件发送失败!", @"");
			break;
		default:
			break;
	}
	
	if (errorMessage != nil ) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"TechWeb资讯"
														message:errorMessage
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
	[self dismissModalViewControllerAnimated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

}

-(void ) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"-- action sheet idnex %u",buttonIndex);
    
    //(<##>)
    if (buttonIndex == actionSheet.cancelButtonIndex)
    { return; }
    switch (buttonIndex) {
     
        case 0:{
            NSLog(@".....");
            NSString *url = [NSString stringWithFormat:kSearchAppAppleItunesCommentFormat,kAPPID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
        }
            break;
        case 1:{

            [self shareWeibo];
        }
            break;
        case 2:{
//            [self shareQQzone];
            [self shareQQ];
        }
            break;
        case 3:{
//            [self shareTecentWeibo];
            
            [self shareRenRen];
        }
            break;
        case 4:{

             [self shareMsg];
        }
            break;
        case 5:{


             [self shareEmail];
        }
            break;

            
            
        default:
            break;
    }
}
- (void) shareWeibo{
    
    [_share dismissWithClickedButtonIndex:-1 animated:YES];
    NSLog(@"share sina");


     
    if (![appDelegate.sinaWeiBo isLoggedIn]) {
        [self loginSina];

    }
    [self postImageState];

//    [self addFrom];

}
- (void) shareRenRen
{
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* graphCookies = [cookies cookiesForURL:
                             [NSURL URLWithString:@"http://graph.renren.com"]];
    
    for (NSHTTPCookie* cookie in graphCookies) {
        [cookies deleteCookie:cookie];
    }
    NSString *msg = SHARETEXT;
    NSArray* widgetCookies = [cookies cookiesForURL:[NSURL URLWithString:@"http://widget.renren.com"]];
    
    for (NSHTTPCookie* cookie in widgetCookies) {
        [cookies deleteCookie:cookie];
    }
    if (![self.renren isSessionValid]){
        [self.renren authorizationInNavigationWithPermisson:nil andDelegate:self];
    } else {
        
        if ([UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",IMGAENAME]]) {
             [self.renren publishPhotoSimplyWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",IMGAENAME]] caption:msg];
        }else{
        [self.renren publishPhotoSimplyWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",IMGAENAME]] caption:msg];
        }
    }

}
- (void) postText:(NSString *)msg andImage:(UIImage*)imag
{
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* graphCookies = [cookies cookiesForURL:
                             [NSURL URLWithString:@"http://graph.renren.com"]];
    
    for (NSHTTPCookie* cookie in graphCookies) {
        [cookies deleteCookie:cookie];
    }
    NSArray* widgetCookies = [cookies cookiesForURL:[NSURL URLWithString:@"http://widget.renren.com"]];
    
    for (NSHTTPCookie* cookie in widgetCookies) {
        [cookies deleteCookie:cookie];
    }
    if (![self.renren isSessionValid]){
        [self.renren authorizationInNavigationWithPermisson:nil andDelegate:self];
    } else {
    
        
        UIImage *image = [UIImage imageNamed:IMGAENAME];
        NSString *caption = SHARETEXT;
        [self.renren publishPhotoSimplyWithImage:image caption:caption];
    }
    
}
- (void) addMyappList
{
    
    NSInteger contentnumber = [canArray count];
    self.recommendthumbscrollview.contentSize = CGSizeMake(55.0f*(contentnumber + 1)+12.0f*(contentnumber+1)+200,
                                                           self.recommendthumbscrollview.frame.size.height);

    NSInteger indexnumber = 0;
    
    for (; indexnumber < canArray.count; indexnumber++) {
        UIControl *icon = [[UIControl alloc] initWithFrame:CGRectMake(24.0f+67.0f*indexnumber,6.0f,55.0f,55.0f)];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        CALayer * layer = [image layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:10.0];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[canArray objectAtIndex:indexnumber ] valueForKey:@"name"]]];
        [icon addSubview:image];
        icon.userInteractionEnabled = YES;
        icon.tag = indexnumber;
        [icon addTarget:self action:@selector(recomBtnClik:) forControlEvents:UIControlEventTouchUpInside];

        [self.recommendthumbscrollview addSubview:icon];

        [icon release];

    }


}
- (void) recomBtnClik:(id)sender
{

    UIControl *con = (UIControl*)sender;
    NSLog(@"con  %d",con.tag);
    NSString *string = [NSString stringWithString:[[canArray objectAtIndex:con.tag] valueForKey:@"name"]];
    NSLog(@"..url/// %@",[NSString stringWithString:[[canArray objectAtIndex:con.tag] valueForKey:@"name"]]);
    for (int x = 0; x < urlArray.count ; x ++) {
        NSString *st = [urlArray objectAtIndex:x];
        NSLog(@"st...%@",st);
        if ([string isEqualToString:[st substringWithRange:NSMakeRange(st.length - string.length, string.length)]]) {
            NSLog(@"yse");
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithString:st]]];
        }
    }
    
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"did ...%@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]);
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.tag ==-10){
        
        cell.selected = NO;
    }else {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
         [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed: @"grund.png"]]];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kSearchAppAppleItunesFormat,[[dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]]];
    NSLog(@"app store url....%@   id  %@",url,[[dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]);
    NSDictionary *dicts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[[dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]],@"id",url,@"url", nil];
    [self performSelectorOnMainThread:@selector(didStartAppStoreWith:) withObject:dicts waitUntilDone:NO];
    //    [self presentAppStoreForID:[NSNumber numberWithInteger:[self.detailItem.applicationId integerValue]] inView:self.view withDelegate:del withURL:url];
    
}
#pragma mark -----开启appSotre----
- (void) didStartAppStoreWith:(NSDictionary*)dict
{
    [self presentAppStoreForID:[dict objectForKey:@"id"] inView:self.view withDelegate:self withURL:[dict objectForKey:@"url"]];
}
- (void)shareQQzone {
    NSLog(@"...........");
	NSArray *_permissions =  [[NSArray arrayWithObjects:
                               @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                               @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    
	
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"217896"
											andDelegate: self];
	_tencentOAuth.redirectURI = @"http://techweb.com.cn";
    
    [_tencentOAuth authorize:_permissions inSafari:NO];
    
}

- (void)tencentDidLogin {
    
 
    NSLog(@".....sdsf");
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   SHARETEXT, @"title",
								   @"http://www.techweb.com", @"url",
								   SHARETEXT,@"comment",
								   SHARETEXT,@"summary",
								 IMGURL,@"images",
								   @"1321",@"source",
								   nil];
	
	[_tencentOAuth addShareWithParams:params];
    
}

- (void)addShareResponse:(APIResponse*) response {
    
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:nil
							  
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败" message: nil
							  
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
	
    
}


- (void)presentAppStoreForID:(NSNumber *)appStoreID inView:(UIView *)view withDelegate:(id<SKStoreProductViewControllerDelegate>)dele withURL:(NSURL *)appStoreURL
{
    NSLog(@"stroer...");
    if(NSClassFromString(@"SKStoreProductViewController")) { // Checks for iOS 6 feature.
        NSLog(@"begin...");
        SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
        storeController.delegate = dele; // productViewControllerDidFinish
        

        
        NSDictionary *productParameters = @{ SKStoreProductParameterITunesItemIdentifier : appStoreID};
        NSLog(@"dict ...%@",productParameters);
        [storeController loadProductWithParameters:productParameters completionBlock:^(BOOL result, NSError *error) {
            if (result) {
                NSLog(@"if...");
                
                //                [self.navigationController pushViewController:storeController animated:YES];
            } else {
                NSLog(@"else");
                [[[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"There was a problem displaying the game" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            }
            
            [self presentModalViewController:storeController animated:YES];
        }];
        NSLog(@"....d.");
        
    } else { // Before iOS 6, we can only open the URL
        
        [[UIApplication sharedApplication] openURL:appStoreURL];
        
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 171.0/2;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed: @"grund.png"]]];
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *idNameFare = @"idNameFareinder";
    LimitFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:idNameFare];
    if (!cell) {
        cell = [[LimitFreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idNameFare];
    }
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"]]];
    cell.name.text = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
//    cell.des.text = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"des"];
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [cell setBackgroundView:[[UIView alloc] init]];
//    cell.backgroundColor = [UIColor clearColor];
    cell.classify.text = @"游戏";
    cell.price.text = @"$20.0";
    cell.lastTime.text = @"剩余";
    [cell setRating:2.5];
    cell.comment.text = @"(901)";
    return  cell;
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [appDelegate sinaWeiBo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark SinaWeiBoDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    
    NSLog(@"sinaweiboDidLogIn");
    [self storeAuthData];
    [self postImageState];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

// 缓存的 token 无效或者已经过期
// 注意需要清除缓存的用户信息
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"accessTokenInvalidOrExpired : %@", [error localizedDescription]);
    [self removeAuthData];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"logInDidFailWithError : %@", [error localizedDescription]);
}

#pragma mark -
#pragma mark SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError : %@", [error localizedDescription]);
    
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status failed!"]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status failed! with error : %@", [error localizedDescription]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"didFinishLoadingWithResult :%@", request);
    
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release];
        userInfo = [result retain];
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release];
        statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"Request ---> : %@", result);
        //发送微博成功
        if (![result objectForKey:@"error"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:[NSString stringWithFormat:@"Post image status  succeed!"]
                                                               delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:[NSString stringWithFormat:@"Post image status  faile!"]
                                                               delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
       
        
    }else if ([request.url hasSuffix:@"friendships/create.json"]){
        if (![result objectForKey:@"error"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:[NSString stringWithFormat:@"关注好友成功  succeed!"]
                                                               delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:[NSString stringWithFormat:@"关注好友  faile!"]
                                                               delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }

    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    NSLog(@"didReceiveRawData");
}

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse : %@", response);
}
#pragma mark -
- (void)loginSina
{
    
    NSLog(@"Login");
    
    [self removeAuthData];
    NSLog(@"accessToken:%@", appDelegate.sinaWeiBo.accessToken);
    [appDelegate.sinaWeiBo logIn];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (void)logoutSina
{
    NSLog(@"Logout");
    SinaWeibo *sinaweibo = [appDelegate sinaWeiBo];
    [sinaweibo logOut];
}
- (void) addFrom
{
    SinaWeibo *sinaweibo = [appDelegate sinaWeiBo];
    [sinaweibo requestWithURL:@"friendships/create.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:UID_Sina_weibo,@"screen_name", nil] httpMethod:@"POST" delegate:self];
}
- (void)postImageState
{
    SinaWeibo *sinaweibo = [appDelegate sinaWeiBo];
    
//    UIImage * tempImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",IMGAENAME]];

//    https://api.weibo.com/2/friendships/groups/members/add.json
//    https://api.weibo.com/2/statuses/update.json
            if ([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]]) {
               NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]];
                [sinaweibo requestWithURL:@"statuses/upload.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           SHARETEXT, @"status",
                                           data, @"pic", nil]
                               httpMethod:@"POST"
                                 delegate:self];//de
            }else if([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]]){
                NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]];
                [sinaweibo requestWithURL:@"statuses/upload.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           SHARETEXT, @"status",
                                           [UIImage imageNamed:IMGAENAME], @"pic", nil]
                               httpMethod:@"POST"
                                 delegate:self];//de
            }else{
              NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"jpg"]];
                [sinaweibo requestWithURL:@"statuses/upload.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          SHARETEXT , @"status",
                                           [UIImage imageNamed:IMGAENAME], @"pic", nil]
                               httpMethod:@"POST"
                                 delegate:self];//de
            }


}

#pragma mark -
- (void)createSuccess
{
    NSLog(@"ONPst");
}
- (void) createFail
{
    NSLog(@"..onOF.");
}
-(void ) shareQQ{
    
    NSLog(@"oooooooooooooo");
    [_share dismissWithClickedButtonIndex:-1 animated:YES];
    
    [_engine logOut];
    if (!_engine){
    
        NSLog(@"....");
        _engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl: REDIRECTURI];
        [_engine setRootViewController:self];
        
    }
    if ([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]]) {
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"gif"]];
        [_engine UIBroadCastMsgWithContent:[[NSString alloc]initWithFormat:@"分享：%@。",SHARETEXT]
                                  andImage:data
                               parReserved:nil
                                  delegate:self
                               onPostStart:@selector(postStart)
                             onPostSuccess:@selector(createSuccess:)
                             onPostFailure:@selector(createFail:)];

      

    }else if([NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:IMGAENAME ofType:@"png"]]){

        [_engine UIBroadCastMsgWithContent:[[NSString alloc]initWithFormat:@"分享：%@。",SHARETEXT]
                                  andImages:[UIImage imageNamed:IMGAENAME]
                               parReserved:nil
                                  delegate:self
                               onPostStart:@selector(postStart)
                             onPostSuccess:@selector(createSuccess:)
                             onPostFailure:@selector(createFail:)];
     
    }else{

        [_engine UIBroadCastMsgWithContent:[[NSString alloc]initWithFormat:@"分享：%@。",SHARETEXT]
                                 andImages:[UIImage imageNamed:IMGAENAME]
                               parReserved:nil
                                  delegate:self
                               onPostStart:@selector(postStart)
                             onPostSuccess:@selector(createSuccess:)
                             onPostFailure:@selector(createFail:)];
        
    }

   [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}



@end
