//
//  WLDealListController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealListController.h"
#import "WLDealTopMenu.h"
#import "DPAPI.h"
#import "WLMetaDataTool.h"
#import "WLDeal.h"
#import "WLCity.h"
#import "NSObject+Value.h"
#import "MJRefresh.h"
#import "WLDealCell.h"
#import "WLDealTool.h"
#import "WLImageTool.h"

#import "UIBarButtonItem+MJ.h"
#import "WLCover.h"
#import "WLDealDetailController.h"
#import "WLNavigationController.h"


#define kItemW 250
#define kItemH 250


@interface WLDealListController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page; // 页码
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;

}


@end

@implementation WLDealListController

- (NSArray *)totalDeals
{
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.基本设置
    [self baseSetting];
    
    // 2.添加刷新控件
    [self addRefresh];

}

-(void)addRefresh
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
}


#pragma mark - 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) { // 下拉刷新
        // 清除图片缓存
        [WLImageTool clear];
        _page = 1; // 第一页
    } else { // 上拉加载更多
        _page++;
    }
    
    // 加载第_page页的数据
    [[WLDealTool sharedWLDealTool] dealsWithPage:_page success:
     ^(NSArray *deals, int totalCount) {
         if (isHeader) {
             _deals = [NSMutableArray array];
         }
         // 1.添加数据
         [_deals addObjectsFromArray:deals];
         
         // 2.刷新表格
         [self.collectionView reloadData];
         
         // 3.恢复刷新状态
         [refreshView endRefreshing];
         
         // 4.根据数量判断是否需要隐藏上拉控件
         _footer.hidden = _deals.count >= totalCount;
     } error:^(NSError *error) {
         [refreshView endRefreshing];
     }];
}

-(void)baseSetting
{
    // 1.监听城市改变的通知
    kAddAllNotes(dataChange)
    
    self.collectionView.backgroundColor = kGlobalBg;
    
    UISearchBar *s = [[UISearchBar alloc]init];
    s.frame = CGRectMake(0, 0, 210, 35);
    s.placeholder = @"请输入商品名、地址等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:s];
    
    
    WLDealTopMenu *top =[[WLDealTopMenu alloc]init];
    top.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:top];
}

- (void)dataChange
{
    [_header beginRefreshing];
}






@end
