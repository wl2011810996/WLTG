//
//  WLImageTool.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/11.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLImageTool.h"
#import "UIImageView+WebCache.h"

@implementation WLImageTool

+(void)downLoadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority|SDWebImageRetryFailed];
}

+(void)clear
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache]clearMemory];
    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager]cancelAll];
}

@end
