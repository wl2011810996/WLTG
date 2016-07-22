//
//  WLDealBottomMenu.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealBottomMenu.h"
#import "WLSubtitlesView.h"
#import "WLDealBottomMenuItem.h"
#import "WLCategoryMenuItem.h"
#import "WLDistrictMenuItem.h"
#import "WLMetaDataTool.h"

#import "WLOrderMenuItem.h"

#define kCoverAlpha 0.4
#define kDuration 1.0

@interface WLDealBottomMenu()
{
    
    UIView *_cover;
    
    UIView *_contentView;
}
@end

@implementation WLDealBottomMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 1.添加蒙板（遮盖）
        UIView *cover = [[UIView alloc]init];
        cover.alpha = kCoverAlpha;
        cover.frame = self.bounds;
        cover.autoresizingMask = self.autoresizingMask;
        cover.backgroundColor = [UIColor blackColor];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
        [self addSubview:cover];
        _cover = cover;
        
           // 2.内容view
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, 0,  self.frame.size.width, kBottomMeunItemH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _contentView.userInteractionEnabled = YES;
        [self addSubview:_contentView];
        
        // 3.添加UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMeunItemH);
        scrollView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return self;
}

#pragma mark 显示
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_scrollView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从上面 -> 下面
         _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        
        // 2.遮盖（0 -> 0.4）
        _cover.alpha = kCoverAlpha;
    }];
}


-(void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从下面 -> 上面
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_scrollView.frame.size.height);
        
        _contentView.alpha = 0;
        
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        
        // 恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha  = 1;
        _cover.alpha = kCoverAlpha;
    }];

}

- (void)itemClick:(WLDealBottomMenuItem *)item
{
    // 1.控制item的状态
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    
    
    if (item.titles.count) {
        
        // 显示所有的子标题
        [self showSubtitlesView:item];
    }else
    {
        //隐藏所有的子标题
        [self hideSubtitlesView:item];
    }
    
}

-(void)hideSubtitlesView:(WLDealBottomMenuItem *)item
{
    [self hide];
    
    CGRect f = _contentView.frame;
    f.size.height = kBottomMeunItemH;
    _contentView.frame = f;
    
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[WLCategoryMenuItem class]]) {
        [WLMetaDataTool sharedWLMetaDataTool].currentCategory = title;
    }else if ([item isKindOfClass:[WLDistrictMenuItem class]]) { // 区域
        [WLMetaDataTool sharedWLMetaDataTool].currentDistrict = title;
    } else { // 排序
        [WLMetaDataTool sharedWLMetaDataTool].currentOrder = [[WLMetaDataTool sharedWLMetaDataTool] orderWithName:title];
    }

    
}

-(void)showSubtitlesView:(WLDealBottomMenuItem *)item
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kDefaultAnimDuration];
    
    if (_subtitlesView == nil) {
        _subtitlesView = [[WLSubtitlesView alloc]init];
        [self settingSubtitlesView];
    }
    _subtitlesView.frame = CGRectMake(0,kBottomMeunItemH , self.frame.size.width, self.frame.size.height);
    _subtitlesView.titles = item.titles;
    
    if (_subtitlesView.superview == nil) {
        [_subtitlesView show];
    }
    
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    CGRect f = _contentView.frame;
    f.size.height = CGRectGetMaxY(_subtitlesView.frame);
    _contentView.frame = f;
    
    [UIView commitAnimations];

}

@end
