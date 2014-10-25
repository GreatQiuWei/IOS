//
//  O2OAdFormVC.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OAdFormVC.h"
#import "Utils.h"
#import "O2OAdForm1.h"
#import "O2OChapinView.h"
#import "O2OFullScreenView.h"

@interface O2OAdFormVC()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@property (nonatomic, strong) O2OAdForm1  *v1;

@property (nonatomic, strong) O2OChapinView  *v2;

@property (nonatomic, strong) O2OFullScreenView *v3;

- (void)configPageController;
- (void)configScrollerView;
- (void)showDoudong;

@end

@implementation O2OAdFormVC
@synthesize scrollerView   = _scrollerView;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollerView
    [self configScrollerView];
    //pageController
    [self configPageController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.scrollerView.contentOffset = CGPointMake(0, 0);
    
    self.scrollerView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*3, CGRectGetHeight(self.view.bounds));
    [self showDoudong];
}

- (void)configPageController
{
    self.pageController.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dian_off"]];
    self.pageController.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dian_on"]];
    self.pageController.userInteractionEnabled = NO;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.view addSubview:self.scrollerView];
    [self.view bringSubviewToFront:self.pageController];
    
    //autolayout布局
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollerView)]];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollerView)]];
    
    [self.view addConstraints:tmpConstraints];
}

- (UIScrollView *)scrollerView
{
    if (!_scrollerView)
    {
        _scrollerView = [[UIScrollView alloc] init];
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollerView.delegate = self;
        _scrollerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kuang000"]];
    }
    return _scrollerView;
}
//动画
- (void)showDoudong
{
    [self.v1 showDongHua];
    [self.v2 showDongHua];
    [self.v3 showDongHua];
}
//scrollView添加子控件
- (void)configScrollerView
{
    NSArray *nib0 = [[NSBundle mainBundle]loadNibNamed:@"O2OBanaView"owner:self options:nil];
    O2OAdForm1 *view0 = [nib0 objectAtIndex:0];
    view0.translatesAutoresizingMaskIntoConstraints = NO;
    view0.backgroundColor = [UIColor clearColor];
    self.v1 = view0;
    [self.scrollerView addSubview:view0];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"O2OChaPin"owner:self options:nil];
    O2OChapinView *view1 = [nib objectAtIndex:0];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor clearColor];
    self.v2 = view1;
    [self.scrollerView addSubview:view1];
    
    NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"O2OFullScreen"owner:self options:nil];
    O2OFullScreenView *view2 = [nib1 objectAtIndex:0];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.backgroundColor = [UIColor clearColor];
    self.v3 = view2;
    [self.scrollerView addSubview:view2];
    
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    NSString *hight = [NSString stringWithFormat:@"%f",CGRectGetHeight(self.view.bounds)-20.0f];
    NSString *width = [NSString stringWithFormat:@"%f",CGRectGetWidth(self.view.bounds)];
    
    NSDictionary *metrics = @{@"height":hight
                              , @"width":width
                              , @"edgeSpace":@0};
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view0(width)]-0-[view1(width)]-0-[view2(width)]-0-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(view0,view1,view2)]];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view0]-0-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(view0)]];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view1]-0-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(view1)]];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view2]-0-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(view2)]];

    [self.scrollerView addConstraints:tmpConstraints];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    CGPoint point = scrollView.contentOffset;
    
    int index = (point.x)/(CGRectGetWidth(self.view.bounds));
    
    self.pageController.currentPage = index;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self showDoudong];
}

@end
