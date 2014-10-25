//
//  O2OQRCodeView.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-19.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OQRCodeView.h"

@interface O2OQRCodeView()
//二维码图片
@property (weak, nonatomic) IBOutlet UIImageView *centerView;


@end

@implementation O2OQRCodeView

//设置图片
- (void)setImagePath:(NSString *)imagePath
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _imagePath = imagePath;
    if (self.imagePath)
    {
        self.centerView.image = [UIImage imageNamed:self.imagePath];
    }
}


//触摸事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    //显示HTML网页
    if (!CGRectContainsPoint(self.centerView.frame, point))
    {
        [self removeFromSuperview];
    }
}

@end
