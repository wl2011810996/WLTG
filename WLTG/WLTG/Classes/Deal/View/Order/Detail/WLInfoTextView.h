//
//  WLInfoTextView.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLRoundRectView.h"

@interface WLInfoTextView : WLRoundRectView

@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

@property (nonatomic, copy) NSString *icon; // 图标
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *content; // 内容

+ (id)infoTextView;

@end
