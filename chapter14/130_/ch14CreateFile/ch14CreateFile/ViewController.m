//
//  ViewController.m
//  ch14CreateFile
//
//  Created by HU QIAO on 2013/10/06.
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

- (IBAction)createFile:(id)sender {
    
    // アプリケーションのドキュメントディレクトリの場所を特定
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Documentディレクトリへのファイルバスは配列の一つ目の要素
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    
    // 新規ディレクトのパス
    NSString *newDocumentDirPath = [docDirectory stringByAppendingPathComponent:@"newDirectory"];
    
    // FileManagerを用いて、ディレクトを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:newDocumentDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    if (!created) {
        // 作成に失敗した場合
        NSString *errMsg = [NSString stringWithFormat:@"ディレクト作成に失敗しました。%@ - %@",error, error.userInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認"
                                                        message:errMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // ファイルのパス
    NSString *savedPath = [newDocumentDirPath stringByAppendingPathComponent:@"sampleFile.txt"];
    
    // 空ファイルを作成
    created = [fileManager createFileAtPath:savedPath
                                   contents:nil
                                 attributes:nil];
    
    if (!created) {
        // 作成に失敗した場合
        NSString *errMsg = [NSString stringWithFormat:@"空ファイル作成に失敗しました。%d - %s",errno, strerror(errno)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認"
                                                        message:errMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    } else {
        // 作成に成功した場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認"
                                                        message:[savedPath stringByAppendingString:@"に空ファイルを作成しました。"]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
