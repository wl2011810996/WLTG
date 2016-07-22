//
//  WLInfoHeaderVIew.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/14.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLRoundRectView.h"
@class WLDeal;
@interface WLInfoHeaderView : WLRoundRectView

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;
@property (weak, nonatomic) IBOutlet UIButton *expireBack;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@property (nonatomic,strong)WLDeal *deal;
+(id)infoHeaderView;

@end
