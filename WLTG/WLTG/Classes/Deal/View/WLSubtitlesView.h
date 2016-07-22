//
//  WLSubtitlesView.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/8.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLSubtitlesView : UIImageView

@property (nonatomic,strong)NSArray *titles;

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;

@property (nonatomic,copy)void (^setTitleBlock)(NSString *title);

@property (nonatomic,copy)NSString *(^getTitleBlock)();

@end
