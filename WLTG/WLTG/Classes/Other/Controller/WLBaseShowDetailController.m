//
//  WLBaseShowDetailController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/17.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLBaseShowDetailController.h"

#import "WLCover.h"
#import "WLDealDetailController.h"
#import "UIBarButtonItem+MJ.h"
#import "WLNavigationController.h"

#define kDetailWidth 600

@interface WLBaseShowDetailController ()
{
    WLCover *_cover;
}

@end

@implementation WLBaseShowDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark 显示详情控制器
-(void)showDetail:(WLDeal *)deal
{
    if (_cover == nil) {
        _cover = [WLCover coverWithTarget:self action:@selector(hideDetail)];
    }
    
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    WLDealDetailController *detail = [[WLDealDetailController alloc]init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    WLNavigationController *nav = [[WLNavigationController alloc]initWithRootViewController:detail];
    // 监听拖拽
    [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
    
}

#pragma mark 隐藏详情控制器
-(void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0;
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
        
    }];
}

-(void)drag:(UIPanGestureRecognizer *)pan
{
    CGFloat tx = [pan translationInView:pan.view].x;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat halfW = pan.view.frame.size.width * 0.5;
        if (tx >= halfW) {
            [self hideDetail];
        }else{
            [UIView animateWithDuration:kDefaultAnimDuration animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    }else
    {
        if (tx<0) {
            tx *= 0.4;
        }
        pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
}

@end
