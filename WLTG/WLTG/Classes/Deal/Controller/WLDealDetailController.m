//
//  TGDealDetailController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealDetailController.h"
#import "WLDeal.h"
#import "UIBarButtonItem+MJ.h"
#import "WLBuyDock.h"
#import "WLDetailDock.h"

#import "WLDealWebController.h"
#import "WLDealInfoController.h"
#import "WLMerchantController.h"

#import "WLCollectTool.h"

@interface WLDealDetailController ()<WLDetailDockDelegate>
{
    WLDetailDock *_detailDock;
}
@end

@implementation WLDealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.基本设置
    [self baseSetting];
    
    // 2.添加顶部的购买栏
    [self addBuyDock];
    
    // 3.添加右边的选项卡栏
    [self addDetailDock];
    
    // 4.初始化子控制器
    [self addAllChildControllers];
    
}
#pragma mark 初始化子控制器
- (void)addAllChildControllers
{
     // 1.团购简介
    WLDealInfoController *info = [[WLDealInfoController alloc]init];
    info.deal = _deal;
//    info.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:info];
    [self detailDock:nil btnClickFrom:0 to:0];
    
    // 2.图文详情
    WLDealWebController *web = [[WLDealWebController alloc]init];
    web.deal = _deal;
    [self addChildViewController:web];
    
    // 3.商家详情
    WLMerchantController *merchant = [[WLMerchantController alloc] init];
    merchant.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:merchant];
    
}


-(void)addDetailDock
{
    WLDetailDock  *dock = [WLDetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height - size.height - 100;
    dock.frame = CGRectMake(x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}

-(void)addBuyDock
{
    WLBuyDock *dock = [WLBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    [self.view addSubview:dock];
    
}


-(void)baseSetting
{
    // 1.背景色
    self.view.backgroundColor = kGlobalBg;
    
    // 2.设置标题
    self.title = _deal.title;
    
    // 3.处理团购的收藏属性
    [[WLCollectTool sharedWLCollectTool] handleDeal:_deal];
    
    // 4.右上角的按钮
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
                                                [UIBarButtonItem itemWithIcon:collectIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collect)]];
}

-(void)collect
{
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    if (_deal.collected) { // 取消
        [[WLCollectTool sharedWLCollectTool] uncollectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    } else { // 收藏
        [[WLCollectTool sharedWLCollectTool] collectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    }
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
}

#pragma mark - dock的代理方法
-(void)detailDock:(WLDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    new.view.frame = CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}





@end
