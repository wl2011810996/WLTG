//
//  WLDealTopMenuItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealTopMenuItem.h"
#import "UIImage+MJ.h"


#define kTitleScale 0.8

@implementation WLDealTopMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        // 2.设置箭头
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 3.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kTopMenuItemH * 0.7);
        divider.center = CGPointMake(kTopMenuItemW, kTopMenuItemH * 0.5);
        [self addSubview:divider];
        
        // 4.选中时的背景
//        self.backgroundColor = [UIColor redColor];
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = contentRect.size.width * kTitleScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width * kTitleScale;
    CGFloat w = contentRect.size.width - x;
    return CGRectMake(x, 0, w, h);
}

@end
