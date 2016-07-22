//
//  WLSearchResultController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLSearchResultController.h"
#import "WLMetaDataTool.h"
#import "WLCity.h"
#import "PinYin4Objc.h"

@interface WLSearchResultController ()
{
    NSMutableArray *_resultCities;
}


@end

@implementation WLSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultCities = [NSMutableArray array];
}

-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    [_resultCities removeAllObjects];
    
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc]init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    NSDictionary *cities = [WLMetaDataTool sharedWLMetaDataTool].totalCities;
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString * key, WLCity * obj, BOOL *stop) {
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyingHeader = [NSMutableString string];
        for (NSString *word in words) {
            [pinyingHeader appendString:[word substringToIndex:1]];
        }
        
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        if (([obj.name rangeOfString:searchText].length != 0)||([pinyin rangeOfString:searchText.uppercaseString].length != 0||([pinyingHeader rangeOfString:searchText.uppercaseString].length != 0))) {
            [_resultCities addObject:obj];
        }
        
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark -- 代理方法实现

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  [NSString stringWithFormat:@"共%d个搜索结果",_resultCities.count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    WLCity *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCity *city = _resultCities[indexPath.row];
    [WLMetaDataTool  sharedWLMetaDataTool].currentCity = city;
}


@end
