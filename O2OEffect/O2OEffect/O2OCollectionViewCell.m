//
//  O2OCollectionViewCell.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OCollectionViewCell.h"

@interface O2OCollectionViewCell()
//大图
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
//显示名称
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
//二维码图片
@property (weak, nonatomic) IBOutlet UIImageView *erweimaView;

@end

@implementation O2OCollectionViewCell

- (void)awakeFromNib
{
    self.showLabel.numberOfLines = 1;
}

- (void)setItemInfo:(youxiu *)itemInfo
{
    _itemInfo = itemInfo;
    if (self.itemInfo)
    {
        //配置cell
        self.contentImageView.image = [UIImage imageNamed:self.itemInfo.bigImagePath];
        self.erweimaView.image = [UIImage imageNamed:self.itemInfo.littleImagePath];
        self.showLabel.text = self.itemInfo.miaoshu;
//        [self.showLabel sizeToFit];
    }
}

//选中状态
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    //二维码点击状态
    if (CGRectContainsPoint(self.erweimaView.frame, point))
    {
        self.erweimaView.image = [UIImage imageNamed:@"QR_on"];
    }
}

//触摸方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    //显示HTML网页
    if (CGRectContainsPoint(self.contentImageView.bounds, point))
    {
        if (self.webViewBlock)
        {
            if (self.itemInfo.lauchImg.length > 3)
            {
                [self showLaunchImageView];
                
                //设置时间为2
                double delayInSeconds = .5;
                //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
                dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                
                //推迟两纳秒执行
                dispatch_queue_t concurrentQueue =dispatch_get_main_queue();
                dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
                    self.webViewBlock(self.itemInfo.webUrlPath);
                });
            }
            else
            {
                self.webViewBlock(self.itemInfo.webUrlPath);
            }
        }
    }
    //显示二维码图片
    if (CGRectContainsPoint(self.erweimaView.frame, point))
    {
        //二维码
        if (self.QRCodeBlock)
        {
            self.QRCodeBlock(self.itemInfo.QRCodePath);
        }
    }
    //二维码
    self.erweimaView.image = [UIImage imageNamed:self.itemInfo.littleImagePath];
}

- (void)showLaunchImageView
{
    CGRect rect = [self.contentView convertRect:self.contentView.frame toView:self.window];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:self.itemInfo.lauchImg];
    [self.window addSubview:imageView];
    
    [UIView animateWithDuration:.5 animations:^{
        imageView.frame = self.window.bounds;
    } completion:^(BOOL finished) {
    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(removeImageView:)];
    [imageView addGestureRecognizer:tapGes];
//    //设置时间为2
//    double delayInSeconds = 1.0;
//    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
//    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    
//    //推迟两纳秒执行
//    dispatch_queue_t concurrentQueue =dispatch_get_main_queue();
//    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
//        [self removeImageView:tapGes];
//    });
//    
}
- (void)removeImageView:(UITapGestureRecognizer *)ges
{
    [UIView animateWithDuration:.5 animations:^{
        ges.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [ges.view removeFromSuperview];
    }];
}

@end
