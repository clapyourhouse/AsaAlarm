//
//  CVCSoundViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCSoundViewController.h"
#import "CVCEditViewController.h"
#import "CVCTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define kCellIdentifier @"CellIdentifier"


@interface CVCSoundViewController (){
    AVAudioPlayer *player;
    CVCEditViewController *parent;
    NSString *label;
}

@end

@implementation CVCSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"サウンド";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // iOS5からは最初に一度だけnibファイルを登録すればいい
    [self.tableView registerNib:[UINib nibWithNibName:@"CVCTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    self.tableView.allowsMultipleSelection = NO;

    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"theme_song_01" ofType:@"mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error = nil;
    player =[[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:&error];
    if (!error) {
        [player prepareToPlay];
    }else {
        NSLog(@"AVAudioPlayer Error");
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSArray *array = self.navigationController.viewControllers;
    NSUInteger arrayCount = [array count];
    parent = [array objectAtIndex:arrayCount - 1];
    if ((![parent.popSoundTittle isEqual: @"なし"])) {
        parent.popSoundTittle = label;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}
/**
 * セルの高さ
 */
//- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
//    for (int i = -1; i < indexPath.row; i++) {
//        NSLog(@"i:%d",i);
//        if (![label isEqual:[NSNull null]]) {
//            label = [NSString stringWithFormat:@"ウサボイス%d",i + 1];
//        }
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", label];

    if (indexPath.row == 0) {
        label = @"ウサボイス1";
    }else if(indexPath.row == 1){
        label = @"ウサボイス2";
    }else if (indexPath.row == 2){
        label = @"ウサボイス3";
    }else if (indexPath.row == 3){
        label = @"ウサボイス4";
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", label];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 選択されたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // セルのアクセサリにチェックマークを指定
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (indexPath.row == 0) {
        label = @"ウサボイス1";
//        [player play];
    }else if (indexPath.row == 1) {
        label = @"ウサボイス2";
    }else if (indexPath.row == 2){
        label = @"ウサボイス3";
    }else if (indexPath.row == 3){
        label = @"ウサボイス4";
    }
    parent.popSoundTittle = label;

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        NSLog(@"text=%@",[[alertView textFieldAtIndex:0] text]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//// セルの選択がはずれた時に呼び出される
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択がはずれたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // セルのアクセサリを解除する（チェックマークを外す）
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
