//
//  ViewController.m
//  ch13PostFaceBook
//
//  Created by HU QIAO on 2013/12/03.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <Social/Social.h>
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

// Facebookに投稿
- (IBAction)postToFaceBook:(id)sender {
    
    //Facebookが利用可能な端末か（端末のFacebookアカウントを設定しているか）を検証する
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        //SLComposeViewControllerをSLServiceTypeFacebookを指定して作成します。
        SLComposeViewController *controller = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //テキスト
        [controller setInitialText:@"Facebookへ投稿"];
        //画像
        [controller addImage:[UIImage imageNamed:@"shoeisha_logo.gif"]];
        //URL
        [controller addURL:[NSURL URLWithString:@"http://www.shoeisha.co.jp"]];

        //処理終了後に呼び出されるコールバックを指定する
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            
            if (result == SLComposeViewControllerResultCancelled) {
                //Cancelされました。
                NSLog(@"Cancelled");
                
            } else
            {
                //Postされました。
                NSLog(@"Post");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        
        // モーダルで表示
        [self presentViewController:controller animated:YES completion:^{
            // SLComposeViewControllerが表示された時に呼ばれる
            NSLog(@"presentViewController completion");
        }];
    } else {
        //端末にFacebookアカウントを設定していない場合
         NSLog(@"Facebook is not Available");
    }
    
}

@end
