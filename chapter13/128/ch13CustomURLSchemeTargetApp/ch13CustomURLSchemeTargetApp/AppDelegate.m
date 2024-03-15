//
//  AppDelegate.m
//  ch13CustomURLSchemeTargetApp
//
//  Created by HU QIAO on 2013/12/08.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate()

@property (strong, nonatomic) ViewController *viewController;

@end

@implementation AppDelegate



//アプリがまだ起動されていない場合には、didFinishLaunchingWithOptionsとopenURLが続けて呼ばれます。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyBoard instantiateViewControllerWithIdentifier:@"MyViewController"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
	if (launchOptions) {
		
		[self.viewController showMessage:@"didFinishLaunchingWithOptions was called:\n\n"];
        
        //URLスキームで起動された場合、「launchOptions」 のキー：「UIApplicationLaunchOptionsURLKey」には、呼び出されたURLが格納されています。
		NSURL *launchURL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
		[self.viewController showMessage:[launchURL description]];
        
    }
	
    return YES;
}

//アプリ自身が既に起動済みの場合にはopenURLだけが呼ばれます
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
 
        
	[self.viewController showMessage:@"\n\nopenURL was called:\n\n"];

    NSString* strUrl = [NSString stringWithFormat:@"url:\n%@\n\n",[url description]];
	[self.viewController showMessage:strUrl];

    
	NSString* strSrcApp = [NSString stringWithFormat:@"sourceApplication:\n%@\n\n",sourceApplication];
	[self.viewController showMessage:strSrcApp];
	
	NSString* strAnnotation = [NSString stringWithFormat:@"annotation:\n%@\n\n",[annotation description]];
	[self.viewController showMessage:strAnnotation];
	
	return YES;
	
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    
    ;;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    ;
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
