//
//  Weibocell.m
//  userDemo
//
//  Created by yangyong on 12-12-28.
//  Copyright (c) 2012年 yangyong. All rights reserved.
//

#import "Weibocell.h"
#import <QuartzCore/QuartzCore.h>
@implementation Weibocell
@synthesize imageView,nameLable,btn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
 self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        self.layer.borderWidth=1.0;
        self.layer.borderColor=[[UIColor colorWithRed:210.0/255.0 green:216.0/255.0 blue:221.0/255.0 alpha:1]CGColor];
        imagView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 40, 40)];
        imagView.backgroundColor = [UIColor clearColor];
        imagView.image = [UIImage imageNamed:@"IAppFree.png"];
        CALayer * layer = [imagView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:10.0];
        [self addSubview:imagView];
        nameLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 150, 30)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:nameLable];
        btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"choice.png"] forState:0];
       
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(250, 5, 40, 40);
       
        [self addSubview:btn];
    }
    return self;
}
- (UIImageView *) getImageView
{
    return imagView;
}
- (void) setImageView:(UIImage*)imge
{
    imagView.image = imge;
}
- (void)clicked:(id)sender
{
    static int  i = 0;
    if (i %2 == 0) {
         [btn setImage:[UIImage imageNamed:@"choice.png"] forState:0];
    }else{
        [btn setImage:[UIImage imageNamed:@"un_choice.png"] forState:0];

    }
    i ++;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
