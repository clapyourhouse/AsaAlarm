//
//  CVCTableViewCell.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCTableViewCell.h"

@implementation CVCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// オブジェクトの配置等はここで操作する
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
