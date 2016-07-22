//
//  WLCover.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCover : UIView

+(instancetype)cover;
+(instancetype)coverWithTarget:(id)target action:(SEL)action;

-(void)reset;

@end
