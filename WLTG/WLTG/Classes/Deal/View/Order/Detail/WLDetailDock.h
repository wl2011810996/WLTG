//
//  WLDetailDock.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLDetailDockItem;
@class WLDetailDock;

@protocol WLDetailDockDelegate  <NSObject>

@optional
- (void)detailDock:(WLDetailDock *)detailDock btnClickFrom:(int)from to:(int)to;

@end

@interface WLDetailDock : UIView

@property (weak, nonatomic) IBOutlet WLDetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet WLDetailDockItem *merchantBtn;

@property (nonatomic, weak) id<WLDetailDockDelegate> delegate;

+ (id)detailDock;
- (IBAction)btnClick:(UIButton *)sender;


@end


// WLDetailDockItem类
@interface WLDetailDockItem:UIButton

@end