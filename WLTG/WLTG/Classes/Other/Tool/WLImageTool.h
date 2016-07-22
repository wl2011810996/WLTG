//
//  WLImageTool.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/11.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLImageTool : NSObject

+(void)downLoadImage:(NSString *)url placeholder:(UIImage *)placen imageView:(UIImageView *)imageView;
+(void)clear;

@end
