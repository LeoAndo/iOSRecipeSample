//
//  ViewController.m
//  ch13AddEvent
//
//  Created by HU QIAO on 2013/11/21.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "ViewController.h"

@interface ViewController () <EKEventEditViewDelegate>

// EKEventStoreインスタンス
@property (nonatomic, strong) EKEventStore *eventStore;
// カレンダーインスタンス
@property (nonatomic, strong) EKCalendar *calendar;
// 処理結果メッセージを表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *feedbackMsg;

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


// イベント追加ボタンを押下した時の処理
- (IBAction)addEvent:(id)sender {
    
    // カレンダー情報へのアクセスの許可状況を確認し、イベント登録画面を表示する
    [self checkEventStoreAccessForCalendar];
    
}

// カレンダー情報へのアクセスの許可状況を確認する
-(void)checkEventStoreAccessForCalendar
{
    //アクセス許可についてのステータスを取得する
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    //EKAuthorizationStatusの値に応じて処理する
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       //アクセスをユーザーが許可している場合
        {
            //デフォルトカレンダーへのアクセスを行う
            [self addEventToCalendar];
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
                         [weakSelf addEventToCalendar];
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

//イベント追加画面（EKEventEditViewController）を表示するメソッド
-(void)addEventToCalendar
{
    
    //追加するイベントオブジェクトを作成する
    EKEvent *event = [EKEvent eventWithEventStore:_eventStore];
    //タイトル
    event.title = @"iOS開発勉強会";
    //場所
    event.location = @"翔泳社";
    //開始時間
    event.startDate = [NSDate date];
    //終了時間　86400秒のプレゼント
    event.endDate = [NSDate dateWithTimeIntervalSinceNow:86400];
    //メモ
    event.notes = @"Mac持参";
    
    //イベント追加画面を作成
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] init];

    //イベントオブジェクトをイベント追加画面に渡す
    addController.event = event;

	//イベントストアをイベント追加画面に渡す
    addController.eventStore = self.eventStore;
    
    //追加の通知を受け取るためのデリゲートをを設定
    addController.editViewDelegate = self;
    
    // イベント追加画面をモーダル画面として表示
    [self presentViewController:addController animated:YES completion:nil];
}


// EKEventEditViewControllerの処理対象を指定した「デフォルトカレンダー」にする
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
    //iPhone標準の設定アプリで指定した、「デフォルトカレンダー」を指す。
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    
	return self.calendar;
}

//ユーザがイベント追加画面を終了したときに通知を受け取るためのデリゲート
//モーダルモードのView Controller を閉じるeventEditViewController:didCompleteWithAction:メソッドを実装する
- (void)eventEditViewController:(EKEventEditViewController *)controller
		  didCompleteWithAction:(EKEventEditViewAction)action
{
    ViewController * __weak weakSelf = self;
    weakSelf.feedbackMsg.hidden = NO;
    
    // モーダルのイベント追加画面を閉じる
    [self dismissViewControllerAnimated:YES completion:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSError *error = nil;
             switch (action) {
                 case EKEventEditViewActionCanceled:
                     //キャンセルボタンが押されたら
                     weakSelf.feedbackMsg.text = @"イベントの登録がキャンセルされました。";
                     break;
                 case EKEventEditViewActionSaved:
                 {
                     //完了ボタンが押されたら
                     [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
                     weakSelf.feedbackMsg.text = @"イベントが登録されました。";
                 }
                     break;
                 default:
                     break;
             }
         });
     }];
}



@end
