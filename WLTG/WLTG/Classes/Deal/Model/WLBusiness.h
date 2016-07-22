//
//  WLBusiness.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/17.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLBusiness : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;

@end
