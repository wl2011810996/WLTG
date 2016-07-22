//
//  WLDockItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDockItem.h"

@implementation WLDockItem

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加顶部的分隔线
        UIImageView *divider = [[UIImageView  alloc] init];
        divider.frame = CGRectMake(0, 0, kDockItemW, 2);
        divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:divider];
        _divider = divider;
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemW, kDockItemH);
    [super setFrame:frame];
}

// 没有高亮状态
- (void)setHighlighted:(BOOL)highlighted { }

#pragma mark - 设置按钮内部的图片
- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    self.icon = icon;
    self.selectedIcon = selectedIcon;
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setSelectedIcon:(NSString *)selectedIcon
{
    _selectedIcon = selectedIcon;
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}

@end
