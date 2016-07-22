
//
//  WLDealInfoController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealInfoController.h"
#import "WLInfoHeaderView.h"
#import "WLDealTool.h"
#import "WLDeal.h"
#import "WLInfoTextView.h"
#import "WLRestriction.h"


#define kVMargin 15

@interface WLDealInfoController ()
{
    UIScrollView *_scrollView;
    
    WLInfoHeaderView *_header;
}
@end

@implementation WLDealInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加滚动视图
    [self addScrollView];
    
    // 2.添加头部控件
    [self addHeaderView];
    
    // 3.加载更详细的团购数据
    [self performSelector:@selector(loadDetailDeal) withObject:nil afterDelay:2];
}


#pragma mark 加载更详细的团购数据
- (void)loadDetailDeal
{
    [[WLDealTool sharedWLDealTool]dealWithID:_deal.deal_id success:^(WLDeal *deal) {
        _deal = deal;
        // 添加详情数据
        
        _header.deal = deal;
        
        [self addDetailViews];
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark 添加详情数据（其他控件）
- (void)addDetailViews
{
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_header.frame) + kVMargin);
    
    // 1.团购详情
    [self addTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    
    // 2.购买须知
    [self addTextView:@"ic_tip.png" title:@"购买须知" content:_deal.restrictions.special_tips];
    
    // 3.重要通知
    [self addTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];
}


-(void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) {
        return;
    }
    
    WLInfoTextView *textView = [WLInfoTextView infoTextView];
    
    CGFloat y = _scrollView.contentSize.height;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    textView.frame = CGRectMake(0, y, w, h);
    
    textView.title = title;
    textView.content = content;
    textView.icon = icon;
    
    [_scrollView addSubview:textView];
    
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame)+kVMargin);
}

#pragma mark 添加头部控件
- (void)addHeaderView
{
    WLInfoHeaderView *header = [WLInfoHeaderView infoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, header.frame.size.height);
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounds = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width * 0.5;
    CGFloat y = self.view.frame.size.height * 0.5;
    scrollView.center = CGPointMake(x, y);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
    CGFloat height = 70;
    scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -height);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

@end
