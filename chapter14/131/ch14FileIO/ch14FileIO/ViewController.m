//
//  ViewController.m
//  ch14FileIO
//
//  Created by HU QIAO on 2014/01/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"

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

- (IBAction)textFile:(id)sender {
    
    // テンポラリフォルダ配下の新規ディレクトのパス
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"textFile"];
    
    // FileManagerを用いて、ディレクトを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、ログを出力
    if (!created) {
        NSLog(@"ディレクト作成に失敗した. reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // ファイルのパス
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sampleFile.txt"];
 
    //保存するテキストの内容
    NSString *string = @"Hello, World";
    
    // ファイルへ書き込み
    created = [string writeToFile:filePath               // ファイルパス
                       atomically:YES                    // 予備ファイルを生成
                         encoding:NSUTF8StringEncoding   // 文字コード
                            error:&error];               // エラー
    
    // 失敗した場合は、ログを出力
    if (!created) {
        NSLog(@"ファイルへ書き込みに失敗しました。reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    
    // テキストファイルを読み取る
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath                  // ファイルパス
                                                       encoding:NSUTF8StringEncoding      // 文字コード
                                                          error:&error];                  // エラー
    if ([fileContents isEqualToString:string]) {
        NSLog(@"%@", @"同じテキストです。");
    }
    
}

- (IBAction)archive:(id)sender {

    // テンポラリフォルダ配下の新規ディレクトのパス
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"archive"];
    
    // FileManagerを用いて、ディレクトを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、ログを出力
    if (!created) {
        NSLog(@"作成に失敗した。reason is %@ - %@", error, error.userInfo);
        return;
    }

    // ファイルのパス
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sample.dat"];
    
    //NSArray オブジェクトをアーカイブしてファイルに保存
    NSArray *before = @[@"Hello, world", @"こんにちは"];
    BOOL successful = [NSKeyedArchiver archiveRootObject:before toFile:filePath];
    
    if (successful) {
        NSLog(@"%@", @"データの保存に成功しました。");
    } else{
        NSLog(@"データの保存に失敗しました。 reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // アーカイブされたデータを読み込む
    NSArray *after = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (after) {
        for (NSString *data in after) {
            NSLog(@"%@", data);
        }
        if ([before isEqualToArray:after]) {
            NSLog(@"%@", @"同じオブジェクトです。");
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
 
    
}

- (IBAction)nscoding:(id)sender {

    // テンポラリフォルダ配下の新規ディレクトのパス
    NSString *newTempDirPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"nscoding"];
    
    // FileManagerを用いて、ディレクトを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newTempDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、ログを出力
    if (!created) {
        NSLog(@"作成に失敗した。reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    // ファイルのパス
    NSString *filePath = [newTempDirPath stringByAppendingPathComponent:@"sample.dat"];
    
    Book *firstBook = [[Book alloc] init];
    firstBook.author = @"翔泳社太郎";
    firstBook.title = @"おはよう";
    Book *secondBook = [[Book alloc] init];
    secondBook.author = @"翔泳社花子";
    secondBook.title = @"こんにちは";
    
    //自作クラスのオブジェクトをアーカイブしてファイルに保存
    NSArray *before = @[firstBook, secondBook];
    BOOL successful = [NSKeyedArchiver archiveRootObject:before toFile:filePath];
    
    if (successful) {
        NSLog(@"%@", @"データの保存に成功しました。");
    } else{
        NSLog(@"データの保存に失敗しました。 reason is %@ - %@", error, error.userInfo);
        return;
    }
    
    //自作クラスのオブジェクトを復元する
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (array) {
        for (Book *book in array) {
            NSLog(@"%@", book.author);
            NSLog(@"%@", book.title);
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }

}

@end
