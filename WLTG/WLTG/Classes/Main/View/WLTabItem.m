//
//  WLTabItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLTabItem.h"

@implementation WLTabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置选中（disable）时的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    // 控制顶部分隔线要不要显示
    _divider.hidden = !enabled;
    
    [super setEnabled:enabled];
}

@end
