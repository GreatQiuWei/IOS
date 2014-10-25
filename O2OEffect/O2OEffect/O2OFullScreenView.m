//
//  O2OFullScreenView.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-22.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OFullScreenView.h"

@interface O2OFullScreenView()
@property (weak, nonatomic) IBOutlet UIImageView *pic03View;


@end

@implementation O2OFullScreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//动画
- (void)showDongHua
{
    [self showAnimationWithView:self.pic03View];
}

@end
