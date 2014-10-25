//
//  O2OAdForm1.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-20.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OAdForm1.h"

@interface O2OAdForm1()

@property (weak, nonatomic) IBOutlet UIImageView *pic01View;

@end

@implementation O2OAdForm1

//动画
- (void)showDongHua
{
    [self showAnimationWithView:self.pic01View];
}

@end
