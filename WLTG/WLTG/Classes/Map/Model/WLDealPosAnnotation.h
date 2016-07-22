//
//  WLDealPosAnnotation.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/17.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class WLDeal,WLBusiness;

@interface WLDealPosAnnotation : NSObject

@property (nonatomic,assign)CLLocationCoordinate2D coordinate;

@property (nonatomic,strong)WLDeal *deal;

@property (nonatomic,strong)WLBusiness *business;

@property (nonatomic,copy)NSString *icon;

@end
