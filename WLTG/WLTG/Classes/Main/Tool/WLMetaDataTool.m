//
//  WLMetaDataTool.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLMetaDataTool.h"
#import "WLCitySection.h"
#import "NSObject+Value.h"
#import "WLCity.h"
#import "WLCategory.h"
#import "WLOrder.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface WLMetaDataTool()
{
    NSMutableArray *_visitedCityNames;
    NSMutableDictionary *_totalCities;
    WLCitySection *_visitedSection;
}

@end

@implementation WLMetaDataTool

singleton_implementation(WLMetaDataTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
         // 初始化项目中的所有元数据
        
        
        // 1.初始化城市数据
        [self loadCityData];

        // 2.初始化分类数据
        [self loadCategoryData];
        
        // 3.初始化排序数据
        [self loadOrderData];
    }
    return self;
}

-(void)loadOrderData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders.plist" ofType:nil]];
    int count = array.count;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<count; i++){
        WLOrder *o = [[WLOrder alloc] init];
        o.name = array[i];
        o.index = i;
        [temp addObject:o];
    }
    
    _totalOrders = temp;
}

#pragma mark通过非累名称去的图标
-(NSString *)iconWithCategoryName:(NSString *)name
{
    for (WLCategory *c  in _totalCategories) {
        if ([c.name isEqualToString:name]) {
            return c.icon;
        }
        
        if ([c.subcategories containsObject:name]) {
            return c.icon;
        }
        
    }
    return nil;
}

-(WLOrder *)orderWithName:(NSString *)name
{
    for (WLOrder *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            return order;
        }
    }
    return nil;
}

-(void)loadCategoryData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    WLCategory *all = [[WLCategory alloc]init];
    all.name = kAllCategory;
    all.icon = @"ic_filter_category_-1.png";
    [temp addObject:all];
    
    for (NSDictionary *dict in array) {
        WLCategory *c = [[WLCategory alloc] init];
        [c setValues:dict];
        [temp addObject:c];
    }
    
    _totalCategories = temp;
}


-(void)loadCityData
{
    _totalCities = [NSMutableDictionary dictionary];
    NSMutableArray *tempSections = [NSMutableArray array];
    
    WLCitySection *hotSection = [[WLCitySection alloc]init];
    hotSection.name = @"热门城市";
    hotSection.cities = [NSMutableArray array];
    [tempSections addObject:hotSection];
    
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    for (NSDictionary *azDict in azArray) {
        WLCitySection *section = [[WLCitySection alloc]init];
        [section setValues:azDict];
        [tempSections addObject:section];
        
        for (WLCity *city in  section.cities) {
            if (city.hot) {
                [hotSection.cities addObject:city];
            }
            
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    WLCitySection *visitedSection = [[WLCitySection alloc]init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        WLCity *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedCityNames.count) {
        [tempSections insertObject:visitedSection atIndex:0];
    }
    
    _totalCitySections = tempSections;
}
-(void)setCurrentCity:(WLCity *)currentCity
{
    _currentCity = currentCity;
    
    _currentDistrict = kAllDistrict;
    
    [_visitedCityNames removeObject:currentCity.name];
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kCityChangeNote object:nil];
     
    if (![_totalCitySections containsObject:_visitedCityNames]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
    
    
}

- (void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}

- (void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}

- (void)setCurrentOrder:(WLOrder *)currentOrder
{
    _currentOrder = currentOrder;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}

@end
