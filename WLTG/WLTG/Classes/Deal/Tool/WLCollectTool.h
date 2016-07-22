//
//  WLCollectTool.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class WLDeal;
@interface WLCollectTool : NSObject

singleton_interface(WLCollectTool)

// 获得所有的收藏信息
@property (nonatomic, strong, readonly) NSArray *collectedDeals;

// 处理团购是否收藏
- (void)handleDeal:(WLDeal *)deal;

// 添加收藏
- (void)collectDeal:(WLDeal *)deal;

// 取消收藏
- (void)uncollectDeal:(WLDeal *)deal;


@end
