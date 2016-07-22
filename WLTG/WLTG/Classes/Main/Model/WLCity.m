//
//  WLCity.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCity.h"
#import "WLDistrict.h"
#import "NSObject+Value.h"

@implementation WLCity

-(void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        WLDistrict *district = [[WLDistrict alloc]init];
        [district setValues:dict];
        [array addObject:district];
    }
    _districts = array;
}

@end
