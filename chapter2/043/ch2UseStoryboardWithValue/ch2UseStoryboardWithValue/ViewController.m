//
//  ViewController.m
//  ch2UseStoryboardWithValue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // セグエから遷移先画面のViewContollerを取得
    SubViewController *subViewController = [segue destinationViewController];

    // データ受け渡し用プロパティにデータをセットする
    if ( [[segue identifier] isEqualToString:@"segue1"] ) {
        subViewController.receiveString = @"from button 1";
    } else {
        subViewController.receiveString = @"from button 2";
    }
}

@end
