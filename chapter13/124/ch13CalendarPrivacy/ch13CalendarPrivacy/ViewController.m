//
//  ViewController.m
//  ch13CalendarPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController ()  <EKEventEditViewDelegate>

// EKEventStoreインスタンス
@property (nonatomic, strong) EKEventStore *eventStore;
// カレンダーインスタンス
@property (nonatomic, strong) EKCalendar *calendar;


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

//プライバシー→カレンダーの状態ボタンを押下した時の処理
- (IBAction)checkCalendarAuthorizationStatus:(id)sender {
    
    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    //ユーザーにまだアクセスの許可を求めていない場合
    if(status == EKAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"ユーザーにまだアクセスの許可を求めていない"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //iPhoneの設定の「機能制限」でカレンダーへのアクセスを制限している場合
    else if(status == EKAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"iPhoneの設定の「機能制限」でカレンダーへのアクセスを制限している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //カレンダーへのアクセスをユーザーから拒否されている場合
    else if(status == EKAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"カレンダーへのアクセスをユーザーから拒否されている"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //カレンダーへのアクセスをユーザーが許可している場合
    else if(status == EKAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"カレンダーへのアクセスをユーザーが許可している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

//イベント表示ボタンを押下した時の処理
- (IBAction)showEventView:(id)sender {
    
    
    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    //EKAuthorizationStatusの値に応じて処理する
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       //アクセスをユーザーが許可している場合
        {
            //デフォルトカレンダーへのアクセスを行う
            [self showEKEventEditView];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    //まだユーザにアクセス許可のアラートを出していない状態
        {
            // 「このアプリがカレンダーへのアクセスを求めています」といったアラートが表示される
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // ユーザーがアクセスを許可した場合
                     //メインスレッドを止めないためにdispatch_asyncを使って処理をバックグラウンドで行う
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 許可されたら、デフォルトカレンダーへのアクセスを行う
                         [weakSelf showEKEventEditView];
                     });
                 } else {
                     // ユーザーがアクセス拒否した場合
                     // UIAlertViewの表示をメインスレッドで行う
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"確認"
                                                     message:@"このアプリのカレンダーへのアクセスを許可するには、プライバシーから設定する必要があります。"
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
        case EKAuthorizationStatusRestricted:       //iPhoneの設定の「機能制限」でカレンダーへのアクセスを制限している場合
        {
            //アラートを表示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                            message:@"カレンダーへのアクセスが許可されていません。"
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

//イベント登録画面を表示する
-(void)showEKEventEditView
{
    //iPhone標準の設定アプリで指定した、「デフォルトカレンダー」を指します。
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    
    //イベント登録画面に表示する内容を指定する
    EKEvent *event = [EKEvent eventWithEventStore:_eventStore];
    
    /*イベント追加画面の作成*/
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] init];
	addController.eventStore = self.eventStore;
    addController.event = event;
    addController.editViewDelegate = self;
    
    [self presentViewController:addController animated:YES completion:nil];
}


//イベント追加画面の処理に反応するメソッド
- (void)eventEditViewController:(EKEventEditViewController *)controller
		  didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


// EKEventEditViewControllerの処理対象を指定した「デフォルトカレンダー」にする
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
	return self.calendar;
}


@end
