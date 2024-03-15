//
//  ViewController.m
//  ch12notification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableData *receivedData;
    NSURLSessionTask *currentTask;
    NSUInteger dataLength;
}

// ログに文字列を出力する
- (void)appendLogString:(NSString *)string
{
    _textView.text = [_textView.text stringByAppendingString:string];
    [_textView.layoutManager ensureLayoutForTextContainer:_textView.textContainer];
    [_textView layoutIfNeeded];
    CGFloat y = _textView.contentSize.height - _textView.frame.size.height;
    if (y < 0) {
        y = 0;
    }
    [_textView setContentOffset:CGPointMake(0, y) animated:YES];
}

// 認証が必要
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    if (currentTask == task) {
        if (![challenge proposedCredential]) {
            // 認証をまだ一度も行っていない
            NSString *user = @"demouser";
            NSString *password = @"password";
            [self appendLogString:[NSString stringWithFormat:@"認証が必要です。ユーザー：%@ パスワード：%@ で試みます。\n", user, password]];
            
            // 認証に使用する資格情報を作成。
            NSURLCredential *credential = [NSURLCredential credentialWithUser:user password:password persistence:NSURLCredentialPersistenceForSession];
            
            // 資格情報を使用して認証を試みる。
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            // 認証に失敗
            [self appendLogString:@"認証に失敗しました。取得処理をキャンセルします。\n"];
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, NULL);
        }
    }
}

// レスポンスを受信した
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    if (currentTask == dataTask) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        // ステータスコードを取得する
        int status = [httpResponse statusCode];
        [self appendLogString:[NSString stringWithFormat:@"HTTPステータスコード:%d\n", status]];

        // ヘッダーを取得する
        NSDictionary *headers = [httpResponse allHeaderFields];
        for(id key in [headers keyEnumerator]) {
            [self appendLogString:[NSString stringWithFormat:@"[Header] %@: %@\n", key, [headers valueForKey:key]]];
        }
        
        // データ受信用インスタンスを初期化する
        receivedData = [NSMutableData dataWithCapacity:512];
        dataLength = 0;
        
        // タスクを続ける
        completionHandler(NSURLSessionResponseAllow);
    }
}

// データを取得した
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (currentTask == dataTask) {
        // データを受信した時の処理
        // 完了するまで複数回にわたって呼び出されるので、その都度ストリームに書き出すなどの処理を行う。
        [self appendLogString:[NSString stringWithFormat:@"%uバイトのデータを受信しました。\n", data.length]];

        // データを受信用インスタンスに追加する。なお、サンプルでは受信済みデータが512バイトを超えた部分を無視する。
        if (dataLength < 512) {
            int needLength = 512 - dataLength;
            [receivedData appendData:[data subdataWithRange:NSMakeRange(0, needLength)]];
        }
        dataLength += data.length;
    }
}

// 取得が完了した
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (currentTask == task) {
        if (!error) {
            // データの取得が完了した時の処理
            [self appendLogString:[NSString stringWithFormat:@"受信した総データ量：%uバイト\n", dataLength]];
            NSString *string = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
            [self appendLogString:[NSString stringWithFormat:@"受信したデータの内容（512バイトまで）：\n%@\n", string]];
        } else {
            // エラーが発生した時の処理
            [self appendLogString:[NSString stringWithFormat:@"受信エラー: %@ %d:%@\n", [error domain], [error code], [error localizedDescription]]];
        }
        [self appendLogString:@"取得処理が完了しました！\n\n"];
        // これまでに取得した結果を破棄
        receivedData = nil;
        
        // NSURLSessionTaskの後片付けをする
        [currentTask cancel];
        currentTask = nil;
    }
}

// ボタンが押された
- (IBAction)createLocalNotificationButtonDidPush:(id)sender
{
    if (!currentTask) {
        // 現在取得していなければ、取得を実行する

        // 取得先のURLを指定する。
        //NSURL *url = [NSURL URLWithString:@"https://ntp-a1.nict.go.jp/cgi-bin/time"];         // NICT 日本標準時
        //NSURL *url = [NSURL URLWithString:@"http://ja.wikipedia.org/wiki/%E3%83%A1%E3%82%A4%E3%83%B3%E3%83%9A%E3%83%BC%E3%82%B8"];   // Wikipedia メインページ
        NSURL *url = [NSURL URLWithString:@"http://www.kackun.com/iosrecipedemo/index.txt"];    // BASIC認証デモ
        
        [self appendLogString:[[url absoluteString] stringByAppendingString:@"からデータ取得を開始します。\n"]];
        
        // 接続の設定を行う。
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 3G/LTEを利用したアクセスを行う
        sessionConfig.allowsCellularAccess = YES;

        // セッションの作成
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        // タスクの作成
        currentTask = [session dataTaskWithURL:url];
        // タスクを開始
        [currentTask resume];
        
    } else {
        // 現在取得中の場合、キャンセルする
        [currentTask cancel];
        currentTask = nil;
        [self appendLogString:@"キャンセルしました。\n\n"];
    }
}

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

@end
