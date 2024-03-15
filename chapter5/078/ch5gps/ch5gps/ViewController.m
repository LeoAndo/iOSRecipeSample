//
//  ViewController.m
//  ch5trim
//
//  Created by SHOEISHA on 2013/10/14.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

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
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    
    // 位置情報を読んで情報を表示させる
    [self showLocationFromURL:info[UIImagePickerControllerReferenceURL] animated:YES];
    
    // イメージピッカーを閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// アセットライブラリーを用いて地図表示する
- (void)showLocationFromURL:(NSURL *)url animated:(BOOL)animated
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:url
                  resultBlock:^(ALAsset *asset)
     {
         // アセットが使用できる場合
         ALAssetRepresentation *assetRepresentation = asset.defaultRepresentation;
         NSDictionary *metadata = assetRepresentation.metadata;
         // 位置情報を取得
         NSDictionary *gpsDic = metadata[(NSString *)kCGImagePropertyGPSDictionary];
         if (gpsDic) {
             NSNumber *longitude = gpsDic[(NSString *)kCGImagePropertyGPSLongitude];
             NSString *longitudeRef = gpsDic[(NSString *)kCGImagePropertyGPSLongitudeRef];
             NSNumber *latitude = gpsDic[(NSString *)kCGImagePropertyGPSLatitude];
             NSString *latitudeRef = gpsDic[(NSString *)kCGImagePropertyGPSLatitudeRef];
             if (longitude && longitudeRef && latitude && latitudeRef) {
                 self.locationLabel.text = [NSString stringWithFormat:@"%@%@,%@%@",longitudeRef, longitude, latitudeRef, latitude];
                 CLLocationCoordinate2D location = CLLocationCoordinate2DMake(([latitudeRef isEqualToString:@"N"] ? 1 : -1) * [latitude doubleValue], ([longitudeRef isEqualToString:@"E"] ? 1 : -1) * [longitude doubleValue]);
                 [self.mapView setCenterCoordinate:location animated:animated];
             }
         } else {
             self.locationLabel.text = @"この画像には位置情報がありません。";
         }
     }
                 failureBlock:^(NSError *error)
    {
            self.locationLabel.text = @"AssetsLibraryの使用に失敗しました。";
    }];
}

@end
