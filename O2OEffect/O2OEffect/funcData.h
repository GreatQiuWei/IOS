//
//  funcData.h
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface funcData : NSObject

@property (nonatomic, copy)NSString *imageName;

@property (nonatomic, copy)NSString *showStr;

- (id)initWithImage:(NSString *)name str:(NSString *)str;

+ (NSArray *)getArrays;

@end
