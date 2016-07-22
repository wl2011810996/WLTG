//
//  WLBuyDock.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLBuyDock.h"

#import "WLDeal.h"
#import "UIImage+MJ.h"
#import "WLCenterLineLabel.h"

@implementation WLBuyDock



- (void)setdeal:(WLDeal *)deal
{
    _deal = deal;
    
    _listPrice.text = [NSString stringWithFormat:@"%@ 元", deal.list_price_text];
    _currentPrice.text = deal.current_price_text;
}

+ (id)buyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"WLBuyDock" owner:nil options:nil][0];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}
@end
