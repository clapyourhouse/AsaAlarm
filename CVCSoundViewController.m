//
//  CVCSoundViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCSoundViewController.h"
#import "CVCTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define kCellIdentifier @"CellIdentifier"


@interface CVCSoundViewController (){
    AVAudioPlayer *player;
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
    NSString *cellIdentifier = kCellIdentifier;
    CVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[CVCTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CVCTableViewCell *customCell = (CVCTableViewCell *) cell;
    NSString *label;
    if (indexPath.row == 0) {
        label = @"サウンド";
    }else if(indexPath.row == 1){
        label = @"タイトル";
    }else if (indexPath.row == 2){
        label = @"繰り返し";
    }else if (indexPath.row == 3){
        label = @"スヌーズ";
    }
    customCell.titileLbl.text = [NSString stringWithFormat:@"%@", label];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    //    NSLog(@"「%@」が選択されました", [spotData objectAtIndex:indexPath.row]);
    if (indexPath.row == 0) {
        [player play];
        //ライフサイクルで
//        [self.navigationController popViewControllerAnimated:YES];

    }else if (indexPath.row == 1) {
        UIAlertView* alert = [UIAlertView new];
        alert.title = @"サウンド";
        alert.message = @"この音でよろしいですか？";
        alert.delegate = self;  //<UIAlertViewDelegate>を設定する事
        [alert addButtonWithTitle:@"cancel"];
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];//１行で実装
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        NSLog(@"text=%@",[[alertView textFieldAtIndex:0] text]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//// セルの選択がはずれた時に呼び出される
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 選択がはずれたセルを取得
//    CVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    
//    // セルのアクセサリを解除する（チェックマークを外す）
//    cell.accessoryType = UITableViewCellAccessoryNone;
//}

@end
