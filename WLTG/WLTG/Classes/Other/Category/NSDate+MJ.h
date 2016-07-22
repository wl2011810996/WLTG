//
//  NSDate+MJ.h
//  团购
//
//  Created by apple on 13-11-17.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MJ)
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to;

- (NSDateComponents *)compare:(NSDate *)other;
@end
