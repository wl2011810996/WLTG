//
//  WLCenterLineLabel.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCenterLineLabel.h"

@implementation WLCenterLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.textColor setStroke];
    
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    CGContextStrokePath(ctx);
}

@end
