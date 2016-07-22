//
//  WLBuyDock.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLDeal, WLCenterLineLabel;
@interface WLBuyDock : UIView

@property (weak, nonatomic) IBOutlet WLCenterLineLabel *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;

@property (nonatomic, strong) WLDeal *deal;

+ (id)buyDock;

@end
