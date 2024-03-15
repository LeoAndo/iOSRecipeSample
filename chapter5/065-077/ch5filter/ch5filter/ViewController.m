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
    CGImageRef originalImageRef;
    NSArray *filterNames;
    NSArray *filterArray;
    NSString *nameKey;
    NSString *filterNameKey;
    NSString *parametersKey;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSNull *null = [NSNull null];
    NSArray *empty = @[];

    nameKey = @"Name";
    filterNameKey = @"FilterName";
    parametersKey = @"Parameters";
    
    /*
     連想配列で、フィルターの名前、設定情報を保持
     */
    filterArray = @[
                    @{
                        nameKey: @"フィルターなし",
                        filterNameKey: null,
                        parametersKey: empty,
                    },
                    // 色調操作系
                    @{
                        nameKey: @"画像の反転",
                        filterNameKey: @"CIColorInvert",
                        parametersKey: empty,
                    },
                    @{
                        nameKey: @"モノクローム",
                        filterNameKey: @"CIColorMonochrome",
                        parametersKey: @{
                                kCIInputColorKey: [CIColor colorWithRed:0.5 green:0.5 blue:0.5],
                                kCIInputIntensityKey: @1.0,
                        },
                    },
                    @{
                        nameKey: @"セピア調",
                        filterNameKey: @"CISepiaTone",
                        parametersKey: @{
                                kCIInputIntensityKey: @1.0,
                        },
                    },
                    @{
                        nameKey: @"ポスタリゼーション",
                        filterNameKey: @"CIColorPosterize",
                        parametersKey: @{@"inputLevels": @2.0},
                        },
                    @{
                        nameKey: @"ガンマ比",
                        filterNameKey: @"CIGammaAdjust",
                        parametersKey: @{
                                @"inputPower": @1.2,
                                },
                        },
                    @{
                        nameKey: @"明度・コントラスト",
                        filterNameKey: @"CIColorControls",
                        parametersKey: @{
                                kCIInputBrightnessKey: @0.5,
                                kCIInputContrastKey: @2.0,
                                },
                        },
                    @{
                        nameKey: @"彩度",
                        filterNameKey: @"CIColorControls",
                        parametersKey: @{
                                kCIInputSaturationKey: @2.0,
                        },
                    },
                    @{
                        nameKey: @"ビブランス",
                        filterNameKey: @"CIVibrance",
                        parametersKey: @{
                                @"inputAmount": @1.0,
                                },
                        },
                    @{
                        nameKey: @"色相",
                        filterNameKey: @"CIHueAdjust",
                        parametersKey: @{
                                kCIInputAngleKey: @M_PI_2,
                        },
                    },
                    @{
                        nameKey: @"ガウスぼかし",
                        filterNameKey: @"CIGaussianBlur",
                        parametersKey: @{
                                kCIInputRadiusKey: @3.0,
                        },
                    },
                    @{
                        nameKey: @"アンシャープマスク",
                        filterNameKey: @"CIUnsharpMask",
                        parametersKey: @{
                                kCIInputRadiusKey: @3.0,
                        },
                    },
                    @{
                        nameKey: @"水玉状スクリーン",
                        filterNameKey: @"CIDotScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                        },
                    },
                    @{
                        nameKey: @"渦巻状スクリーン",
                        filterNameKey: @"CICircularScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                                },
                        },
                    @{
                        nameKey: @"格子状スクリーン",
                        filterNameKey: @"CIHatchedScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                        },
                    },
                    @{
                        nameKey: @"直線状スクリーン",
                        filterNameKey: @"CILineScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                                },
                        },
                    @{
                        nameKey: @"ピクセレート",
                        filterNameKey: @"CIPixellate",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputScaleKey: @10.0,
                        },
                    },
    ];
    originalImageRef = CGImageRetain([self.rightImageView.image CGImage]);
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

- (UIImage *)execImageWithCGImage:(CGImageRef)imageRef
{
    return [UIImage imageWithCGImage:imageRef scale:2.0 orientation:UIImageOrientationUp];
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

    // 編集後のCGImageRefが残っていれば開放する
    if (originalImageRef) {
        CGImageRelease(originalImageRef);
    }
    
    originalImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
    // 左側【オリジナル）画像を差し替える
    UIImage *thumbImage = [self execImageWithCGImage:originalImageRef];
    self.leftImageView.image = thumbImage;
    self.rightImageView.image = thumbImage;
    
    // イメージピッカーを閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // ピッカービューを初期状態に戻す
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}

// UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return filterArray.count;
}

// UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return filterArray[row][nameKey];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // ピッカービューの選択状況に応じてフィルターを適用する
    if (row > 0) {
        // UIImageからCIImageを生成
        CIImage *image = [CIImage imageWithCGImage:originalImageRef];
        CIFilter *filter;
        
        // フィルターを設定
        NSDictionary *filterDic = filterArray[row];
        filter = [CIFilter filterWithName:filterDic[filterNameKey]];
        NSDictionary *paramDic = filterDic[parametersKey];

        // 連想配列を用いてフィルターのパラメーターを設定
        [filter setValuesForKeysWithDictionary:paramDic];

        // 元になる画像を指定
        [filter setValue:image forKey:kCIInputImageKey];

        // フィルター適用後の画像を取得する
        CIImage *newImage = filter.outputImage;
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef newImageRef = [context createCGImage:newImage fromRect:newImage.extent];
        
        // 画像を右イメージビューにセット
        self.rightImageView.image = [self execImageWithCGImage:newImageRef];
        
        // createCGImageで作成していたCGImageの解放
        CGImageRelease(newImageRef);
    } else {
        // オリジナル画像を表示
        self.rightImageView.image = self.leftImageView.image;
    }
}

@end
