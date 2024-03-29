//
//  UIDeviceHardware.h
//  Shopping
//
//  Created by Qingshancai on 820/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G
 iPhone2,1 -> iPhone 3GS
 iPhone3,1 -> iPhone 4G
 iPhone4,1 -> iPhone 4GS
 iPod1,1   -> iPod touch 1G
 iPod2,1   -> iPod touch 2G
 iPad1,1   -> iPad 1G
 i386	   -> iPhone/iPad Simulator
 */

- (NSString *) platform
{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithUTF8String:machine];
	free(machine);
      NSLog(@"..add. %@.",platform);
	return platform;
}

- (NSString *)platformString
{
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return IPHONE_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone1,2"]) return IPHONE_3G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone2,1"]) return IPHONE_3GS_NAMESTRING;
	if ([platform isEqualToString:@"iPhone3,1"]) return IPHONE_4G_NAMESTRING;
    if ([platform isEqualToString:@"iPhone4,1"]) return IPHONE_4GS_NAMESTRING;
	if ([platform isEqualToString:@"iPod1,1"])   return IPOD_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPod2,1"])   return IPOD_2G_NAMESTRING;
	if ([platform isEqualToString:@"iPad1,1"])   return IPAD_1G_NAMESTRING;
	if ([platform isEqualToString:@"i386"]) {
#if 0
		if(DeviceIsPad())
			return IPAD_SIMULATOR_NAMESTRING;
		else
			return IPHONE_SIMULATOR_NAMESTRING;
#else
		return IPHONE_SIMULATOR_NAMESTRING;
#endif
	}
	return NULL;
}

- (BOOL)hasMicrophone {
    NSLog(@"hasMicrophone");
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return YES;
	if ([platform isEqualToString:@"iPhone1,2"]) return YES;
	if ([platform isEqualToString:@"iPhone2,1"]) return YES;
	if ([platform isEqualToString:@"iPhone3,1"]) return YES;
    if ([platform isEqualToString:@"iPhone4,1"]) return YES;
	if ([platform isEqualToString:@"iPod1,1"])   return NO;
	if ([platform isEqualToString:@"iPod2,1"])   return NO;
	if ([platform isEqualToString:@"iPad1,1"])   return NO;
	
	return NO;
}

- (BOOL)iPhone4OrBetter {
    NSString *platform = [self platform];
    if ([platform hasPrefix:@"iPhone3"])   return YES;
    if ([platform hasPrefix:@"iPhone4"])   return YES;
    
    return NO;
}

@end
