//
//  WLSubtitlesView.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/8.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLSubtitlesView.h"
#import "UIImage+MJ.h"
#define kTitleW 100
#define kTitleH 40

#define kDuration 1.0

@interface WLSubtitlesView()
{
    UIButton *_selectedBtn;
}

@end

@implementation WLSubtitlesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}


-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    int count = titles.count;
    
    for (int i = 0; i<count; i++) {
        UIButton *btn = nil;
        if (i>=self.subviews.count) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [self addSubview:btn];
        }else
        {
            btn = self.subviews[i];
        }
        
        btn.hidden = NO;
        [btn setTitle:titles[i] forState:0];
        
        
        if (_getTitleBlock()) {
            NSString *current = _getTitleBlock();
            btn.selected = [titles[i] isEqualToString:current];
            if (btn.selected) {
                _selectedBtn = btn;
            }else
            {
                btn.selected = NO;
            }
        }
        
    }
    
    for (int i = count; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    
    [self layoutSubviews];
}

#pragma mark 监听小标题（按钮）点击
- (void)titleClick:(UIButton *)btn
{
    // 1.控制按钮状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    // 2.设置当前选中的分类文字
    if (_setTitleBlock) {
        _setTitleBlock([btn titleForState:UIControlStateNormal]);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    int columns = self.frame.size.width/kTitleW;
    for (int i = 0; i<_titles.count; i++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    int rows = (_titles.count + columns - 1) / columns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleH;
    self.frame = frame;
}

-(void)show
{
    [self layoutSubviews];
    self.transform  = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
    
}

-(void)hide
{
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

@end
