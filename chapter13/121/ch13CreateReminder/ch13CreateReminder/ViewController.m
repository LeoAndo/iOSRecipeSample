//
//  ViewController.m
//  ch13CreateReminder
//
//  Created by HU QIAO on 2013/11/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderText;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
// EKEventStoreインスタンス
@property (nonatomic, strong) EKEventStore *eventStore;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // EKEventStoreを初期化する
    self.eventStore = [[EKEventStore alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//リマインダー作成ボタンを押下した時の動作
- (IBAction)createReminder:(id)sender {
    
    // リマインダーへのアクセスの許可状況を確認し、リマインダーを表示する
    [self checkEventStoreAccessForReminder];
    
}


// リマインダーへのアクセスの許可状況を確認する
-(void)checkEventStoreAccessForReminder
{
    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    
    //EKAuthorizationStatusの値に応じて処理する
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       //アクセスをユーザーが許可している場合
        {
            //デフォルトカレンダーへのアクセスを行う
            [self createReminder];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    //まだユーザにアクセス許可のアラートを出していない状態
        {
            // 「このアプリがリマインダーへのアクセスを求めています」といったアラートが表示される
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // ユーザーがアクセスを許可した場合
                     //メインスレッドを止めないためにdispatch_asyncを使って処理をバックグラウンドで行う
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 許可されたら、リマインダー作成を行う
                         [weakSelf createReminder];
                     });
                 } else {
                     // ユーザーがアクセス拒否した場合
                     // UIAlertViewの表示をメインスレッドで行う
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"確認"
                                                     message:@"このアプリのリマインダーへのアクセスを許可するには、プライバシーから設定する必要があります。"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil]
                          show];
                     });
                 }
             }];
            
        }
            break;
        case EKAuthorizationStatusDenied:           //アクセスをユーザーから拒否されている場合
        case EKAuthorizationStatusRestricted:       //iPhoneの設定の「機能制限」でマリマインダーへのアクセスを制限している場合
        {
            //アラートを表示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                            message:@"リマインダーへのアクセスが許可されていません。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

//タスクをリマインダーに登録する
-(void)createReminder
{
    
    // 追加するリマインダーオブジェクトを作成する
    EKReminder *reminder = [EKReminder
                            reminderWithEventStore:self.eventStore];
    
    // タイトルを設定する
    reminder.title = _reminderText.text;
    
    // iPhone標準の設定アプリで指定した、「デフォルトカレンダー」を指します
    reminder.calendar = [_eventStore defaultCalendarForNewReminders];
    
    
    // DatePickerで入力した日時を取得
    NSDate *date = [_datePicker date];
    
    // Alarmを設定する
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date];
    [reminder addAlarm:alarm];
    
    // 期限を設定する
    //  入力した日時＋１時間
    reminder.dueDateComponents = [[NSCalendar currentCalendar] components: NSMinuteCalendarUnit | NSHourCalendarUnit |NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                                 fromDate:[date dateByAddingTimeInterval:1*60*60]];
    
    // リマインダーを登録
    NSError *error = nil;
    BOOL success = [_eventStore saveReminder:reminder commit:YES error:&error];
    if (!success) {
        NSLog(@"error = %@", error);
        //登録失敗した場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"リマインダーへのタスク登録が失敗しました。"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        //登録成功した場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完了"
                                                        message:@"リマインダーへタスクを登録しました。"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//キーボードを非表示にする
- (IBAction)hideKeyboard:(id)sender {
    [_reminderText resignFirstResponder];
    
}


@end
