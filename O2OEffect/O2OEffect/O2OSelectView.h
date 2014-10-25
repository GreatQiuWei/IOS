//
//  O2OSelectView.h
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectIndex)( NSUInteger );

@interface O2OSelectView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) selectIndex block;

- (void)reloadData;

@end
