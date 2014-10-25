//
//  funcData.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "funcData.h"

@implementation funcData
//构造函数
- (id)initWithImage:(NSString *)name str:(NSString *)str
{
    self = [super init];
    if (self)
    {
        self.imageName = name;
        self.showStr = str;
    }
    return self;
}
//构造图片数组
+ (NSArray *)getImageNames
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    int i = 1;
    NSString *name;
    while (i < 15)
    {
        if (i <  10)
        {
            name = [NSString stringWithFormat:@"icon0%i",i];
        }
        else
        {
            name = [NSString stringWithFormat:@"icon%i",i];
        }
        [array addObject:name];
        ++i;
    }
    return array;
}
//构造文字数组
+ (NSArray *)getStrs
{
    NSArray *strs=@[
                    @"3D体验展示效果",
                    @"LBS地图定位导航",
                    @"重力感应",
                    @"摇一摇",
                    @"触屏互动",
                    @"拍照图像识别",
                    @"拨打电话",
                    @"发短信",
                    @"应用下载",
                    @"视频播放",
                    @"音频播放",
                    @"在线购买",
                    @"分享到微信",
                    @"分享到微博",
                    ];
    return strs;
}
//构造表格显示的数据
+ (NSArray *)getArrays
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *images = [funcData getImageNames];
    NSArray *strs = [funcData getStrs];
    int i = 0;
    while (i<14)
    {
        NSString *imageName = images[i];
        NSString *str = strs[i];
        
        funcData *fObj = [[funcData alloc] initWithImage:imageName str:str];
        
        [array addObject:fObj];
        
        ++i;
    }
    
    return array;
}

@end
