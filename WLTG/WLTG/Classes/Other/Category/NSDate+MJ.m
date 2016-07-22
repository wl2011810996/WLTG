//
//  NSDate+MJ.m
//  团购
//
//  Created by apple on 13-11-17.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSDate+MJ.h"

@implementation NSDate (MJ)
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to
{
    // 1.日历对象（标识：时区相关的标识）
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // 2.合并标记
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // 3.比较
    return [calendar components:flags fromDate:from toDate:to options:0];
}

- (NSDateComponents *)compare:(NSDate *)other
{
    return [NSDate compareFrom:self to:other];
}
@end
