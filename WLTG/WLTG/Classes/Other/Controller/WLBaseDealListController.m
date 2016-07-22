//
//  WLBaseDealListController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLBaseDealListController.h"
#import "WLDeal.h"
#import "WLDealCell.h"
#import "WLCover.h"
#import "WLDealDetailController.h"
#import "UIBarButtonItem+MJ.h"
#import "WLNavigationController.h"

#define kItemW 250
#define kItemH 250
#define kDetailWidth 600

@interface WLBaseDealListController ()
{

}
@end

@implementation WLBaseDealListController
#pragma mark - 生命周期方法
- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kItemW, kItemH); // 每一个网格的尺寸
    layout.minimumLineSpacing = 20; // 每一行之间的间距
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.注册cell要用到的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"WLDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    
    // 2.设置collectionView永远支持垂直滚动(弹簧)
    self.collectionView.alwaysBounceVertical = YES;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    // 3.背景色
    self.collectionView.backgroundColor = kGlobalBg;
}

#pragma mark 在viewWillAppear和viewDidAppear中可以取得view最准确的宽高（width和height）
- (void)viewWillAppear:(BOOL)animated
{
    // 默认计算layout
    [self didRotateFromInterfaceOrientation:0];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 屏幕旋转完毕的时候调用
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // 1.取出layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    // 2.计算间距
    CGFloat v = 20;
    CGFloat h = 0;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) { // 横屏
        h = (self.view.frame.size.width - 3 * kItemW) / 4;
    } else {
        h = (self.view.frame.size.width - 2 * kItemW) / 3;
    }
    [UIView animateWithDuration:2.0 animations:^{
        layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);
    }];
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
}

#pragma mark 显示详情控制器
- (void)showDetail:(WLDeal *)deal
{
    // 1.显示遮盖
    if (_cover == nil) {
        _cover = [WLCover coverWithTarget:self action:@selector(hideDetail)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    // 2.展示团购详情控制器
    WLDealDetailController *detail = [[WLDealDetailController alloc] init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    WLNavigationController *nav = [[WLNavigationController alloc] initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    // 当2个控制器互为父子关系时，它们的view也是互为父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
}

#pragma mark 隐藏详情控制器
- (void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        // 1.隐藏遮盖
        _cover.alpha = 0;
        
        // 2.隐藏控制器
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

#pragma mark 刷新数据的时候会调用（reloadData）
#pragma mark 每当有一个cell重新进入屏幕视野范围内就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    WLDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = self.totalDeals[indexPath.row];
    
    return cell;
}
@end
