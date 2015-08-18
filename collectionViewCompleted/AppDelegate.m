//
//  AppDelegate.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/18.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "AppDelegate.h"
#import "CVCMainViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate (){
    AVAudioPlayer *player;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    CVCMainViewController *cvc = [[CVCMainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:cvc];
    self.viewController = nav;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //iOS8からローカル通知もユーザーの許可がいる。
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //これでどんだけでも通知内容をこちらに持ってこれる。//ここで見て、音を分ければいける。
    //スヌーズも値を持っておいて、値がデフォルトでなければ、+分でアラームを開始。
    NSLog(@"notificationAlert%@",notification.alertBody);
    //userInfoで必要な情報をすべて持ってきて、アラーム登録のメソッドを呼び出すだけかな？
    NSArray *array = [notification.userInfo objectForKey:@"EventKey"];
    NSString *string = [array objectAtIndex:2];
    NSLog(@"eventString:%@",string);
    NSLog(@"notification:%@",notification);
    if ([string isEqualToString:@"ウサボイス1"]) {
        NSLog(@"ウサボイス1の音源を再生します。");
            NSString *path = [[NSBundle mainBundle] pathForResource:@"theme_song_01" ofType:@"mp3"];
            NSURL *file = [[NSURL alloc]initFileURLWithPath:path];
            player = [[AVAudioPlayer alloc]initWithContentsOfURL:file error:nil];
            [player prepareToPlay];
            [player play];
    }else if([string isEqualToString:@"ウサボイス2"]){
    }else if([string isEqualToString:@"ウサボイス3"]){
    }else if([string isEqualToString:@"ウサボイス4"]){
    }
    // アプリ起動中(フォアグラウンド)に通知が届いた場合
    if(application.applicationState == UIApplicationStateActive) {
        // ここに処理を書く
    }
    
    // アプリがバックグラウンドにある状態で通知が届いた場合
    if(application.applicationState == UIApplicationStateInactive) {
        // ここに処理を書く
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"わーい"
                                                        message:notification.alertBody
                                                       delegate:nil
                                              cancelButtonTitle:@"起きる"
                                              otherButtonTitles: @"スヌーズ",nil];
    [alertView show];
    
    // 通知領域から削除する
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        NSLog(@"スヌーズ");
        
    }
}
@end
