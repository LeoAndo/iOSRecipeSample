//
//  ViewController.m
//  ch13PostTweet
//
//  Created by HU QIAO on 2013/12/02.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postTweet:(id)sender {
    
    // POST対象のitemをArrayに入れる
    NSArray *activityItems;
    // テキスト
    NSString* postText = @"test string";
    // 画像
    UIImage* postImage = [UIImage imageNamed:@"shoeisha_logo.gif"];
    //URL
    NSURL* postUrl = [NSURL URLWithString:@"http://www.shoeisha.co.jp"];
    activityItems = @[postText, postImage, postUrl];
    
    // UIActivityViewControllerを作成
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    
    // 除外したいShare先を該当する定数を配列にして、excludedActivityTypesに代入
    activityController.excludedActivityTypes =
    @[UIActivityTypePrint,
      UIActivityTypePostToFacebook,
      UIActivityTypeSaveToCameraRoll,
      UIActivityTypeMail
      ];
    
    
    // completionHandler完了時の動作
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed) {
        //動作が完了した時に呼ばれる
        //activityType:Twitterの場合はcom.apple.UIKit.activity.PostToTwitter
        //completed: Postされた場合は１、Cancleされた場合は０
        NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
    }];
    
    // モーダルで表示
    [self presentViewController:activityController animated:YES completion:^{
        // UIActivityViewControllerが表示された時に呼ばれる
        NSLog(@"presentViewController completion");
    }];
}



@end
