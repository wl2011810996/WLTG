//
//  WLOrderMenuItem.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealBottomMenuItem.h"

@class WLOrder;
@interface WLOrderMenuItem : WLDealBottomMenuItem
@property (nonatomic,strong)WLOrder *order;
@end
