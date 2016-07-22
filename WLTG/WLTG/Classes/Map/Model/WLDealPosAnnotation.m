//
//  WLDealPosAnnotation.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/17.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealPosAnnotation.h"
#import "WLMetaDataTool.h"
#import "WLDeal.h"

@implementation WLDealPosAnnotation

-(void)setDeal:(WLDeal *)deal
{
    _deal = deal;
    
    for (NSString *c  in deal.categories) {
        NSString *icon =  [[WLMetaDataTool sharedWLMetaDataTool]iconWithCategoryName:c];
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
        }
    }
    
}

@end
