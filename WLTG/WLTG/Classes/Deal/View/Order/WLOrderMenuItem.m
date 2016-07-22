//
//  WLOrderMenuItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLOrderMenuItem.h"
#import "WLOrder.h"

@implementation WLOrderMenuItem

- (void)setOrder:(WLOrder *)order
{
    _order = order;
    
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
