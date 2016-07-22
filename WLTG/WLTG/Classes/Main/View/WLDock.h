//
//  WLDock.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLDock;

@protocol WLDockDelegate <NSObject>
@optional
- (void)dock:(WLDock *)dock tabChangeFrom:(int)from to:(int)to;
@end

@interface WLDock : UIView

@property (nonatomic, weak) id<WLDockDelegate> delegate;

@end
