//
//  WLMoreItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLMoreItem.h"
#import "WLMoreController.h"
#import "WLNavigationController.h"

@implementation WLMoreItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 2.设置图片
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        
        // 3.监听点击
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)moreClick
{
    self.enabled = NO;
    
    // 弹出更多控制器
    WLMoreController *more = [[WLMoreController alloc] init];
    more.moreItem = self;
    WLNavigationController *nav = [[WLNavigationController alloc] initWithRootViewController:more];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}


@end
