//
//  WLCategory.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLBaseModel.h"

@interface WLCategory : WLBaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subcategories;

@end
