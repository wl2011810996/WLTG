//
//  TGDealCell.h
//  团购
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLDeal;
@interface WLDealCell : UICollectionViewCell
// 描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *price;
// 购买人数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
// 标签
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@property (nonatomic, strong) WLDeal *deal;
@end
