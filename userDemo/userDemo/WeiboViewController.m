//
//  WeiboViewController.m
//  userDemo
//
//  Created by yangyong on 12-12-28.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "WeiboViewController.h"
#import "CDNavigationBar.h"
#import "Weibocell.h"
#import <QuartzCore/QuartzCore.h>
#import "UICustomBarButtonItem.h"
#import "AppDelegate.h"
@interface WeiboViewController ()

@end

@implementation WeiboViewController
@synthesize nbNavigationBar = _nbNavigationBar,myTable,favArray ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)btnClick:(id)sender
{
    NSLog(@"guanzhu./.");
    NSArray *visuableCell = [myTable visibleCells];
    [favArray removeAllObjects];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i <visuableCell.count; i ++) {
        Weibocell *cell = [visuableCell objectAtIndex:i];
        
        if ([cell.btn.imageView.image isEqual:[UIImage imageNamed:@"choice.png"]]) {

            NSLog(@",,, %@ %d",cell.nameLable.text,array.count);
            if (array.count != 0) {
                NSLog(@",,,,,");
            
            for (int j = i ;j <  array.count;j++) {
                NSDictionary *dict = [array objectAtIndex:i];
                NSString *str = [dict objectForKey:@"name"];
                if ([str isEqualToString:cell.nameLable.text]) {
                     NSString *stra = [dict objectForKey:@"id"];
                    NSLog(@"str....%@ %@" ,str,stra);
                    if (favArray.count == 0) {
                        [favArray addObject:stra];
                    }

                        for (int k = 0;  k < favArray.count; k++) {
                            if ([[favArray objectAtIndex:k] isEqualToString:stra] == NO) {
                                NSLog(@"yes");
                                [favArray addObject:stra];
                                
                            }
                        }
                    }
                  
                  
                }
            
           }
            
        }
    }
    for (int  i = 0; i < [favArray count]; i++){
        if ([arrays containsObject:[favArray objectAtIndex:i]] == NO){
            [arrays addObject:[favArray objectAtIndex:i]];
        }

    }
    NSLog(@"favcount %d %d %d",favArray.count,visuableCell.count,arrays.count);
    if (favArray.count == 0) {
        NSLog(@"xuaze  0000");
        return;
    }
    if ( ![appDelegate.sinaWeiBo isLoggedIn]) {
        NSLog(@"dajjdal");
        [self loginSina];
        for (int i = 0;  i < arrays.count; i++) {
            [self addFrom:[arrays objectAtIndex:i]];
            
        }
    }else{

        for (int i = 0;  i < arrays.count; i++) {
            [self addFrom:[arrays objectAtIndex:i]];

        }
        
    }
}
- (void) addFrom:(NSString*)name
{
    SinaWeibo *sinaweibo = [appDelegate sinaWeiBo];
    [sinaweibo requestWithURL:@"friendships/create.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"screen_name", nil] httpMethod:@"POST" delegate:self];
}
- (void)loginSina
{
    
    NSLog(@"Login");
    
    [self removeAuthData];
    NSLog(@"accessToken:%@", appDelegate.sinaWeiBo.accessToken);
    [appDelegate.sinaWeiBo logIn];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

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
#pragma mark----
- (void)viewDidLoad
{
    [super viewDidLoad];
//    sinaOAuthManager = [[OAuthManager alloc]initWithOAuthManager:SINA_WEIBO];
//     _manager = [ WeiBoMessageManager getInstance];
    favArray = [[NSMutableArray alloc] initWithCapacity:0];

    myTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 44, 300, 460) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;

    self.myTable.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1];
    [self.view addSubview:myTable];
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    view1.backgroundColor = [UIColor colorWithRed:0.34231 green:0.42343 blue:0.343 alpha:1];
//    [myTable.tableFooterView addSubview:view1];
//    [myTable.tableHeaderView addSubview:view1];
//    [view1 release];

    array = [[NSArray alloc ] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"IAppFree",@"name",@"idis2",@"id", nil ],[NSDictionary dictionaryWithObjectsAndKeys:@"iTechWeb",@"name",@"idis3",@"id", nil ],[NSDictionary dictionaryWithObjectsAndKeys:@"xingzuo",@"name",@"idis4",@"id", nil ], nil];
    
    UIControl *butn = [[UIControl alloc] initWithFrame:CGRectMake(0, 20, 300, 60)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 40)];
    lab.text = @"关注";
    CALayer *layer = [ lab layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    lab.textColor =  [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];

    lab.textAlignment = UITextAlignmentCenter;
    lab.backgroundColor =  [UIColor colorWithRed:84.0/255.0 green:183.0/255.0 blue:53.0/255.0 alpha:1];

    lab.font = [UIFont boldSystemFontOfSize:20];
    [butn addSubview:lab];
    [butn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
       self.myTable.tableFooterView = butn;
    UIView *hedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    hedView.backgroundColor =  [UIColor colorWithRed:230.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1];
    self.myTable.tableHeaderView = hedView;
    [hedView release];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1];
    UIButton *btnBack = [[UIButton alloc] initWithFrame:(CGRect){10,7,60,32}];
    
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    
    view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"top_bar.png"]];
    
    [self.view addSubview: view];
    
    [btnBack setBackgroundImage: [UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    btnBack.titleLabel.textColor = [UIColor colorWithRed:0.3342 green:0.231 blue:0.321 alpha:1];
    //        [btnBack setShowsTouchWhenHighlighted:YES];
    
    [btnBack addTarget:self action:@selector(leftClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(100,7,200,32)];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setText:@"关注我们的新浪微博"];
    [labTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [labTitle setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [self.view addSubview:labTitle];
}
- (void)leftClicked:(id)se {
    NSLog(@"....");
	[self dismissModalViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idNameFare = @"idNameFareinder";
    Weibocell *cell = [tableView dequeueReusableCellWithIdentifier:idNameFare];
//    if (!cell) {
        cell = [[Weibocell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idNameFare];
//    }
    NSLog(@"inde %d",indexPath.row);
    [cell setImageView: [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[array objectAtIndex:indexPath.row] valueForKey:@"name"]]]];
    NSLog(@"...%@",[NSString stringWithFormat:@"%@.png",[[array objectAtIndex:indexPath.row] valueForKey:@"name"]]);
      UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    cell.backgroundView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    cell.nameLable.text = [[array objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    return  cell;
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cells forRowAtIndexPath:(NSIndexPath *)indexPath{
    cells.backgroundColor = [UIColor whiteColor];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did ...");
     [tableView setBackgroundColor:[UIColor clearColor]];
    NSArray *visuableCell = [tableView visibleCells];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    for (UITableViewCell *cell in visuableCell) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        aView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = aView;
        [aView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
