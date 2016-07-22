//
//  WLDealBottomMenu.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLSubtitlesView;
@class WLDealBottomMenuItem;

@interface WLDealBottomMenu : UIView
{
    UIScrollView *_scrollView;
    
    WLSubtitlesView *_subtitlesView;
    
    WLDealBottomMenuItem *_selectedItem;
}

@property (nonatomic,copy)void (^hideBlock)();

- (void)itemClick:(WLDealBottomMenuItem *)item;

- (void)settingSubtitlesView;


// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;

@end
