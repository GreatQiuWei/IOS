//
//  youxiu.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//优秀案例数据

#import "youxiu.h"

#define kNumberOfYouxiu   11

@interface youxiu()
//描述字符串
+ (NSArray *)miaoshuStrings;
//二维码字符串
+ (NSArray *)getQRCodes;
//所有的type构造
+ (NSArray *)getTypes;
//构造引导页
+ (NSArray *)launchArrays;
@end

@implementation youxiu

//优秀案例数据构造
- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.bigImagePath = info[@"bigImagePath"];
        self.littleImagePath = info[@"littleImagePath"];
        self.miaoshu = info[@"miaoshu"];
        self.type = [info[@"type"] integerValue];
        self.webUrlPath = [info[@"webUrlPath"] integerValue];
        self.QRCodePath = info[@"QRCodePath"];
        self.lauchImg = info[@"lauchImg"];
    }
    return self;
}

+ (NSArray *)htmlPaths
{
    NSArray *array = @[
                       @1,
                       @2,
                       @3,
                       @4,
                       @5,
                       @6,
                       @7,
                       @8,
                       @9,
                       @10,
                       ];
    return array;
}
//描述字符串构造
+ (NSArray *)miaoshuStrings
{
    static NSMutableArray *array = nil;
    if (!array)
    {
        NSArray * __miaoshuStrings = @[
                            @"喊你当行长",
                            @"低碳大作战",
                            @"智慧点灯 照亮城市",
                            @"寻找你身边的星巴克",
                            @"七周年幸运刮刮卡",
                            @"手抽筋，抽奖大轮盘",
                            @"可口可乐惊喜摇一摇",
                            @"中惠璧珑湾-引导页",
                            @"我有车APP推广",
                            @"海信线下巡展推广"
                            ];
        array = [NSMutableArray arrayWithArray:__miaoshuStrings];
    }
    return array;
}

//构造二维码
+ (NSArray *)getQRCodes
{
    NSArray *codes = @[
                       @"QRCode_1",
                       @"QRCode_2",
                       @"QRCode_3",
                       @"QRCode_4",
                       @"QRCode_5",
                       @"QRCode_6",
                       @"QRCode_7",
                       @"QRCode_8",
                       @"QRCode_9",
                       @"QRCode_10",
                       ];
    return codes;
}

//所有的type构造
+ (NSArray *)getTypes
{
    NSArray *types = @[[NSString stringWithFormat:@"%li",(long)O2OYouxiuHtmlGame],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuHtmlGame],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuHtmlGame],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuTypeHudong],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuTypeHudong],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuTypeHudong],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuTypeHudong],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiujiaohu],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuTypeHudong],
                       [NSString stringWithFormat:@"%li",(long)O2OYouxiuHtmlGame],
                       ];
    return types;
}

//构造引导页
+ (NSArray *)launchArrays
{
    NSArray *arrays = @[
                        @"2048.jpg",
                        @"meidi.jpg",
                        @"dongfengrichan.jpg",
                        @"xingbake.jpg",
                        @"",
                        @"guomei.jpg",
                        @"kekoukele.jpg",
                        @"zhonghui.jpg",
                        @"woyouche.jpg",
                        @"haixin.jpg",
                        ];
    return arrays;
}

//获取全部数据
+ (NSArray *)getYouxiuArray
{
    NSMutableArray *youxiuData = [[NSMutableArray alloc] init];
    int i = 1;
    NSArray *miaoshus = [youxiu miaoshuStrings];
    NSArray *types = [youxiu getTypes];
    NSArray *QRCodes = [youxiu getQRCodes];
    NSArray *lauchImage = [youxiu launchArrays];
    
    while (i < kNumberOfYouxiu)
    {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        //大图片构造 图片按照顺序排列
        if (i< 10)
        {
            info[@"bigImagePath"] = [NSString stringWithFormat:@"pic0%i",i];
        }
        else
        {
            info[@"bigImagePath"] = [NSString stringWithFormat:@"pic%i",i];
        }
        info[@"littleImagePath"] = [NSString stringWithFormat:@"QR_off"];
        
        info[@"miaoshu"] = miaoshus[i-1];
        info[@"type"] = types[i-1];
        info[@"webUrlPath"] = [NSString stringWithFormat:@"%i",i];
        info[@"QRCodePath"] = QRCodes[i - 1];
        info[@"lauchImg"] = lauchImage[i - 1];
        
        youxiu *yObj = [[youxiu alloc] initWithInfo:info];
        [youxiuData addObject:yObj];
        ++i;
    }
    return youxiuData;
}
//获取html5小游戏数据
+ (NSArray *)getHtmlGameArray
{
    return [youxiu getArrayByType:O2OYouxiuHtmlGame];
}
//获取互动数据
+ (NSArray *)getHudongArray
{
    return [youxiu getArrayByType:O2OYouxiuTypeHudong];
}
//获取交互数据
+ (NSArray *)getJiaohuArray
{
    return [youxiu getArrayByType:O2OYouxiujiaohu];
}
//通过类型获取数据
+ (NSArray *)getArrayByType:(O2OYouxiuType)type
{
    NSArray *allArray = [youxiu getYouxiuArray];
    NSMutableArray *htmlArray = [[NSMutableArray alloc] init];
    
    [allArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        youxiu *yObj = (youxiu *)obj;
        if (yObj.type == type)
        {
            [htmlArray addObject:yObj];
        }
    }];
    
    return htmlArray;
}

@end
