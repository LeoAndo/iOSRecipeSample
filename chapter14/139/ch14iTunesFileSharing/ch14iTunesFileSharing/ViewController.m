//
//  ViewController.m
//  ch14iTunesFileSharing
//
//  Created by HU QIAO on 2014/01/07.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

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

- (IBAction)ShowImage:(id)sender {
    
    // ドキュメントフォルダへのパスを取得（<Application_Home>/Documents）
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *userDocumentsPath = [paths objectAtIndex:0];
    
    // ドキュメントフォルダの中のリストを得る
    NSError *error = nil;
    NSArray *array = [[NSFileManager defaultManager]
                      contentsOfDirectoryAtPath:userDocumentsPath error:&error];
    
    // ドキュメントフォルダにファイルが存在している場合
    if (array) {
        
        for (NSString *filename in array) {
            //	拡張子が jpgのファイル取得
            if ([[filename pathExtension] isEqualToString:@"jpg"]) {
                //	ドキュメントフォルダのパスとファイルの名前を使用して、画像ファイルパスを作成
                NSString *imageFilePath = [userDocumentsPath stringByAppendingPathComponent:filename];
                
                // UIImageを作成
                UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
                if (image) {
                    //　UIImageView にセット
                    _image.image = image;
                    return;
                }
            }
        }
    }
}

@end
