//
//  youxiu.h
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, O2OYouxiuType) {
    //错误
    O2OYouxiuTypeError      =  -1,
    //互动
    O2OYouxiuTypeHudong,
    //HTML小游戏
    O2OYouxiuHtmlGame,
    //交互
    O2OYouxiujiaohu,
};

@interface youxiu : NSObject

@property (nonatomic,copy) NSString *bigImagePath;

@property (nonatomic,copy) NSString *miaoshu;

@property (nonatomic,copy) NSString *littleImagePath;

@property (nonatomic,assign) O2OYouxiuType type;
//点击网页路径
@property (nonatomic,assign) NSInteger webUrlPath;
//二维码图片路径
@property (nonatomic,strong) NSString *QRCodePath;
//点击显示网页的引导页面
@property (nonatomic, copy) NSString *lauchImg;

//获取所有的数据
+ (NSArray *)getYouxiuArray;
//获取html小游戏数据
+ (NSArray *)getHtmlGameArray;
//获取互动
+ (NSArray *)getHudongArray;
//获取交互
+ (NSArray *)getJiaohuArray;
@end
