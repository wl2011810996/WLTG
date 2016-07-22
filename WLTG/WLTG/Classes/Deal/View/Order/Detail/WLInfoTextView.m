//
//  WLInfoTextView.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLInfoTextView.h"

@implementation WLInfoTextView

+ (id)infoTextView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WLInfoTextView" owner:nil options:nil][0];
}


- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [_titleView setTitle:title forState:UIControlStateNormal];
}

-(void)setContent:(NSString *)content
{
    _content = content;
  
    CGFloat textH = [content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height + 20;
    
    CGRect contentF = _contentView.frame;
    CGFloat contentDeltaH = textH -contentF.size.height;
    contentF.size.height = textH;
    _contentView.frame = contentF;
        _contentView.text = content;
    
    CGRect selfF = self.frame;
    selfF.size.height += contentDeltaH;
    self.frame  = selfF;
}


@end
