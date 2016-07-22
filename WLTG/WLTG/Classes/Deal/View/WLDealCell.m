//
//  TGDealCell.m
//  团购
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "WLDealCell.h"
#import "WLDeal.h"
#import "WLImageTool.h"

@implementation WLDealCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDeal:(WLDeal *)deal
{
    _deal = deal;
    
    // 1.设置描述
    _desc.text = deal.desc;
    
    // 2.下载图片
    [WLImageTool downLoadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    // 3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d", deal.purchase_count] forState:UIControlStateNormal];
    
    // 4.价格
    _price.text = [NSString stringWithFormat:@"%.f", deal.current_price];
    
    // 5.标签
    // 5.1.获得当前时间字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    
    // 5.2.比较当前时间
    NSString *icon = nil;
    if ([deal.publish_date isEqualToString:now]) {
        icon = @"ic_deal_new.png";
    } else if ([deal.purchase_deadline isEqualToString:now]) {
        icon = @"ic_deal_soonOver.png";
    } else if ([deal.purchase_deadline compare:now] == NSOrderedAscending) {
        icon = @"ic_deal_over.png";
    }
    
    _badge.hidden = icon == nil;
    _badge.image = [UIImage imageNamed:icon];
    
}

@end
