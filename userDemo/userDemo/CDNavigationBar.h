//
//  CDNavigationBar.h
//  DouDouSiFangCai
//
//  Created by hzs on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BackBlock) ();
typedef void (^FavoriteBlock) ();

typedef enum{
    CDNavigationBarStyle_Normal,
    CDNavigationBarStyle_WithoutFavorite,
}CDNavigationBarStyle;

@interface CDNavigationBar : UIView{
    BackBlock _back;
    FavoriteBlock _favorite;
    NSString *_strName;
    UIButton *btnFavorite;
    UILabel *_labName;
    
    BOOL _isFavorited;
}
@property (nonatomic,retain) UIButton *btnFavorite;
@property (nonatomic, copy) NSString *strName;
@property (nonatomic, assign) BOOL isFavorited;

-(id) initWithFrame:(CGRect)frame andStyle:(CDNavigationBarStyle )aStyle  andTitle:(NSString *)aTitle;

-(void) setTitle:(NSString *)aTitle;

-(void) setBackBlock:(BackBlock )aBackBlock;
-(void) setFavoriteBlock:(FavoriteBlock )aFavoriteBlock;

-(void) resetShowFrameWithoutRight:(BOOL )aWithoutRight;

@end
