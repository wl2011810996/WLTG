//
//  WLMainController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLMainController.h"
#import "WLDealListController.h"
#import "WLCollectController.h"
#import "WLMapController.h"
#import "WLMineController.h"
#import "WLNavigationController.h"
#import "WLDock.h"

@interface WLMainController ()<WLDockDelegate>{
    UIView *_contentView;
}

@end

@implementation WLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加Dock
    WLDock *dock = [[WLDock alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    dock.delegate = self;
    [self.view addSubview:dock];
    
    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - kDockItemW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemW, 0, w, h);
    [self.view addSubview:_contentView];
    
    // 3.添加子控制器
    [self addAllChildControllers];

    
}

#pragma mark 添加子控制器
- (void)addAllChildControllers
{
    // 1.团购
    WLDealListController *deal = [[WLDealListController alloc] init];
    WLNavigationController *nav = [[WLNavigationController alloc] initWithRootViewController:deal];
    [self addChildViewController:nav];
    
    // 2.地图
    WLMapController *map = [[WLMapController alloc] init];
    map.view.backgroundColor = [UIColor yellowColor];
    nav = [[WLNavigationController alloc] initWithRootViewController:map];
    [self addChildViewController:nav];
    
    // 3.收藏
    WLCollectController *collect = [[WLCollectController alloc] init];
    collect.view.backgroundColor = [UIColor greenColor];
    nav = [[WLNavigationController alloc] initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    // 4.我的
    WLMineController *mine = [[WLMineController alloc] init];
    mine.view.backgroundColor = [UIColor blueColor];
    nav = [[WLNavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:nav];
    
    // 5.默认选中团购控制器
    [self dock:nil tabChangeFrom:0 to:0];
}

#pragma mark 点击了Dock上的某个标签
- (void)dock:(WLDock *)dock tabChangeFrom:(int)from to:(int)to
{
    //    MyLog(@"w=%f, h=%f", self.view.frame.size.width, self.view.frame.size.height);
    
    // 1.先移除旧的
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    // 2.添加新的
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
}


@end
