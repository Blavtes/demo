//
//  UIDeviceSystemVersion.h
//  Shopping
//
//  Created by Qingshancai on 8/20/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import "UIDeviceSystemVersion.h"


@implementation UIDevice(SystemVersion)

+ (BOOL)newerThanIos:(float)version
{
	float currentVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	return (currentVersion >= version);
}

+ (BOOL)runsIos32OrBetter
{
	return [self newerThanIos:3.2f];
}

+ (BOOL)runsIos4OrBetter
{
	return [self newerThanIos:4.0f];
}

+ (BOOL)runsIos42OrBetter
{
	return [self newerThanIos:4.2f];
}

@end
