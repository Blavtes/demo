//
//  CDNavigationBar.m
//  DouDouSiFangCai
//
//  Created by hzs on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDNavigationBar.h"

#define kTag_Back 101 
#define kTag_Favorite 102

@interface CDNavigationBar ()

-(void) onBtnBackClick:(id)aSender;
-(void) onBtnFavoriteClick:(id)aSender;

@end

@implementation CDNavigationBar

@synthesize strName=_strName,isFavorited=_isFavorited,btnFavorite;

-(id) initWithFrame:(CGRect)frame andStyle:(CDNavigationBarStyle )aStyle andTitle:(NSString *)aTitle{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *ivBackground = [[UIImageView alloc] initWithFrame:self.bounds];
        [ivBackground setImage:[UIImage imageNamed:@"navigationbar.png"]];
//        [ivBackground setImage:[UIImage imageNamed:@"buttonbar_edit.png"]];
        [self addSubview:ivBackground];
        [ivBackground release]; 
        
        /*
         UIButton *btnBegin = [[UIButton alloc] initWithFrame:(CGRect){CGRectGetMinX(labTimeUsed.frame),CGRectGetMaxY(labTimeUsed.frame) + 14.,100,78/2}];
         [btnBegin addTarget:self action:@selector(onBtnBeginClick:) forControlEvents:UIControlEventTouchUpInside];
         [btnBegin setShowsTouchWhenHighlighted:YES];
         [btnBegin setImage:[UIImage imageNamed:@"detail_start.png"] forState:UIControlStateNormal];
         [self.view addSubview:btnBegin];
         [btnBegin release];
         */
        
        
        UIButton *btnBack = [[UIButton alloc] initWithFrame:(CGRect){10,7,60,32}];
       
        [btnBack setBackgroundImage: [UIImage imageNamed:@"buttonbar_back.png"] forState:UIControlStateNormal];
         [btnBack setTitle:@"返回" forState:UIControlStateNormal];
        btnBack.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        btnBack.titleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
//        [btnBack setShowsTouchWhenHighlighted:YES];
        [btnBack addTarget:self action:@selector(onBtnBackClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
        [btnBack release];
        
        _labName = [[UILabel alloc] initWithFrame:(CGRect){CGRectGetWidth(btnBack.frame),7,kSize_Screen.width - CGRectGetWidth(btnBack.frame) * 2,CGRectGetHeight(btnBack.frame)}];
        [_labName setText:aTitle];
        [_labName setFont:[UIFont boldSystemFontOfSize:20.]];
        [_labName setBackgroundColor:kClearColor];
        [_labName setTextColor:[UIColor colorWithRed:61.0/255.0 green:144.0/255.0 blue:219.0/255.0 alpha:1]];
//        [_labName setShadowColor: [UIColor blackColor]]; 
        [_labName setTextAlignment:UITextAlignmentCenter];
        [self addSubview:_labName];
        [_labName release];
        
        
        if (aStyle < CDNavigationBarStyle_WithoutFavorite) {
            btnFavorite = [[UIButton alloc] initWithFrame:(CGRect){CGRectGetWidth(self.frame) - 55,7,45,32}];
            [btnFavorite setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
            [btnFavorite addTarget:self action:@selector(onBtnFavoriteClick:) forControlEvents:UIControlEventTouchUpInside];

            [btnFavorite setTitle:@"编辑" forState:UIControlStateNormal];
//            [btnFavorite setTitle:@"完成" forState:UIControlStateHighlighted];
            btnFavorite.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            btnFavorite.titleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
            [btnFavorite setTag:kTag_Favorite];
            [self addSubview:btnFavorite];
            [btnFavorite release];
        }
        
    }
    return self;
}

-(void) setBackBlock:(BackBlock )aBackBlock{
    [_back release];
    _back = [aBackBlock copy];
}

-(void) setFavoriteBlock:(FavoriteBlock )aFavoriteBlock{
    [_favorite release];
    _favorite = [aFavoriteBlock copy];
}

-(void) onBtnBackClick:(id)aSender{
    NSLog(@"dibakc..");
    if (_back) _back();
}

-(void) onBtnFavoriteClick:(id)aSender{
    if (_favorite) _favorite();
}

-(void) setTitle:(NSString *)aTitle{
    [self setStrName:aTitle];
    
    [_labName setText:_strName];
}

-(void) setIsFavorited:(BOOL)isFavorited{
    _isFavorited = isFavorited;
    
    if (_isFavorited) {
        UIButton *btnFavorites = (UIButton *)[self viewWithTag:kTag_Favorite];
        [btnFavorite setTitle:@"编辑" forState:UIControlStateNormal];
        btnFavorite.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        btnFavorite.titleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        if (btnFavorites) [btnFavorites setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
    }
    
    else {
        
        UIButton *btnFavorites = (UIButton *)[self viewWithTag:kTag_Favorite];
        if (btnFavorites){
            
            [btnFavorite setTitle:@"完成" forState:UIControlStateNormal];
            btnFavorite.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            btnFavorite.titleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
            [btnFavorites setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
        }

    }
}

-(void) dealloc{
    if (_back) [_back release];
    if (_favorite) [_favorite release];
    [super dealloc];
}

-(void) resetShowFrameWithoutRight:(BOOL)aWithoutRight{
    if (aWithoutRight) {
//        [_labName setFrame:(CGRect){_labName.frame.origin,CGRectGetWidth(_labName.frame) + 69,CGRectGetHeight(_labName.frame)}];
//        [_labName setTextAlignment:UITextAlignmentLeft];
    }
}

@end
