//
//  AppDelegate.m
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *controller = (MasterViewController *)navigationController.topViewController;

    // ディレクトリーのリストを取得する
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths[0];
    NSString *databaseFilePath = [documentDirectory stringByAppendingPathComponent:@"ch15database.db"];
    // インスタンスを作成する
    _database = [FMDatabase databaseWithPath:databaseFilePath];
    // データベースを開く
    [_database open];

    // テーブルの存在をチェックする
    FMResultSet *results = [_database executeQuery:@"SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = 'stations';"];
    // テーブルが存在すれば行がある
    if (![results next]) {
        // トランザクションを開始
        // テーブルを作成する
        [_database beginTransaction];
        [_database executeUpdate:@"CREATE TABLE stations (sid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, distance REAL, memo TEXT);"];
        // 初期データを追加する。
        NSArray *stations = @[
                              @[@"西代", @0.0,@"起点駅"],
                              @[@"板宿", @1.0,@"神戸市営地下鉄西神・山手線乗換"],
                              @[@"東須磨", @1.8,@"車庫"],
                              @[@"月見山", @2.6,@"須磨海浜水族園"],
                              @[@"須磨寺", @3.3,@"神社仏閣多し"],
                              @[@"山陽須磨", @3.7,@"2号線沿いの駅"],
                              @[@"須磨浦公園", @5.1,@"ロープウェイ乗換"],
                              @[@"山陽塩屋", @6.8,@"JR乗換可"],
                              @[@"滝の茶屋", @7.8,@"眺望良し"],
                              @[@"東垂水", @8.6,@"海づり公園"],
                              @[@"山陽垂水", @9.6,@"JR乗換可"],
                              @[@"霞ヶ丘", @10.7,@"五色塚古墳"],
                              @[@"舞子公園", @11.5,@"明石海峡大橋"],
                              @[@"西舞子", @12.4,@"神社多し"],
                              @[@"大蔵谷", @14.3,@"大蔵海岸"],
                              @[@"人丸前", @14.9,@"明石天文科学館"],
                              @[@"山陽明石", @15.7,@"明石城"],
                              @[@"西新町", @16.9,@"高架化工事中"],
                              @[@"林崎松江海岸", @18.4,@"住宅地"],
                              @[@"藤江", @20.4,@"住宅地"],
                              @[@"中八木", @21.8,@"住宅地"],
                              @[@"江井ヶ島", @23.5,@"住宅地"],
                              @[@"西江井ケ島", @24.9,@"住宅地"],
                              @[@"山陽魚住", @25.6,@"住宅地"],
                              @[@"東二見", @27.3,@"住宅地"],
                              @[@"西二見", @28.6,@"イトーヨーカドー明石店"],
                              @[@"播磨町", @29.9,@"住宅地"],
                              @[@"別府", @32.2,@"イトーヨーカドー別府店"],
                              @[@"浜の宮", @34.1,@"駅前トーホー北マルアイ"],
                              @[@"尾上の松", @35.5,@"鶴林寺"],
                              @[@"高砂", @37.3,@"北側出口欲しい"],
                              @[@"荒井", @38.5,@"工業系多し"],
                              @[@"伊保", @39.7,@"高砂市役所"],
                              @[@"山陽曽根", @41.3,@"曽根天満宮"],
                              @[@"大塩", @42.8,@"大塩天満宮"],
                              @[@"的形", @44.2,@"潮干狩場"],
                              @[@"八家", @46.2,@"八家地蔵"],
                              @[@"白浜の宮", @47.6,@"灘のけんか祭り"],
                              @[@"妻鹿", @49.0,@"市川"],
                              @[@"飾磨", @50.9,@"網干線乗換"],
                              @[@"亀山", @52.3,@"姫路バイパス"],
                              @[@"手柄", @53.4,@"手柄山"],
                              @[@"山陽姫路", @54.7,@"姫路城"],
                            ];
        for (NSArray *station in stations) {
            [_database executeUpdate:@"INSERT INTO stations(name, distance, memo) VALUES (?, ?, ?);", station[0], station[1], station[2]];
        }
        // トランザクションをコミット
        [_database commit];
    }
    controller.database = _database;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // データベースを閉じる
    [_database close];
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
