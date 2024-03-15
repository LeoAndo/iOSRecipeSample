//
//  ViewController.m
//  ch13CalendarList
//
//  Created by HU QIAO on 2013/11/20.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController () < UITableViewDelegate,UITableViewDataSource>

//テーブルビュー
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// EKEventStoreインスタンス
@property (nonatomic, strong) EKEventStore *eventStore;
// カレンダーインスタンス
@property (nonatomic, strong) EKCalendar *calendar;
// イベントリスト
@property (nonatomic, strong) NSMutableArray *eventsList;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //　テーブルビューを設定する
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // EKEventStoreを初期化する
	self.eventStore = [[EKEventStore alloc] init];
    
    // イベントリストを初期化する
	self.eventsList = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // カレンダーへのアクセスの許可状況を確認する
    [self checkEventStoreAccessForCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// テーブルの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.eventsList.count;
}

// 行に表示するデータ
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //識別名でセルを探す
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    
    // イベントのタイトルを行に表示する
    cell.textLabel.text = [[self.eventsList objectAtIndex:indexPath.row] title];
    
    return cell;
}


// カレンダーへのアクセス許可状況を確認する
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
            [self accessGrantedForCalendar];
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
                         [weakSelf accessGrantedForCalendar];
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


// デフォルトカレンダーのイベントを取得し、テーブルビューを更新する
-(void)accessGrantedForCalendar
{
    //読み取り対象カレンダーを指定する
    //iPhone標準の設定アプリで指定した「デフォルトカレンダー」を指します。
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    // 1日前から2日後までのイベントを検索し、eventsListにセットする
    self.eventsList = [self fetchDefaultEvents];
    // テーブルビューを更新する
    [self.tableView reloadData];
}


//1日前から2日後までのデフォルトカレンダーのイベントを検索する
- (NSMutableArray *)fetchDefaultEvents
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //1日前
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    //2日後
    NSDateComponents *oneDayAfterComponents = [[NSDateComponents alloc] init];
    oneDayAfterComponents.day = 2;
    NSDate *oneDayAfter = [calendar dateByAddingComponents:oneDayAfterComponents
                                                    toDate:[NSDate date]
                                                   options:0];
    
    
	// 読み取り対象カレンダーに設定されているイベントの検索を指定する
	NSArray *calendarArray = [NSArray arrayWithObject:self.calendar];
    
    //イベントを検索するためのNSPredicateオブジェクトを作成する
	NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:oneDayAgo
                                                                      endDate:oneDayAfter
                                                                    calendars:calendarArray];
	
    // イベントを検索する
	NSMutableArray *events = [NSMutableArray arrayWithArray:[self.eventStore eventsMatchingPredicate:predicate]];
    
    // イベントプロパティを取得する
	for ( EKEvent * event in events ) {
        NSLog(@"EKEvent");
        NSLog(@"Title: %@, Start Date: %@, End Date: %@, Location: %@", event.title, event.startDate, event.endDate, event.location);
        NSLog(@"EKCalendarItem");
        NSLog(@"Calendar Title: %@, Calendar Source Type: %u", event.calendar.title, event.calendar.source.sourceType);
    }
    
	return events;
}

@end
