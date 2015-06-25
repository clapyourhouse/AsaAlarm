//
//  CVCEditViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/22.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//
//TODO
//設定が上書きされてしまう事。
//スヌーズ
//繰り返し
//音も含め想定通りの動きをすること
//複数localnotificaionが登録できる事。http://xcodeprogirl.hatenablog.com/entry/2013/12/20/151102
//長押し時menuがでること
//cellごとに個別のデータを持ちたい場合の構造。クリアする？
#import "CVCEditViewController.h"
#import "CVCSoundViewController.h"
#import "CVCViewController.h"
#import "CVCSnoozeViewController.h"
#import "CVCRepeatViewController.h"
#import "CVCTableViewCell.h"
#import "CVCViewCell.h"

#define kCellIdentifier @"CellIdentifier"

@interface CVCEditViewController (){
    UITableViewCell *cell;
    NSUserDefaults *ud;
}

@end

@implementation CVCEditViewController
@synthesize cvcViewValue,alarmDateDetail,alarmDatePicker;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"アラーム編集";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    // iOS5からは最初に一度だけnibファイルを登録すればいい
    [self.tableView registerNib:[UINib nibWithNibName:@"CVCTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    NSLog(@"データ？:%d",cvcViewValue);

    alarmDatePicker.datePickerMode = UIDatePickerModeTime;
    // 日付ピッカーの値が変更されたときに呼ばれるメソッドを設定
    [alarmDatePicker addTarget:self
                   action:@selector(datePicker_ValueChanged:)
         forControlEvents:UIControlEventValueChanged];
    self.tableView.allowsMultipleSelection = NO;

}
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [super viewWillDisappear:animated];
    CVCViewCell *cellVal = [[CVCViewCell alloc]init];
    cellVal.capLabel.text = @"ほげ";
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
}

/**
 * 日付ピッカーの値が変更されたとき
 */
- (void)datePicker_ValueChanged:(id)sender
{
    UIDatePicker *datePicker = sender;
    
    // 日付の表示形式を設定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd/HH:mm";
    NSString *setDate = [df stringFromDate:datePicker.date];
    NSArray *names = [setDate componentsSeparatedByString:@"/"];
    NSString *x = [names objectAtIndex:0];
    int year = [x intValue];
    NSString *y = [names objectAtIndex:1];
    int month = [y intValue];
    NSString *z = [names objectAtIndex:2];
    int day = [z intValue];
    NSString *times = [names objectAtIndex:3];
    NSArray *time = [times componentsSeparatedByString:@":"];
    NSLog(@"%@",time);
    NSString *xx = [time objectAtIndex:0];
    int hour = [xx intValue];
    NSString *yy = [time objectAtIndex:1];
    int minute = [yy intValue];

    [self calenderFromNotification:year :month :day :hour :minute];
    // ログに日付を表示
    NSLog(@"%@", [df stringFromDate:datePicker.date]);
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
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[CVCTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CVCTableViewCell *customCell = (CVCTableViewCell *) cell;
    NSString *sublabel;
    NSString *mainLabel;
    ud = [NSUserDefaults standardUserDefaults];
    if (indexPath.row == 0) {
        sublabel = @"サウンド";
    }else if(indexPath.row == 1){
        sublabel = @"タイトル";
        mainLabel = [ud stringForKey:@"KEY_S"];
        if (mainLabel) {
            customCell.setLbl.text = mainLabel;
        }
    }else if (indexPath.row == 2){
        sublabel = @"繰り返し";
    }else if (indexPath.row == 3){
        sublabel = @"スヌーズ";
        NSInteger v = [ud integerForKey:@"KEY_I"];
        NSString *m = [NSString stringWithFormat:@"%ld",(long)v];
        customCell.setLbl.text = [NSString stringWithFormat:@"%@分", m];
    }
    customCell.titileLbl.text = [NSString stringWithFormat:@"%@", sublabel];

    
    return cell;
    
}

/**
 * セルが選択されたとき
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //    NSLog(@"「%@」が選択されました", [spotData objectAtIndex:indexPath.row]);
    if (indexPath.row == 0) {
        CVCSoundViewController *cvc = [[CVCSoundViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.row == 1) {
        UIAlertView* alert = [UIAlertView new];
        alert.title = @"タイトル";
        alert.message = @"メッセージ";
        alert.delegate = self;  //<UIAlertViewDelegate>を設定する事
        [alert addButtonWithTitle:@"cancel"];
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];//１行で実装
        [alert show];
    }else if (indexPath.row == 2){
        CVCRepeatViewController *cvc = [[CVCRepeatViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
//        CVCTableViewCell *customCell = (CVCTableViewCell *) cell;
//        customCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if (indexPath.row == 3){
        CVCSnoozeViewController *cvc = [[CVCSnoozeViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
// セルの選択がはずれた時に呼び出される
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択がはずれたセルを取得
//    CVCTableViewCell *customCell = (CVCTableViewCell *) cell;
    // セルのアクセサリを解除する（チェックマークを外す）
//    customCell.accessoryType = UITableViewCellAccessoryNone;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        NSLog(@"text=%@",[[alertView textFieldAtIndex:0] text]);
        NSString *alarmTitle = [[alertView textFieldAtIndex:0] text];
        ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:alarmTitle forKey:@"KEY_S"];

        [self.tableView reloadData];
    }
}

- (void)calenderFromNotification:(int)year :(int)month :(int)day :(int)hour :(int)minute{
    NSLog(@"%d年%d月%d日%d時%d分",year,month,day,hour,minute);
    //西暦で計算するよう設定
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    //曜日を指定。0が日曜日。順に行って6が土曜日。
    [comps setWeekday:2];
    //その月の何週目に通知させるか指定する。このメソッドを追加することにより、アラームを毎週リピートにしても、第２週にお知らせしてくれる。
    [comps setWeekdayOrdinal:3];
    //時間を指定。+9しているのは、GMT時間を日本時間に合わせる為。
    [comps setHour:hour+9];
    //分を指定
    [comps setMinute:minute];
    NSDate *date = [calender dateFromComponents:comps];
    NSLog(@"日時=%@", date);
    
    //現在時刻から取得した時間の差を求める
    NSDate* now = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    NSLog(@"現在時刻:%@",now);
    NSTimeInterval span = [date timeIntervalSinceDate:now];
    NSLog(@"時差は：%f",span);
    //ローカル通知
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    //ローカル通知させる時間を設定する
    notification.fireDate = [[NSDate date]dateByAddingTimeInterval:span];
    //毎週アラームを通知させる
    notification.repeatInterval = NSWeekCalendarUnit;
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.applicationIconBadgeNumber = 1;
    notification.alertBody = [NSString stringWithFormat:@"起きなさい"];
    //通知されたときの音
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertAction = @"おはよ";
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"通知を受信しました" forKey:@"EventKey"];
    notification.userInfo = infoDict;
    
    
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *notifications = [[NSArray alloc]initWithArray:app.scheduledLocalNotifications copyItems:YES];
////    [app cancelAllLocalNotifications];
//    for (UILocalNotification *notificationns in notifications) {
//        [app scheduleLocalNotification:notificationns];
//        NSLog(@"登録件数:%lu",(unsigned long)[notifications count]);
//
//    }
//    上記ローカル通知をアプリケーションに登録
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
    NSArray *notifyItems = [[UIApplication sharedApplication]scheduledLocalNotifications];
    //登録されているアラーム件数を表示
    NSLog(@"登録件数:%lu",(unsigned long)[notifyItems count]);
    for (UILocalNotification *notify in notifyItems) {
        //登録されているアラートボディを表示
        NSLog(@"body:%@",[notify alertBody]);
    }
}


@end
