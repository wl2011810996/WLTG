//
//  WLOrderMenu.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLOrderMenu.h"
#import "WLMetaDataTool.h"
#import "WLOrderMenuItem.h"


@implementation WLOrderMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1.往UIScrollView添加内容
        NSArray *orders = [WLMetaDataTool sharedWLMetaDataTool].totalOrders;
        int count = orders.count;
        
        for (int i = 0; i<count; i++) {
            // 创建排序item
            WLOrderMenuItem *item = [[WLOrderMenuItem alloc] init];
            item.order = orders[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

@end
