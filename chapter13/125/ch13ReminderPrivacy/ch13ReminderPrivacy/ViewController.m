//
//  ViewController.m
//  ch13ReminderPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//


#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "ViewController.h"

@interface ViewController ()

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

//プライバシー→リマインダーの状態ボタンを押下した時の処理
- (IBAction)checkReminderAuthorizationStatus:(id)sender {

    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    //ユーザーにまだアクセスの許可を求めていない場合
    if(status == EKAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"ユーザーにまだアクセスの許可を求めていない"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //iPhoneの設定の「機能制限」でリマインダーへのアクセスを制限している場合
    else if(status == EKAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"iPhoneの設定の「機能制限」でリマインダーへのアクセスを制限している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //リマインダーへのアクセスをユーザーから拒否されている場合
    else if(status == EKAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"リマインダーへのアクセスをユーザーから拒否されている"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //リマインダーへのアクセスをユーザーが許可している場合
    else if(status == EKAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"リマインダーへのアクセスをユーザーが許可している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)showReminder:(id)sender {
    
    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    
    //EKAuthorizationStatusの値に応じて処理する
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       //アクセスをユーザーが許可している場合
        {
            //デフォルトカレンダーへのアクセスを行う
            [self doingSomethingWithReminder];
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
                         // 許可されたら、EKEntityTypeReminderへのアクセスを行う
                         [weakSelf doingSomethingWithReminder];
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
        case EKAuthorizationStatusRestricted:       //iPhoneの設定の「機能制限」でマインダーへのアクセスを制限している場合
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

//リマインダーを操作する
-(void)doingSomethingWithReminder
{
    
    [[[UIAlertView alloc] initWithTitle:@"確認"
                                message:@"リマインダー操作処理が行えます。"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil]
     show];

}


@end
