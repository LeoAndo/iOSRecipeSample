//
//  ViewController.m
//  ch12localnotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)showRemain
{
    // 残りのローカル通知数を表示する
    NSArray *localNotificaions = [UIApplication sharedApplication].scheduledLocalNotifications;
    self.remainLabel.text = [NSString stringWithFormat:@"残り： %ld", (long)localNotificaions.count];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.messageLabel.text = appDelegate.message;

    // アプリケーションのバッジにも残り個数を表示
    // このサンプルでは、バッジに「まだ行われていない通知の数」を表示していますが、実際のアプリケーションでは
    //「未確認の通知の数」を表示するようにします。
    [UIApplication sharedApplication].applicationIconBadgeNumber = localNotificaions.count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self showRemain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ボタンが押された
- (IBAction)createLocalNotificationButtonDidPush:(id)sender
{
    // これまでに作成した通知のラベルを＋１する
    for (UILocalNotification *notification in [UIApplication sharedApplication].scheduledLocalNotifications) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        if (notification.applicationIconBadgeNumber <= 0) {
            // バッジ番号が0以下の場合は1に変更する
            notification.applicationIconBadgeNumber = 1;
        } else {
            // それ以外の場合は+1する
            notification.applicationIconBadgeNumber++;
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssS";
    NSString *registered = [formatter stringFromDate:[NSDate date]];
    
    // 30秒後に通知を行う
    UILocalNotification *notification = [UILocalNotification new];
    notification.timeZone = [NSTimeZone defaultTimeZone];   // 通知時刻のタイムゾーン
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];   // 通知時刻
    notification.repeatInterval = 0;    // 通知の繰り返し間隔。
    notification.repeatCalendar = nil;  // 再通知間隔
    // 通知時に表示される文字列。省略した場合、通知メッセージが表示されません。
    notification.alertBody = [NSString stringWithFormat:@"[%@]の通知が発生しました。", registered];
    // 通知時に表示されるボタンの名前。
    // 通知に使用する音声ファイル。ファイルはリニアPCM,MA4,aLawまたはμLawのaiff,wav,caf形式で30秒以内とし、メインバンドルに含めておく必要があります。
    // UILocalNotificationDefaultSoundNameにするとシステムのデフォルト音が使用されます。
    // nilを設定した場合は音が鳴りません。
    notification.soundName = UILocalNotificationDefaultSoundName;
    //
    notification.applicationIconBadgeNumber = -1;   // バッジを消す（0の場合は画面上のバッジ数は変更されないため）
    notification.userInfo = @{@"registered": registered};
    notification.alertAction = @"Appで見る";
    notification.hasAction = YES;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.message = [NSString stringWithFormat:@"%@の通知が作成されました。", registered];
    [self showRemain];
}

@end
