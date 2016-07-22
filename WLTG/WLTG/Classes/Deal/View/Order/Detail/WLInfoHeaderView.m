//
//  WLInfoHeaderVIew.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/14.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLInfoHeaderVIew.h"
#import "WLDeal.h"
#import "WLImageTool.h"
#import "WLRestriction.h"
#import "NSDate+MJ.h"



@implementation WLInfoHeaderView

- (void)setDeal:(WLDeal *)deal
{
    _deal = deal;
    
    if (deal.restrictions) { // 有约束（完整的数据）
        // 1.设置是否支持退款
        _anyTimeBack.enabled = deal.restrictions.is_refundable;
        _expireBack.enabled = _anyTimeBack.enabled;
    } else { // 不完整的数据
        // 2.下载图片
        [WLImageTool downLoadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
        
        // 3.设置剩余时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
        // 2013-11-17
        NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
        // 2013-11-18 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        // 2013-11-17 10:50
        NSDate *now = [NSDate date];
        
        //    NSDateComponents *cmps = [NSDate compareFrom:now to:dealline];
        
        NSDateComponents *cmps = [now compare:dealline];
        
        NSString *timeStr = [NSString stringWithFormat:@"%d 天 %d 小时 %d 分钟", cmps.day, cmps.hour, cmps.minute];
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
    
    // 4.购买人数
    NSString *pc = [NSString stringWithFormat:@"%d 人已购买", deal.purchase_count];
    [_purchaseCount setTitle:pc forState:UIControlStateNormal];
    
    // 5.设置描述
    _desc.text = deal.desc;
    // 描述的高度
    CGFloat descH = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height + 20;
    CGRect descF = _desc.frame;
    
    CGFloat descDeltaH = descH - descF.size.height;
    
    descF.size.height = descH;
    _desc.frame = descF;
    
    // 6.设置整体的高度
    CGRect selfF = self.frame;
    selfF.size.height += descDeltaH;
    self.frame = selfF;
}


+ (id)infoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WLInfoHeaderView" owner:nil options:nil][0];
}


@end
