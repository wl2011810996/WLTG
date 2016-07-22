//
//  WLDealBottomMenuItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealBottomMenuItem.h"
#import "UIImage+MJ.h"

@interface WLDealBottomMenuItem()




@end


@implementation WLDealBottomMenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kBottomMeunItemH * 0.7);
        divider.center = CGPointMake(kBottomMenuItemW, kBottomMeunItemH * 0.5);
        [self addSubview:divider];
        
        // 2.文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        // 3.设置被选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemW, kBottomMeunItemH);
    [super setFrame:frame];
}

-(NSArray *)titles
{
    return nil;
}



@end
