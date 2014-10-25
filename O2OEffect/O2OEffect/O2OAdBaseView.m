//
//  O2OAdBaseView.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-22.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OAdBaseView.h"

@implementation O2OAdBaseView

- (void)awakeFromNib
{
//    self.layer.transform = CATransform3DMakeTranslation(0, -20, 0);
}

- (void)showDongHua
{
    
}

- (CGFloat)angle2radians:(CGFloat)angle {
    return angle/180.0 * M_PI;
}

//显示动画
- (void)showAnimationWithView:(UIView *)view
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    anim.duration = 0.5;
    //    anim.repeatCount = MAXFLOAT;
    anim.repeatCount = 3;
    NSMutableArray *values = [NSMutableArray new];
    
    CGFloat angle = [self angle2radians:13];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-angle, 0, 0, 1)]];
    
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)]];
    
    anim.values = values;
    [view.layer addAnimation:anim forKey:@"shake"];
}

@end
