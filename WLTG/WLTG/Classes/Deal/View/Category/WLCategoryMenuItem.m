//
//  WLCategoryMenuItem.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/7.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCategoryMenuItem.h"
#import "WLCategory.h"
#define kTitleRatio 0.5

@implementation WLCategoryMenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(NSArray *)titles
{
    return _category.subcategories;
}

-(void)setCategory:(WLCategory *)category
{
    _category = category;
    
    [self setImage:[UIImage imageNamed:category.icon] forState:0];
    
    [self setTitle:category.name forState:0];
}

#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width,  titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}

@end
