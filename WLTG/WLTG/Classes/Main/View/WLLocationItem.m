//
//  WLLocationItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLLocationItem.h"
#import "WLCityListController.h"
#import "WLCity.h"
#import "WLMetaDataTool.h"

#define kImageScale 0.5

@interface WLLocationItem() <UIPopoverControllerDelegate>
{
    UIPopoverController *_popover;
}
@end

@implementation WLLocationItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置内部的图片
        [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
        
        // 2.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 3.设置默认的文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // 4.设置图片属性
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 5.监听点击
        [self addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
        
        //        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
        
    }
    return self;
}


-(void)cityChange
{
    WLCity *city = [WLMetaDataTool sharedWLMetaDataTool].currentCity;
    
    [self setTitle:city.name forState:UIControlStateNormal];
    
    [_popover dismissPopoverAnimated:YES];
    
    self.enabled = YES;
    
}

- (void)screenRotate
{
    if (_popover.popoverVisible) {
        // 1.关闭之前的
        [_popover dismissPopoverAnimated:NO];
        
        // 2.0.5秒后创建新的
        [self performSelector:@selector(showPopover) withObject:nil afterDelay:0.5];
    }
}

-(void)showPopover
{
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (void)locationClick
{
    WLCityListController *city = [[WLCityListController alloc] init];
    city.view.backgroundColor = [UIColor redColor];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:city];
    _popover.popoverContentSize = CGSizeMake(320, 640);
    _popover.delegate = self;
    [self showPopover];
    
    // 监听屏幕旋转的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}




- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    // popover被销毁的时候，移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * kImageScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}


@end
