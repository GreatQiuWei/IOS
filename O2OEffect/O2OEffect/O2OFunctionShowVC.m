//
//  O2OFunctionShowVC.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OFunctionShowVC.h"
#import "Utils.h"
#import "O2OFunctionCell.h"
#import "funcData.h"
#import "SVModalWebViewController.h"
//播放视频
#import <MediaPlayer/MediaPlayer.h>
//播放音频
#import <AVFoundation/AVFoundation.h>

//电话号码:打电话
#define kForPhoneNumber     @"4006282266"
//发短信
#define kForMessageNumber   @"4006282266"

//本地语音名称
#define kForYinyue          @"bgMusic"
//本地音频格式
#define kForYinyueType      @"mp3"

//本地视频名称
#define kForMovieName       @"video"
//本地视频类型
#define kForMovieType       @"mp4"
//cell高度
#define kForCellHeight      60.0f

@interface O2OFunctionShowVC()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;
//图像识别
@property (readonly, nonatomic) UIImagePickerController *imagePickerController;
//播放音频
@property (nonatomic, strong) AVAudioPlayer *player;

//函数
- (void)configTableView;
- (void)configActivityIndicator;
- (void)showTips:(NSString *)tip;
- (void)showWebViewFromList:(NSInteger)index;
- (void)showWebViewFromLightApp:(NSInteger)index;
//打电话
- (void)makeCallPhone;
//拍照
- (void)takePhoto;
- (void)sendMessage;

@end

@implementation O2OFunctionShowVC
@synthesize imagePickerController   = _imagePickerController;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置tableView
    [self configTableView];
    [self configActivityIndicator];
}

//
- (void)configTableView
{
    self.tableView.tableFooterView = UIView.new;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    self.tableView.separatorColor = [UIColor colorWithHexString:@"#CFCFCF"];
    
    self.dataArray = [funcData getArrays];
    [self.tableView reloadData];
}

- (void)configActivityIndicator
{
    self.activityView.hidesWhenStopped = YES;
}

#pragma mark - imagePickerController
- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController)
    {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
        //方便模拟器测试
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
                    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        _imagePickerController.hidesBottomBarWhenPushed = YES;
        _imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    return _imagePickerController;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kForCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DefaultCellIdentifier";
    O2OFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[O2OFunctionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiJ-Light" size:18];
    }
    funcData *data = (funcData *)self.dataArray[indexPath.row];
    cell.data = data;
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row)
    {
        case 1:
        case 2:
        case 3:
        case 4:
        {
            [self showWebViewFromList:indexPath.row];
            break;
        }
            //拍照识别
        case 5:
        {
            [self takePhoto];
            break;
        }
            //打电话
        case 6:
        {
            [self makeCallPhone];
            break;
        }
            //发短信
        case 7:
        {
            [self sendMessage];
            break;
        }

#pragma mark- lighapp
            //3D体验展示
        case 0:
            //应用下载
        case 8:
            //视频
        case 9:
            //音乐
        case 10:
            //在线购买
        case 11:
            //分享到微信
        case 12:
            //分享到微博
        case 13:
        {
            [self showWebViewFromLightApp:indexPath.row];
            break;
        }
        default:
            break;
    }
    
}

//显示提示
- (void)showTips:(NSString *)tip
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tip
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

//显示网页 从list下面加载
- (void)showWebViewFromList:(NSInteger)index
{
    
    NSArray * types = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:@"list"];
    
    if (index <=0 || index > types.count)
    {
        return;
    }
    NSInteger i;

    switch (index)
    {
        case 1:
        {
            i = 3;
            break;
        }
        case 2:
        {
            i = 2;
            break;
        }
        case 3:
        {
            i = 6;
            break;
        }
        case 4:
        {
            i = 4;
            break;
        }
        default:
            break;
    }
    
    NSString *path = types[i];
    
    NSString *url = [path stringByAppendingPathComponent:@"index.html"];
    
    SVModalWebViewController *webViewVC = [[SVModalWebViewController alloc] initWithAddress:url];
    [self presentViewController:webViewVC animated:YES completion:^{
        
    }];

}

- (void)showWebViewFromLightApp:(NSInteger)index
{
    NSString *fileName;
    
    switch (index)
    {
        case 0:
        {
            fileName = @"360.html";
            break;
        }
            //应用Xiazai
        case 8:
        {
            fileName = @"download.html";
            break;
        }
        case 9:
        {
            fileName = @"video.html";
            break;
        }
        case 10:
        {
            fileName = @"audio.html";
            break;
        }
            //在线购买
        case 11:
        {
            fileName = @"shopping.html";
            break;
        }
        case 12:
        {
            fileName = @"weixin.html";
            break;
        }
        case 13:
        {
            fileName = @"weibo.html";
            break;
        }
        default:
            break;
    }
    
    NSString *pathl = [[NSBundle mainBundle] pathForResource:fileName ofType:nil inDirectory:@"lightapp"];

    SVModalWebViewController *webViewVC = [[SVModalWebViewController alloc] initWithAddress:pathl];
    [self presentViewController:webViewVC animated:YES completion:^{
        
    }];
}

//拨打电话
- (void)makeCallPhone
{
    NSString *phoneNumber = [@"tel://" stringByAppendingString:kForPhoneNumber];
    NSURL *url = [NSURL URLWithString:phoneNumber];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        [self showTips:@"不支持打电话"];
    }
}

//拍照
- (void)takePhoto
{
    [self.tabBarController presentViewController:self.imagePickerController animated:YES completion:nil];
}

//发短信
- (void)sendMessage
{
    NSString *mesStr = [NSString stringWithFormat:@"sms://%@",kForMessageNumber];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mesStr]];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.activityView startAnimating];
    //设置时间为2
    double delayInSeconds = 2.0;
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_queue_t concurrentQueue =dispatch_get_main_queue();
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"识别成功"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        alertview.tag = 1;
        [alertview show];
        [self.activityView stopAnimating];
    });
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - alertViewdelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //照片识别成功跳转到可口可乐案例
    if (alertView.tag == 1) {
        [self showWebViewFromList:3];
    }
}

@end
