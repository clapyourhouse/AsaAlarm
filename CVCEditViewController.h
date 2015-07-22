//
//  CVCEditViewController.h
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCEditViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView_;
}
@property (strong, nonatomic) IBOutlet UIDatePicker *alarmDatePicker;
@property (strong, nonatomic) IBOutlet UITableView *alarmDateDetail;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property int cvcViewValue;
@property NSString *cvcViewTitle;

@property (nonatomic, retain) NSArray *dataSources;
@end
