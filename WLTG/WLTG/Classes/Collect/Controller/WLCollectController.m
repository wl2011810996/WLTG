//
//  WLCollectController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCollectController.h"
#import "WLCollectTool.h"

@interface WLCollectController ()

@end

@implementation WLCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    [[NSNotificationCenter defaultCenter] addObserver:self.collectionView selector:@selector(reloadData) name:kCollectChangeNote object:nil];
}


- (NSArray *)totalDeals
{
    return [WLCollectTool sharedWLCollectTool].collectedDeals;
}

@end
