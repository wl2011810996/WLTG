//
//  WLCitySection.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCitySection.h"
#import "WLCity.h"
#import "NSObject+Value.h"

@implementation WLCitySection


-(void)setCities:(NSMutableArray *)cities
{
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        _cities = cities;
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        WLCity *city = [[WLCity alloc]init];
        [city setValues:dict];
        [array addObject:city];
    }
    _cities = array;
}


@end
