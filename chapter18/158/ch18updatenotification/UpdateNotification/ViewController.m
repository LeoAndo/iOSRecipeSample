//
//  ViewController.m
//  UpdateNotification
//
//  Created by katsuya on 2014/01/21.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // idを任意のアプリのIDに置き換える
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=441710134"]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    NSURLResponse *response;
    NSError *error;
    
    // 同期でSearchAPIを呼び出す
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
    
    // APIのレスポンス(JSON)をパースする
    NSDictionary *dictionary  = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error];
    NSDictionary *results = [[dictionary objectForKey:@"results"] objectAtIndex:0];
    
    // キー「version」がアプリのバージョンに相当する
    NSString *latestVersion = [results objectForKey:@"version"];
    
    // 現在のバージョン
    NSString *currentVersion = [[NSBundle mainBundle]
                                objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // バージョンが同じではない = AppStoreに新しいバージョンのアプリがあるとする
    if (![currentVersion isEqualToString:latestVersion]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"アップデートがあります"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"AppStoreへ", nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        NSURL* url= [NSURL URLWithString:@"https://itunes.apple.com/jp/app/xiang-yong-shemediarida/id441710134?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
