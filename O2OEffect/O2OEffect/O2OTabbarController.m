//
//  O2OTabbarController.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OTabbarController.h"
#import "Utils.h"
//#include "HexColor.h"
//#include "UIImage+BLCategory.h"


@interface O2OTabbarController ()<UITabBarControllerDelegate,UITabBarDelegate>
//底部黄色移动图标
@property (nonatomic, strong) CALayer *layer;
#pragma mark - 函数
- (void)configNavigationStyle;
- (void)configTabbarItems;
- (void)configMoveLayer;

- (NSString *)colorAttrbuteName;
- (NSString *)fontAttrbuteName;
@end

@implementation O2OTabbarController

@synthesize layer;

- (void)awakeFromNib
{
    //选择卡的样式
    NSDictionary *attribute = nil;
    //选择时样式
    NSDictionary *selectedAttribute = nil;
    //选择时颜色
    UIColor *selectedColor = [UIColor colorWithRed:.3 green:.2 blue:.04 alpha:1];
    
    NSString *colorAttrbuteName = [self colorAttrbuteName];
    NSString *fontAttrbuteName  = [self fontAttrbuteName];
    
    //正常时颜色
    UIColor *textColor     = [UIColor colorWithRed:0.9 green:.7 blue:.2 alpha:1];
    attribute         = @{colorAttrbuteName : textColor,
                          fontAttrbuteName : [UIFont systemFontOfSize:18]};
    selectedAttribute = @{colorAttrbuteName : selectedColor,
                          fontAttrbuteName : [UIFont systemFontOfSize:18]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:attribute
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttribute
                                             forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;

    [self configNavigationStyle];
    
    [self configTabbarItems];
    //黄色移动背景
    [self configMoveLayer];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}
//黄色背景移动
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
    {
        return;
    }
    __block NSUInteger i = 0;
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj == viewController)
        {
            i = idx;
            *stop = YES;
        }
    }];
    
    CGFloat width = CGRectGetWidth(self.tabBar.bounds)/3;
    __block CGRect frame = layer.frame;
    [UIView animateWithDuration:.25 animations:^{
        frame.origin.x = width * i;
        layer.frame = frame;
    }];
}
#pragma mark - private function
- (void)configNavigationStyle
{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F3F3F3"]] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].titleTextAttributes = @{[self colorAttrbuteName] : [UIColor colorWithHexString:@"#272727"],
                                                         [self fontAttrbuteName]  : [UIFont fontWithName:@"STHeitiJ-Light" size:18],
                                                         UITextAttributeTextShadowColor : [UIColor clearColor],
                                                         };
}

- (void)configMoveLayer
{
    layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabBar.bounds)/3, 49);
    layer.contents = (id)[UIImage imageWithColor:[UIColor colorWithRed:.98 green:.81 blue:.27 alpha:1]].CGImage;
    
    if (!(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
    {
        unsigned index = 0;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
        {
            index = 1;
        }
        [self.tabBar.layer insertSublayer:layer atIndex:index];
    }
}

- (void)configTabbarItems
{
    UIImage *image = [UIImage imageNamed:@"TabBar"];
    self.tabBar.backgroundImage = image;
    
    NSArray *titiles = @[@"优秀案例",@"功能交互",@"广告形式",];
    
    NSArray *viewControllers = self.viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UINavigationController *vc = (UINavigationController *)obj;
        vc.tabBarItem.title  = titiles[idx];
        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    }];
}

#pragma mark - AttrbutName
- (NSString *)colorAttrbuteName
{
    NSString *_colorAttrbuteName = NSForegroundColorAttributeName;
   
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        _colorAttrbuteName = UITextAttributeTextColor;
    }
    return _colorAttrbuteName;
}

- (NSString *)fontAttrbuteName
{
    NSString *_fontAttrbuteName  = NSFontAttributeName;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        _fontAttrbuteName  = UITextAttributeFont;
    }
    return _fontAttrbuteName;
}
@end
