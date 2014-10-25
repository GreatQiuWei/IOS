//
//  O2OexcellentVC.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OexcellentVC.h"
#import "O2OSelectView.h"
#import "Utils.h"
#import "youxiu.h"
#import "O2OCollectionViewCell.h"
#import "SVModalWebViewController.h"
#import "O2OQRCodeView.h"
#import "UIView+AutoLayout.h"

//表格宽度
#define kForCollectionCellWith     140.0f
//表格高度
#define kForCollectionCellHeight   170.0f

@interface O2OexcellentVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
//
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

//数据
@property (nonatomic, strong) NSArray *dataArray;

//显示 iphone
@property (nonatomic, strong) O2OSelectView *selectView;

//已经显示选择框
@property (nonatomic, assign) BOOL showSelect;

//ipad
@property (nonatomic, strong, readonly) UIActionSheet *pageActionSheet;

#pragma mark - 私有函数
//函数
- (void)getArrayByType:(NSUInteger)index;
//CollectionView配置
- (void)configCollectionView;
//选择框配置
- (void)configSelectView;
//显示选择框
- (void)showSelect:(id)sender;
//显示网页
- (void)showWebView:(NSInteger )index;
//关闭选择框
- (void)closeSelectView;
//显示二维码
- (void)showQRCodeView:(NSString *)str;
//导航栏右边按钮图片设置
- (void)configRighButtonImage:(NSString*)imgName;
@end

@implementation O2OexcellentVC
@synthesize selectView = _selectView;
@synthesize pageActionSheet;

- (void)awakeFromNib
{
    [self.rightButton addTarget:self
                         action:@selector(showSelect:)
               forControlEvents:UIControlEventTouchUpInside];
#ifdef __IPHONE_7_0
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 2);
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //没有显示选择框
    self.showSelect = NO;
    //配置表格
    [self configCollectionView];
    [self getArrayByType:0];
}

//选择数据
- (void)getArrayByType:(NSUInteger)index
{
    switch (index) {
        case 0:
            self.dataArray = [youxiu getYouxiuArray];
            self.navigationItem.title = @"全部";
            break;
        case 1:
            self.dataArray = [youxiu getHudongArray];
            self.navigationItem.title = @"互动扩展";
            break;
        case 2:
            self.dataArray = [youxiu getHtmlGameArray];
            self.navigationItem.title = @"HTML5小游戏";
            break;
        case 3:
            self.dataArray = [youxiu getJiaohuArray];
            self.navigationItem.title = @"交互式引导页";
            break;
        default:
            break;
    }
    
    [self closeSelectView];
    
    [self.collectionView reloadData];
}

//显示选择
- (void)showSelect:(id)sender
{
//    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
//    {
//        self.showSelect = YES;
//        [self configRighButtonImage:@"NaviBar_jiantou_on"];
////        [self.pageActionSheet showFromBarButtonItem:sender animated:YES];
//        [self.pageActionSheet showFromRect:self.rightButton.frame inView:self.view.window animated:YES];
//        return;
//    }
    if (!self.selectView)
    {
        [self configSelectView];
    }
    if (!self.showSelect)
    {
        self.showSelect = YES;
        [self configRighButtonImage:@"NaviBar_jiantou_on"];
        [self.view bringSubviewToFront:self.selectView];
    }
    else
    {
        self.showSelect = NO;
        [self configRighButtonImage:@"NaviBar_jiantou_off"];
        [self.view sendSubviewToBack:self.selectView];
    }
}

//配置选择框
- (void)configSelectView
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"selectView"owner:self options:nil];
    
    _selectView = [nib objectAtIndex:0];
    _selectView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_selectView];
    _selectView.tableView.delegate = _selectView;
    _selectView.tableView.dataSource = _selectView;
    _selectView.tableView.bounces = NO;
    __weak __typeof(&*self)weakSelf = self;
    _selectView.block = ^(NSUInteger row)
    {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        
        [strongSelf getArrayByType:row];
        
    };
    
    [_selectView reloadData];
    [self.view sendSubviewToBack:_selectView];
    _selectView.tableView.backgroundColor = [UIColor colorWithHexString:@"#222528"];
    
    [_selectView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_selectView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_selectView autoSetDimension:ALDimensionWidth toSize:150];
    [_selectView autoSetDimension:ALDimensionHeight toSize:202.0f];
}

//配置表格
- (void)configCollectionView
{
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#393B40"];
    
    UINib *cellNib = [UINib nibWithNibName:@"O2OCollectionCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    
    UICollectionViewFlowLayout   *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    CGFloat lrOffect = 15.0f;
    if (!(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
    {
        lrOffect = (CGRectGetWidth(self.view.bounds) - kForCollectionCellWith*2)/3.0;
    }
    layout.sectionInset = UIEdgeInsetsMake(5, lrOffect, 5, lrOffect);

    layout.itemSize = CGSizeMake(kForCollectionCellWith, kForCollectionCellHeight);
    
    [self.collectionView setCollectionViewLayout:layout];
}

#pragma mark - peivateMethod
- (void)configRighButtonImage:(NSString*)imgName
{
    [self.rightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

#pragma mark - pageActionSheet
- (UIActionSheet *)pageActionSheet
{
    if(!pageActionSheet)
    {
        pageActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
        
        [pageActionSheet addButtonWithTitle:@"全部"];
        [pageActionSheet addButtonWithTitle:@"互动扩展"];
        [pageActionSheet addButtonWithTitle:@"HTML5小游戏"];
        [pageActionSheet addButtonWithTitle:@"交互式引导页"];
        [pageActionSheet addButtonWithTitle:@"取消"];
        pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    return pageActionSheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self getArrayByType:buttonIndex];
    [self closeSelectView];
}

#pragma mark - collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simpleCell";
    O2OCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    __weak __typeof(&*self)weakSelf = self;
    cell.webViewBlock = ^(NSInteger index)
    {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        [strongSelf showWebView:index];
    };
    
    cell.QRCodeBlock = ^(NSString *path)
    {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        [strongSelf showQRCodeView:path];
    };
    
    youxiu* yObj = (youxiu *)self.dataArray[indexPath.row];
    cell.itemInfo = yObj;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.layer.transform = CATransform3DMakeScale(.5, .5, .5);
    [UIView animateWithDuration:.2 animations:^{
        cell.contentView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - scrollviewdelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.showSelect)
    {
        [self closeSelectView];
    }
}

//显示网页
- (void)showWebView:(NSInteger )index
{
    //关闭选择框
    if (self.showSelect)
    {
        [self closeSelectView];
//        return; //引导页面
    }
    NSArray * types = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:@"list"];
    
    if (index <=0 || index > types.count)
    {
        return;
    }
    NSInteger i = index - 1;
    NSString *path = types[i];
    
    NSString *url = [path stringByAppendingPathComponent:@"index.html"];
    
    SVModalWebViewController *webViewVC = [[SVModalWebViewController alloc] initWithAddress:url];
    [self presentViewController:webViewVC animated:NO completion:^{
    }];
}

- (void)closeSelectView
{
    self.showSelect = NO;
    [self configRighButtonImage:@"NaviBar_jiantou_off"];
    [self.view sendSubviewToBack:self.selectView];
}

//显示二维码
- (void)showQRCodeView:(NSString *)str
{
    //关闭选择框
    if (self.showSelect)
    {
        [self closeSelectView];
        return;
    }
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"O2OQRCodeView"owner:self options:nil];
    
    O2OQRCodeView *codeView = [nib objectAtIndex:0];
    //使用autolayout布局
    [codeView setImagePath:str];
    [self.view.window addSubview:codeView];
    [codeView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    [codeView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [codeView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [codeView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

@end
