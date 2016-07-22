//
//  WLDealWebController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDealWebController.h"
#import "WLDeal.h"

@interface WLDealWebController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_cover;
}

@end

@implementation WLDealWebController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //url	__NSCFString *	@"http://m.dianping.com/tuan/deal/moreinfo/6135829"	0x00007f85d4125130
    //http://m.dianping.com/tuan/deal/moreinfo/_deal_id	NSTaggedPointerString *	@"4-6135829"	0xa1cbac79faeaa319
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}


#pragma mark 拦截webView的所有请求
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    _cover = [[UIView alloc] init];
//    _cover.frame = webView.bounds;
//    _cover.backgroundColor = kGlobalBg;
//    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [webView addSubview:_cover];
//    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    CGFloat x = _cover.frame.size.width * 0.5;
//    CGFloat y = _cover.frame.size.height * 0.5;
//    indicator.center = CGPointMake(x, y);
//    [_cover addSubview:indicator];
//    [indicator startAnimating];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    // 0.删除scrollView顶部和底部灰色的view
//    for (UIView *view in webView.scrollView.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            [view removeFromSuperview];
//        }
//    }
//    
    CGFloat height = 70;
    webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    webView.scrollView.contentOffset = CGPointMake(0, -height);
//
//    // 1.拼接脚本
//    NSMutableString *script = [NSMutableString string];
//    // 1.1.取出body
//    [script appendString:@"var body = document.body;"];
//    // 1.2.取出section
//    [script appendString:@"var section = document.getElementById('J_section');"];
//    // 1.3.清空body
//    [script appendString:@"body.innerHTML = '';"];
//    // 1.4.添加section到body
//    [script appendString:@"body.appendChild(section);"];
//    
//    // 2.执行脚本
//    [webView stringByEvaluatingJavaScriptFromString:script];
    
    
//    // 3.移除遮盖
//    [_cover removeFromSuperview];
//    _cover = nil;
//    
    
    //    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"(document.getElementsByTagName('html')[0]).innerHTML"];
    //
    //    MyLog(@"\n%@", str);
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    MyLog(@"%@ - %@", _deal.deal_id, request.URL);
//    return YES;
//}




@end
