//
//  ViewController.m
//  ch5trim
//
//  Created by SHOEISHA on 2013/10/14.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSURL *imageURL;
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

// Load Imageボタンを押した時の処理
- (IBAction)loadImageButtonDidPush:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

// イメージピッカーで画像が選択された
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 選択された画像の中央部分をトリミングして表示
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    CGImageRef imageRef = [image CGImage];

    int trimX = image.size.width / 2 - 80;
    if (trimX < 0) {
        trimX = 0;
    }
    int trimY = image.size.height / 2 - 80;
    if (trimY < 0) {
        trimY = 0;
    }
    CGRect trimRect = CGRectMake(trimX, trimY, 320, 320);

    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
//    self.imageView.image = [UIImage imageWithCGImage:newImageRef];
    self.leftImageView.image = [UIImage imageWithCGImage:newImageRef scale:2.0 orientation:UIImageOrientationUp];
    self.rightImageView.image = self.leftImageView.image;
    // createCGImageで作成していたCGImageの解放
    CGImageRelease(newImageRef);
    
    // オリジナルファイルのURLを保存
    imageURL = info[UIImagePickerControllerReferenceURL];
    
    // イメージピッカーを閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 画像を切り取る
- (IBAction)cropButtonDidPush:(id)sender
{
    UIImage *image = self.leftImageView.image;
    if (image) {
        CGFloat scale = image.scale;
        UIImageOrientation orientation = image.imageOrientation;
            
        CGImageRef imageRef = [image CGImage];
        // イメージの周囲10ピクセルを切り取る
        int trimX, trimY;
        int trimWidth = (image.size.width - 20) * scale;
        int trimHeight = (image.size.height - 20) * scale;

        if (trimWidth > 0) {
            trimX = 10 * scale;
        } else {
            trimX = 0;
            trimWidth = image.size.width;
        }
        if (trimHeight > 0) {
            trimY = 10 * scale;
        } else {
            trimY = 0;
            trimHeight = image.size.height;
        }

        CGRect trimRect = CGRectMake(trimX, trimY, trimWidth, trimHeight);
        
        CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
        self.rightImageView.image = [UIImage imageWithCGImage:newImageRef scale:scale orientation:orientation];
        // CGImageCreateWithImageInRectで作成していたCGImageの解放
        CGImageRelease(newImageRef);
    }
}

@end
