//
//  CVCMainViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/18.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCMainViewController.h"
#import "CVCViewController.h"
#define MESSAGE1 @"やあ"
#define MESSAGE2 @"Good morning"
#define MESSAGE3 @"いい天気"
#define MESSAGE4 @"What's up?"
#define MESSAGE5 @"はーい"

@interface CVCMainViewController ()

@end

@implementation CVCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self randMessage];
}

- (void)randMessage{
    //乱数はこれが定番みたい。
    int randInt = arc4random_uniform(5);
    if (randInt == 0) {
        _MessageLbl.text = MESSAGE1;
    }else if (randInt == 1){
        _MessageLbl.text = MESSAGE2;
        
    }else if (randInt == 2){
        _MessageLbl.text = MESSAGE3;
        
    }else if (randInt == 3){
        _MessageLbl.text = MESSAGE4;
        
    }else if (randInt == 4){
        _MessageLbl.text = MESSAGE5;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self randMessage];
    NSLog(@"viewDidDisappear");
    [super viewDidDisappear:animated];
}


- (IBAction)mainBtn:(id)sender {
    CVCViewController *cvc = [[CVCViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
//    navCon = [[UINavigationController alloc]initWithRootViewController:cvc];
//    [self presentViewController:navCon animated:YES completion:nil];
}
@end
