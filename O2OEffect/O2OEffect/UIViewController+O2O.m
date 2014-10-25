//
//  UIViewController+O2O.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "UIViewController+O2O.h"

@implementation UIViewController (O2O)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
}
#endif

@end

@implementation UINavigationItem (FM)

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version>=7.0)
    {
        //系统弹框不改变
        if ([_rightBarButtonItem.customView isKindOfClass:[UIButton class]])
        {
            spaceButtonItem.width = -12;
        }
        
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[spaceButtonItem, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[spaceButtonItem]];
        }
    }
}
@end