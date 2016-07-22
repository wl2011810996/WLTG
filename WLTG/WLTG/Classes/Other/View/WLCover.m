//
//  WLCover.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCover.h"

#define kAlpha 0.6

@implementation WLCover

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        self.alpha = kAlpha;
    }
    return self;
}

-(void)reset
{
    self.alpha = kAlpha;
}


+(instancetype)cover
{
    return [[self alloc]init];
}

+(instancetype)coverWithTarget:(id)target action:(SEL)action
{
    WLCover *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
    
    return cover;
}

@end
