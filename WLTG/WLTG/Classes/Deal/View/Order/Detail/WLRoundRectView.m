//
//  WLRoundRectView.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/14.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLRoundRectView.h"
#import "UIImage+MJ.h"

@implementation WLRoundRectView

- (void)drawRect:(CGRect)rect {
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}


@end
