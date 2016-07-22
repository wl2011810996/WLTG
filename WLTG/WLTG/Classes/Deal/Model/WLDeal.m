//
//  WLDeal.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/11.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLDeal.h"
#import "NSString+MJ.h"
#import "WLRestriction.h"
#import "NSObject+Value.h"

@implementation WLDeal

-(void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];
}

-(void)setRestrictions:(WLRestriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[WLRestriction alloc]init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    }else
    {
        _restrictions = restrictions;
    }
}

-(BOOL)isEqual:(WLDeal *)other
{
    return [other.deal_id isEqualToString:_deal_id];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [encoder encodeObject:_deal_id forKey:@"_deal_id"];
    [encoder encodeObject:_image_url forKey:@"_image_url"];
    [encoder encodeObject:_desc forKey:@"_desc"];
    [encoder encodeDouble:_current_price forKey:@"_current_price"];
    [encoder encodeInt:_purchase_count forKey:@"_purchase_count"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.purchase_deadline = [decoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [decoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [decoder decodeObjectForKey:@"_image_url"];
        self.desc = [decoder decodeObjectForKey:@"_desc"];
        self.current_price = [decoder decodeDoubleForKey:@"_current_price"];
        self.purchase_count = [decoder decodeIntForKey:@"_purchase_count"];
    }
    return self;
}

@end
