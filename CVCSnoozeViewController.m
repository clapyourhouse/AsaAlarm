//
//  CVCSnoozeViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/24.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCSnoozeViewController.h"
#import "CVCEditViewController.h"
#import "CVCTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define kCellIdentifier @"CellIdentifier"

@interface CVCSnoozeViewController ()

@end

@implementation CVCSnoozeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"スヌーズ";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // iOS5からは最初に一度だけnibファイルを登録すればいい
    [self.tableView registerNib:[UINib nibWithNibName:@"CVCTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    self.tableView.allowsMultipleSelection = NO;
    

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
    return 6;
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
    NSString *label;
    if (indexPath.row == 0) {
        label = @"なし";
        cell.textLabel.text = label;
        cell.detailTextLabel.text = @"スヌーズ";
        
    }else if(indexPath.row == 1){
        label = @"1分";
    }else if (indexPath.row == 2){
        label = @"3分";
    }else if (indexPath.row == 3){
        label = @"5分";
    }else if (indexPath.row == 4){
        label = @"9分";
    }else if (indexPath.row == 5){
        label = @"15分";
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
    NSLog(@"何番目？:%ld",(long)indexPath.row);
    // NSUserDefaultsに保存・更新する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (indexPath.row == 0) {
    }else if (indexPath.row == 1) {
    }else if (indexPath.row == 2) {
    }else if (indexPath.row == 3) {
    }else if (indexPath.row == 4) {
        [ud setInteger:9 forKey:@"KEY_I"];
    }else if (indexPath.row == 5) {
        [ud setInteger:15 forKey:@"KEY_I"];
    }
    [ud synchronize];

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
