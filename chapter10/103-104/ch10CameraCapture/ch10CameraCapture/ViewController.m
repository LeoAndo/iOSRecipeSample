//
//  ViewController.m
//  ch10CameraCapture
//
//  Created by shoeisha on 2013/12/08.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* label;
    IBOutlet UIButton* save;
}
@end

@implementation ViewController

- (IBAction)takePicture:(id)sender
{
    // カメラが利用できるか確認
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // インスタンス生成
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];

        // カメラからの取得を指定
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 撮影後の編集不可
        imagePickerController.allowsEditing = NO;

        // デリゲートをこのクラスに指定
        imagePickerController.delegate = self;
        
        // 起動
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

// 撮影完了時に呼び出されるメソッド
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 撮影した画像をImageViewへ渡す
    imageView.image = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
   
    label.text   = [NSString stringWithFormat:@"%.f x %.f", imageView.image.size.width, imageView.image.size.height];
    save.enabled = YES;

    // カメラを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 撮影キャンセル時に呼び出されるメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    label.text = @"Canceled";

    // 撮影がキャンセルされた場合もカメラを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture:(id)sender
{
    // 写真をフォトアルバムへ保存
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 保存完了時に呼び出されるメソッド
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        // 保存失敗のユーザー処理
        NSLog(@"%@ : %@ (%d) ", error.domain, error.localizedDescription, error.code);
    } else {
        // 保存成功のユーザー処理
        save.enabled = NO;
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
