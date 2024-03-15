//
//  ViewController.m
//  Rate
//
//  Created by katsuya on 2014/01/21.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "iRate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // idを任意のアプリのIDに置き換える
    [iRate sharedInstance].appStoreID = 441710134;
    
    // アプリの使用回数
    [iRate sharedInstance].usesCount = 10;
    
    // 特定の「イベント」を通過した回数。特定のイベントを行ったらlogEventメソッドを呼び出すように実装しておく。
    [iRate sharedInstance].eventsUntilPrompt = 10;
    
    // アプリの使用日数
    [iRate sharedInstance].daysUntilPrompt = 10;
    
    // アプリの週毎の使用回数
    [iRate sharedInstance].usesPerWeekForPrompt = 10;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
