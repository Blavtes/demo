//
//  UIDeviceHardware.h
//  Shopping
//
//  Created by Qingshancai on 8/20/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE_SIMULATOR_NAMESTRING @"iPhone Simulator"
#define IPAD_SIMULATOR_NAMESTRING @"iPad Simulator"
#define IPHONE_1G_NAMESTRING @"iPhone 1"
#define IPHONE_3G_NAMESTRING @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING @"iPhone 3GS"
#define IPHONE_4G_NAMESTRING @"iPhone 4"
#define IPHONE_4GS_NAMESTRING @"iPhone 4GS"
#define IPOD_1G_NAMESTRING @"iPod Touch 1"
#define IPOD_2G_NAMESTRING @"iPod Touch 2"
#define IPAD_1G_NAMESTRING @"iPad 1"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface UIDevice (Hardware)
- (NSString *) platform;
- (NSString *) platformString;
- (BOOL)hasMicrophone;
- (BOOL)iPhone4OrBetter;
@end
