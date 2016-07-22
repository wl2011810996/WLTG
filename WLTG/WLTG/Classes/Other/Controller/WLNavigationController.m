//
//  WLNavigationController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLNavigationController.h"
#import "UIImage+MJ.h"


@interface WLNavigationController ()

@end

@implementation WLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark 第一次使用这个类的使用调一次
+ (void)initialize
{
    // 1.appearance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];

//    // 2.设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航栏文字的主题
    [bar setTitleTextAttributes:@{
                                  UITextAttributeTextColor : [UIColor blackColor],
                                  UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                  }];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 修改item的背景图片
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 修改item上面的文字样式
    NSDictionary *dict = @{
                           UITextAttributeTextColor : [UIColor darkGrayColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           UITextAttributeFont : [UIFont systemFontOfSize:16]
                           };
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}



@end
