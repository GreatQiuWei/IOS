//
//  O2OFunctionCell.m
//  O2OEffect
//
//  Created by liang chunyan on 14-9-17.
//  Copyright (c) 2014年 BaiLing-ShanBo. All rights reserved.
//

#import "O2OFunctionCell.h"

@implementation O2OFunctionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(funcData *)data
{
    _data = data;
    if (self.data)
    {
        self.imageView.image = nil;
        self.detailTextLabel.text = nil;
        
        self.imageView.image = [UIImage imageNamed:data.imageName];
        self.textLabel.text = data.showStr;
    }
}

@end
