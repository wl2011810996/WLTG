//
//  WLCategoryMenuItem.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealBottomMenuItem.h"
@class WLCategory;
@interface WLCategoryMenuItem : WLDealBottomMenuItem
// 需要显示的分类数据
@property (nonatomic, strong) WLCategory *category;
@end
