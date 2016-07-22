//
//  WLDealTool.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/11.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealTool.h"
#import "WLMetaDataTool.h"
#import "DPAPI.h"
#import "WLCity.h"
#import "WLDeal.h"
#import "WLOrder.h"
#import "NSObject+Value.h"

typedef void (^RequestBlock)(id result,NSError *errorObj);

@interface WLDealTool()<DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}

@end

@implementation WLDealTool

singleton_implementation(WLDealTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error
{
    [self requestWithURL:@"v1/deal/get_single_deal" params:@{
                                                             @"deal_id" : ID
                                                             } block:^(id result, NSError *errorObj) {
                                                                 if (result) { // 成功
                                                                     if (success) {
                                                                         WLDeal *deal = [[WLDeal alloc] init];
                                                                         [deal setValues:result[@"deals"][0]];
                                                                         success(deal);
                                                                     }
                                                                 } else { // 失败
                                                                     if (error) {
                                                                         error(errorObj);
                                                                     }
                                                                 }
                                                             }];
}


#pragma mark 获得第page页的团购数据
-(void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealErrorBlock)error
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(15) forKey:@"limit"];
    // 1.1.添加城市参数
    NSString *city = [WLMetaDataTool sharedWLMetaDataTool].currentCity.name;
    [params setObject:city forKey:@"city"];
    
    // 1.2.添加区域参数
    NSString *district = [WLMetaDataTool sharedWLMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:kAllDistrict]) {
        [params setObject:district forKey:@"region"];
    }
    
    // 1.3.添加分类参数
    NSString *category = [WLMetaDataTool sharedWLMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategory]) {
        [params setObject:category forKey:@"category"];
    }
    
    // 1.4.添加排序参数
    WLOrder *order = [WLMetaDataTool sharedWLMetaDataTool].currentOrder;
    if (order) {
        [params setObject:@(order.index) forKey:@"sort"];
    }
    
     // 1.5.添加页码参数
    [params setObject:@(page) forKey:@"page"];
    
    // 2.发送请求
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {
        if (errorObj) {
            if (error) {
                error(errorObj);
            }
        }else if (success)
        {
            NSArray *array = result[@"deals"];
            NSMutableArray *deals = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                WLDeal *deal=[[WLDeal alloc]init];
                [deal setValues:dict];
                [deals addObject:deal];
            }
            success(deals,[result[@"total_count"]intValue]);
        }
    }];
    
    
}

#pragma mark 封装了点评的任何请求
-(void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    [_blocks setObject:block forKey:request.description];
}

#pragma mark - 大众点评的请求方法代理
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result,nil);
    }
}


-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil,error);
    }
}

@end
