//
//  WLDealTool.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/11.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class WLDeal;
// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals,int totalCount);
typedef void (^DealErrorBlock)(NSError *error);

// deals里面装的都是模型数据
typedef void (^DealSuccessBlock)(WLDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);

@interface WLDealTool : NSObject

singleton_interface(WLDealTool)

#pragma mark 获得第page页的团购数据
-(void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealErrorBlock)error;


#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

@end
