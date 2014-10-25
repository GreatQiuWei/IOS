//
//  O2OChapinView.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-22.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OChapinView.h"

@interface O2OChapinView()
@property (weak, nonatomic) IBOutlet UIImageView *pic02View;

@end

@implementation O2OChapinView

//动画
- (void)showDongHua
{
    [self showAnimationWithView:self.pic02View];
}

@end
