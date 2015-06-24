//
//  CVCMainViewController.h
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/18.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCMainViewController : UIViewController{
    UINavigationController *navCon;
}
- (IBAction)mainBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *MessageLbl;

@end
