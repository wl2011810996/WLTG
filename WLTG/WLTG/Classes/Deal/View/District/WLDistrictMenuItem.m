//
//  WLDistrictMenuItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDistrictMenuItem.h"
#import "WLDistrict.h"

@implementation WLDistrictMenuItem

- (void)setDistrict:(WLDistrict *)district
{
    _district = district;
    
    [self setTitle:district.name forState:UIControlStateNormal];
}

-(NSArray *)titles
{
    return _district.neighborhoods;
}

@end
