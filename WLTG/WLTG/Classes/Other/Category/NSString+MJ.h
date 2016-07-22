//
//  NSString+MJ.h
//  团购
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MJ)
// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;
@end
