//
//  UICustomBarButtonItem.m
//  IAppfree
//
//  Created by Qingshancai on 4/20/11.
//  Copyright appfactory 2011. All rights reserved.
//

#import "UICustomBarButtonItem.h"

@implementation UIBarButtonItem (CustomImage)

- (id)initWithTitleEx:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
	
	if((UIBarButtonItemStyleEx)style > UIBarButtonItemStyleBackEx) {
		return [self initWithTitle:title style:style target:target action:action];
	}
	
	UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
	if ((UIBarButtonItemStyleEx)style == UIBarButtonItemStyleBackEx) {
		button.frame = CGRectMake(0, 0, 63, 30);
		UIImage* bg_normal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonbar_back" ofType:@"png"]];
		[button setBackgroundImage:bg_normal forState:UIControlStateNormal];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
		[bg_normal release];
	}
	else if ((UIBarButtonItemStyleEx)style == UIBarButtonItemStyleEditEx) {
		UIImage* bg_normal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonbar_edit" ofType:@"png"]];
		[button setBackgroundImage:bg_normal forState:UIControlStateNormal];
		[button titleLabel].textAlignment = UITextAlignmentCenter;
		[bg_normal release];
	}
	else if ((UIBarButtonItemStyleEx)style == UIBarButtonItemStyleActionEx) {
		button.frame = CGRectMake(0, 0, 44, 30);
		UIImage* bg_normal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonbar_action" ofType:@"png"]];
		[button setBackgroundImage:bg_normal forState:UIControlStateNormal];
		[button titleLabel].textAlignment = UITextAlignmentCenter;
		[bg_normal release];
	}
	else {
		UIImage* bg_normal = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonbar_edit" ofType:@"png"]];
		[button setBackgroundImage:bg_normal forState:UIControlStateNormal];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
		[bg_normal release];
	}
	
	NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
	NSString* localLanguage = [languages objectAtIndex:0];
	if ([localLanguage hasPrefix:@"zh"]) {
		[[button titleLabel] setFont:[UIFont systemFontOfSize: 14.0f]];
	}
	else
	{
		[[button titleLabel] setFont:[UIFont systemFontOfSize:12.f]];
	}
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	self = [self initWithCustomView:button];
	[button release];
	
	return self;
}

@end
