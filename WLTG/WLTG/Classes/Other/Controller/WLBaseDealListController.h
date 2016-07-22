//
//  WLBaseDealListController.h
//  WLTG
//
//  Created by 荣耀iMac on 16/7/15.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLCover;

@interface WLBaseDealListController : UICollectionViewController
{
      WLCover *_cover;
}

- (NSArray *)totalDeals; // 所有的团购数据

@end
