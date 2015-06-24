//
//  CVCSoundViewController.h
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCSoundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataSource;

@end
