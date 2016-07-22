//
//  WLDistrictMenu.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDistrictMenu.h"
#import "WLDistrictMenuItem.h"
#import "WLMetaDataTool.h"
#import "WLCity.h"
#import "WlDistrict.h"
#import "WLSubtitlesView.h"

@interface WLDistrictMenu()
{
    NSMutableArray *_menuItems;
}

@end

@implementation WLDistrictMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self cityChange];
        // 监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];

    }
    return self;
}

-(void)cityChange{
    
    // 1.获取当前选中的城市
    WLCity *city = [WLMetaDataTool sharedWLMetaDataTool].currentCity;
    
    // 2.当前城市的所有区域
    NSMutableArray *districts = [NSMutableArray array];
    // 2.1.全部商区
    WLDistrict *all = [[WLDistrict alloc] init];
    all.name = kAllDistrict;
    [districts addObject:all];
    // 2.2.其他商区
    [districts addObjectsFromArray:city.districts];
    
    // 3.遍历所有的商区
    int count = districts.count;
    for (int i = 0; i<count; i++) {
        WLDistrictMenuItem *item = nil;
        if (i >= _menuItems.count) { // 不够
            item = [[WLDistrictMenuItem alloc] init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_menuItems addObject:item];
            [_scrollView addSubview:item];
        } else {
            item = _menuItems[i];
        }
        
        item.hidden = NO;
        item.district = districts[i];
        item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
        
        // 默认选中第0个item
        if (i == 0) {
            item.selected = YES;
            _selectedItem = item;
        } else {
            item.selected = NO;
        }
    }
    
    // 4.隐藏多余的item
    for (int i = count; i<_menuItems.count; i++) {
        WLDistrictMenuItem *item = _scrollView.subviews[i];
        item.hidden = YES;
    }
    
    // 5.设置scrollView的内容尺寸
    _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    
    // 6.隐藏子标题
    [_subtitlesView hide];
}

- (void)settingSubtitlesView
{
    _subtitlesView.setTitleBlock = ^(NSString *title) {
        [WLMetaDataTool sharedWLMetaDataTool].currentDistrict = title;
    };
    
    _subtitlesView.getTitleBlock =  ^{
        return [WLMetaDataTool sharedWLMetaDataTool].currentDistrict;
    };
}


@end
