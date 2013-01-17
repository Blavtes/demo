//
//  UIDeviceSystemVersion.h
//  Shopping
//
//  Created by Qingshancai on 8/20/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDevice(SystemVersion)

/*!
 @brief Check current iOS version against given one.

 @param version float value of lowest version to check for
 @return YES if iOS version >= input value, else NO.
 */
+ (BOOL)newerThanIos:(float)version;

/*!
 @brief Does the current device run on iOS 3.2 or better?
 
 @return YES if systemVersion >= 3.2, else NO.
 */
+ (BOOL)runsIos32OrBetter;

/*!
 @brief Does the current device run on iOS 4.0 or better?

 @return YES if systemVersion >= 4.0, else NO.
 */
+ (BOOL)runsIos4OrBetter;

/*!
 @brief Does the current device run on iOS 4.2 or better?

 @return YES if systemVersion >= 4.2, else NO.
 */
+ (BOOL)runsIos42OrBetter;

@end
