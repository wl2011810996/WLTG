//
//  WLCollectTool.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCollectTool.h"
#import "WLDeal.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]

@interface WLCollectTool()
{
    NSMutableArray *_collectedDeals;
}

@end

@implementation WLCollectTool

singleton_implementation(WLCollectTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
        
    }
    return self;
}


-(void)handleDeal:(WLDeal *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

-(void)collectDeal:(WLDeal *)deal
{
    deal.collected = YES;
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

-(void)uncollectDeal:(WLDeal *)deal
{
    deal.collected = NO;
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}


@end
