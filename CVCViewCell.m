//
//  CVCViewCell.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/18.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCViewCell.h"

@implementation CVCViewCell
@synthesize numberLabel,capLabel;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor blueColor];
    // Initialization code
}

@end
