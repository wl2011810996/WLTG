//
//  WLDockItem.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLDockItem : UIButton
{
    UIImageView *_divider;
}
- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;
@property (nonatomic, copy) NSString *icon; // 普通图片
@property (nonatomic, copy) NSString *selectedIcon; // 选中图片
@end
