//
//  WLCategoryMenu.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCategoryMenu.h"
#import "WLMetaDataTool.h"
#import "WLCategoryMenuItem.h"
#import "WLCategory.h"
#import "WLSubtitlesView.h"

@implementation WLCategoryMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *categories = [WLMetaDataTool sharedWLMetaDataTool].totalCategories;
        
        int count = categories.count;
        
        for (int i = 0; i<count; i++) {
            WLCategoryMenuItem *item = [[WLCategoryMenuItem alloc]init];
            item.category = categories[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

- (void)settingSubtitlesView
{
    _subtitlesView.setTitleBlock = ^(NSString *title) {
        [WLMetaDataTool sharedWLMetaDataTool].currentCategory = title;
    };
    
    _subtitlesView.getTitleBlock =  ^{
        return [WLMetaDataTool sharedWLMetaDataTool].currentCategory;
    };
}

@end
