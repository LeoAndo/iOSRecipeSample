//
//  ViewController.m
//  ch7webview
//
//  Created by SHOEISHA on 2013/11/17.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSURLAuthenticationChallenge *authChallenge;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 予め認証に使用する資格情報を作成
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"demouser" password:@"password" persistence:NSURLCredentialPersistenceForSession];
    // 認証の必要な場所の情報を作成
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"www.kackun.com" port:80 protocol:NSURLProtectionSpaceHTTP realm:@"Basic Authentication Demo" authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    // 共有資格情報ストレージに資格情報と場所の情報を格納
    [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:protectionSpace];
    
    // URL文字列からURLオブジェクトを作成する。
    NSURL *targetURL = [NSURL URLWithString:@"http://www.kackun.com/iosrecipedemo/index.html"];
    // URLから、URLリクエストを作成する。
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:targetURL];
    // WebViewに開きたいURLを設定する
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// アクションメニューを開く
- (IBAction)actionButtonDidPush:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Actions" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"Safariで開く", @"100ピクセル下にスクロール", nil];
    [as showFromToolbar:self.toolBar];
}

// UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            // JavaScriptでdocument.URLを取得し、Safariで開く
            NSString *urlString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        }
        case 1:
            // JavaScriptを用い、100ピクセル下にスクロールする
            [self.webView stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0, window.scrollY + 100);"];
            break;
    }
}

// UIWebViewDelegate

// UIWebViewが読み込みを開始
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressView.progress = 0.1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// UIWebViewが読み込みを終了
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.progressView.progress = 1.0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // JavaScriptを用いてタイトルを取得する
    self.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

// UIWebViewで読み込みが失敗
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressView.progress = 0.0;
    if (error.code != NSURLErrorCancelled) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"読み込みに失敗しました。" message:error.localizedDescription  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
