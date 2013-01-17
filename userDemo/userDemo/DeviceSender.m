//
//  DeviceSender.m
//  PushNotificationDemo
//
//  Created by 罗 永亮 on 12-2-20.
//  Copyright (c) 2012年 luoyl.info. All rights reserved.
//

#define push_server		@"http://192.168.0.177:8080/texasbackend/postDeviceId?udid=jiangchao&deviceId=%@"
#define game_id			@"7"	
#import "DeviceSender.h"

@interface DeviceSender()
-(void) sendRequestByGet:(NSString*)urlString;
@end


@implementation DeviceSender
@synthesize delegate;

- (void)dealloc
{

    [receivedData release];
    [conn release];

    [super dealloc];
}


- (id)initWithDelegate:(id<DeviceSenderDelegate>)delegate_
{
    if (self = [super init]) {
        self.delegate = delegate_;
    }
    return self;
}

-(void) sendDeviceToPushServer:(NSString*)deviceToken
{
    NSString *str = @"http://192.168.0.177:8080/texasbackend/login?udid=jiangchao&password=jiangchao123&source=0";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *rest = [NSURLRequest requestWithURL:url];
    NSURLConnection *con = [[[NSURLConnection alloc] initWithRequest:rest delegate:self] autorelease];
    [con start];
    //    [con release];
    [con scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
	NSString *urlString = [NSString stringWithFormat:push_server, deviceToken];
	NSLog(@"---->发送设备id到：%@", urlString);	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
	NSString *strUrld8 = [urlString stringByAddingPercentEscapesUsingEncoding:enc];
	//调用http get请求方法 
	[self sendRequestByGet:strUrld8];
}

//HTTP get请求方法
- (void)sendRequestByGet:(NSString*)urlString
{   
	NSURL *url=[NSURL URLWithString:urlString];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
																cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
															timeoutInterval:60];
	//设置请求方式为get
	[request setHTTPMethod:@"GET"];
	//添加用户会话id
	[request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
	//连接发送请求
	receivedData=[[NSMutableData alloc] initWithData:nil];
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//	[request release];       
//	[conn release];
}

- (void)connection:(NSURLConnection *)aConn didReceiveResponse:(NSURLResponse *)response {
    if (aConn == conn) {
        // 注意这里将NSURLResponse对象转换成NSHTTPURLResponse对象才能去
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ([response respondsToSelector:@selector(allHeaderFields)]) {
            NSDictionary *dictionary = [httpResponse allHeaderFields];
            NSLog(@"[connection,didReceiveResponse =%@]",[dictionary description]);
            
        }
    }
  
}

//接收NSData数据
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
    if (aConn == conn) {
        [receivedData appendData:data];

    }
}
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    if (aConn == conn) {
        NSLog(@"[connection,didFailWithError=%@]",[error localizedDescription]);
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSendDeviceFailed:withError:)]) {
            [self.delegate didSendDeviceFailed:self withError:error];
        }
    }
   
}

//接收完毕,显示结果
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
    if (aConn == conn) {
        NSString *results = [[NSString alloc]
                             initWithBytes:[receivedData bytes]
                             length:[receivedData length]
                             encoding:NSUTF8StringEncoding];
        NSLog(@"[connectionDidFinishLoading,result=%@]",results);
//        [results release];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSendDeviceSuccess:)]) {
            [self.delegate didSendDeviceSuccess:self];
        }
    }
	
} 

@end
