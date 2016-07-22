//
//  WLRestriction.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/14.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRestriction : NSObject

@property (nonatomic, assign) BOOL is_reservation_required; // 是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable; // 是否支持随时退款，0：不是，1：是
@property (nonatomic, copy) NSString * special_tips; // （购买须知）附加信息(一般为团购信息的特别提示)

@end
