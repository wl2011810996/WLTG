//
//  WLMetaDataTool.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class WLCity;
@class WLOrder;

@interface WLMetaDataTool : NSObject

singleton_interface(WLMetaDataTool)

@property (nonatomic,strong,readonly)NSDictionary *totalCities; // 所有的城市
@property (nonatomic,strong,readonly)NSArray *totalCitySections;// 所有的城市组数据


@property (nonatomic,strong)WLCity *currentCity;// 当前选中的城市

@property (nonatomic, strong, readonly) NSArray *totalCategories; // 所有的分类数据


-(WLOrder *)orderWithName:(NSString *)name;

-(NSString *)iconWithCategoryName:(NSString *)name;


// 所有的排序数据
@property (nonatomic, strong, readonly) NSArray *totalOrders;

@property (nonatomic, strong) NSString *currentCategory; // 当前选中的类别
@property (nonatomic, strong) NSString *currentDistrict; // 当前选中的区域
@property (nonatomic, strong) WLOrder *currentOrder; // 当前选中的排序

@end
