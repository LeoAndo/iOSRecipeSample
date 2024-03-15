//
//  AppDelegate.m
//  ch12localnotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UILocalNotification *notification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        // ローカル通知がある場合、それを処理させる。
        [self application:application didReceiveLocalNotification:notification];
    }
    // Override point for customization after application launch.
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
    // 画面を更新する。
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    if (self.window.rootViewController) {
        [viewController showRemain];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 通知を受け取った際に呼び出される処理
    // アプリケーションがアクティブ時に通知が発生した際に呼び出される他、通知センターから過去の通知が呼び出されたときも発生する。

    // 通知を受けたことを表示する
    NSString *registered = notification.userInfo[@"registered"];
    self.message = [NSString stringWithFormat:@"%@のローカル通知が呼ばれました。", registered];
    
    // 通知をキャンセルすることで、通知センターから削除する。
    [[UIApplication sharedApplication] cancelLocalNotification:notification];

    // 画面を更新する。
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    if (self.window.rootViewController) {
        [viewController showRemain];
    }
}

@end
