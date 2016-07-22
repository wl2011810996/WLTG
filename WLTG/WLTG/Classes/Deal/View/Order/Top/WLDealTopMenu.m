//
//  WLDealTopMenu.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealTopMenu.h"
#import "WLDealTopMenuItem.h"
#import "WLCategoryMenu.h"
#import "WLDistrictMenu.h"
#import "WLOrderMenu.h"
#import "WLMetaDataTool.h"
#import "WLOrderMenu.h"
#import "WLOrder.h"


@interface WLDealTopMenu()
{
    WLDealTopMenuItem *_selectedItem;
    
    WLCategoryMenu *_cMenu; // 分类菜单
    WLDistrictMenu *_dMenu; // 区域菜单
    WLOrderMenu *_oMenu; // 排序菜单
    
    WLDealBottomMenu *_showingMenu; // 正在展示的底部菜单
    
    WLDealTopMenuItem *_cItem;
    WLDealTopMenuItem *_dItem;
    WLDealTopMenuItem *_oItem;
}

@end

@implementation WLDealTopMenu

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(3 * kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 1.全部分类
       _cItem = [self addMenuItem:@"全部分类" index:0];
        
        // 2.全部商区
       _dItem = [self addMenuItem:@"全部商区" index:1];
        
        // 3.默认排序
       _oItem = [self addMenuItem:@"默认排序" index:2];
        
        // 4.监听通知
        kAddAllNotes(dataChange)

    }
    return self;
}



- (void)dataChange
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    NSString *c = [WLMetaDataTool sharedWLMetaDataTool].currentCategory;
    if (c) {
        _cItem.title = c;
    }
    
    
    // 2.商区按钮
    NSString *d = [WLMetaDataTool sharedWLMetaDataTool].currentDistrict;
    if (d) {
        _dItem.title = d;
    }
    
    // 3.排序按钮
    NSString *o = [WLMetaDataTool sharedWLMetaDataTool].currentOrder.name;
    if (o) {
        _oItem.title = o;
    }
    [_showingMenu hide];
    _showingMenu = nil;
    
}

#pragma mark 添加一个菜单项
- (WLDealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    WLDealTopMenuItem *item = [[WLDealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    return item;
}

-(void)itemClick:(WLDealTopMenuItem *)item
{
    
    if ([WLMetaDataTool sharedWLMetaDataTool].currentCity == nil) {
        return;
    }
    
    _selectedItem.selected = NO;
    
    // 移除当前正在显示的菜单
    [_showingMenu removeFromSuperview];
    
    if (_selectedItem == item) {
        _selectedItem = nil;
        
        [self hideBottomMenu];
        
    }else{
        item.selected = YES;
        _selectedItem = item;
        
        // 显示底部菜单
        [self showBottomMenu:item];

    }
}

-(void)showBottomMenu:(WLDealTopMenuItem *)item
{
    BOOL animted = _showingMenu == nil;
    // 显示底部菜单
    if (item.tag == 0) { // 分类
        if (_cMenu == nil) {
            _cMenu = [[WLCategoryMenu alloc] init];
        }
        _showingMenu = _cMenu;
    } else if (item.tag == 1) { // 区域
        if (_dMenu == nil) {
            _dMenu = [[WLDistrictMenu alloc] init];
        }
        _showingMenu = _dMenu;
    } else { // 排序
        if (_oMenu == nil) {
            _oMenu = [[WLOrderMenu alloc] init];
        }
        _showingMenu = _oMenu;
    }
    // 设置frame
    _showingMenu.frame = _contentView.bounds;
    __unsafe_unretained WLDealTopMenu *menu = self;
    _showingMenu.hideBlock = ^{
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        
        menu->_showingMenu = nil;
        
    };
    
    [_contentView addSubview:_showingMenu];
    
    if (animted) {
        [_showingMenu show];
    }
    

}

-(void)hideBottomMenu
{
    [_showingMenu hide];
    _showingMenu = nil;
}

@end
