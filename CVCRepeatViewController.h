//
//  CVCRepeatViewController.h
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/24.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCRepeatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataSource;

@end
