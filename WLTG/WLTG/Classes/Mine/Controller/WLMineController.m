//
//  WLMineController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

//

#import "WLMineController.h"

@interface WLMineController ()

@end

@implementation WLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:nil action:nil];
}



@end
