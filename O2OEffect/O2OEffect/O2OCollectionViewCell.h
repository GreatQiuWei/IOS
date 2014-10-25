//
//  O2OCollectionViewCell.h
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "youxiu.h"

typedef void (^showWebView)( NSInteger);

typedef void (^showQRCodeImage)( NSString *);

@interface O2OCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) youxiu *itemInfo;

@property (nonatomic, copy) showWebView webViewBlock;

@property (nonatomic, copy) showQRCodeImage QRCodeBlock;

@end
