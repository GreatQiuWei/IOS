//
//  O2OSelectView.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-18.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OSelectView.h"
#import "Utils.h"
#define kNumberOfSection     4

#define kHeightOfCell       50

//tableViewcell定义
@interface O2OSelectCell : UITableViewCell

@end

@implementation O2OSelectCell

//选择
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self.textLabel setHighlighted:selected];
}

@end

@interface O2OSelectView()

@property (nonatomic, readonly) NSArray  *dataArray;

@end

@implementation O2OSelectView
@synthesize dataArray = _dataArray;

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

//加载数据
- (void)reloadData
{
    [self.tableView reloadData];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

//配置数据
- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@"全部",@"互动扩展",@"HTML5小游戏",@"交互式引导页"];
    }
    return _dataArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Identifier";
    O2OSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[O2OSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor colorWithHexString:@"#222528"];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#ffd515"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#c5c5c5"];
        [cell.textLabel setHighlightedTextColor:[UIColor colorWithHexString:@"#5a3b00"]];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightOfCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.block)
    {
        self.block(indexPath.row);
    }
}

@end
