//
//  ViewController.m
//  ch10FaceDetector
//
//  Created by shoeisha on 2013/12/07.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UIImageView* imageView;
    
    UIImage* imagePortrait;
    UIImage* imageLandscape;
}
@end

@implementation ViewController

- (NSArray*)detectFaces
{
    // 顔検出オブジェクト
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];

    // 画像
    CIImage* targetImage = [[CIImage alloc] initWithCGImage:imageView.image.CGImage];
    
    // 検出
    NSArray* results = [detector featuresInImage:targetImage
                                         options:@{
                                                   CIDetectorSmile    : [NSNumber numberWithBool:YES],
                                                   CIDetectorEyeBlink : [NSNumber numberWithBool:YES],
                                                   }];

    // CoreImageは左下原点なので、UIKitと同じ左上原点に変換
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1, -1), 0, -imageView.bounds.size.height);

    // マーカーリスト
    NSMutableArray* list = [[NSMutableArray alloc] initWithCapacity:results.count];

    for (CIFaceFeature* result in results) {
#if 1
        // 検出位置を座標変換
        CGRect rect = CGRectApplyAffineTransform(result.bounds, transform);
        
        // リスト登録
        UIView* view = [[UIView alloc] initWithFrame:rect];
        view.layer.borderWidth = 2;
        if (result.hasSmile) {
            view.layer.borderColor = [[UIColor yellowColor] CGColor];       // 笑顔であれば黄色枠
        } else {
            if (result.leftEyeClosed) {
                view.layer.borderColor = [[UIColor blueColor] CGColor];     // 左目を閉じていれば青枠
            } else if (result.rightEyeClosed) {
                view.layer.borderColor = [[UIColor redColor] CGColor];      // 右目を閉じていれば赤枠
            } else {
                view.layer.borderColor = [[UIColor greenColor] CGColor];    // 両目を開いていれば緑枠
            }
        }
#else
        // マスク作成
        CGFloat height = result.bounds.size.height / 8;
        CGRect mask = CGRectMake(result.bounds.origin.x,
                                 (result.leftEyePosition.y + result.rightEyePosition.y - height) / 2,
                                 result.bounds.size.width, height);
        
        // 検出位置を座標変換
        CGRect rect = CGRectApplyAffineTransform(mask, transform);
        
        // リスト登録
        UIView* view = [[UIView alloc] initWithFrame:rect];
        view.layer.backgroundColor = [[UIColor blackColor] CGColor];
#endif
        [list addObject:view];
    }
    
    return list;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 画像読み込み
    imagePortrait  = [UIImage imageNamed:@"MonaLisa.jpg"];
    imageLandscape = [UIImage imageNamed:@"AnatomyLesson.jpg"];
    
    // ImageViewへ画像割り当て
    imageView.image = imagePortrait;

    // 顔検出マーカー表示
    for (UIView* view in [self detectFaces]) [imageView addSubview:view];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

// オリエンテーションタイプ
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

// 初期オリエンテーション
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

// オリエンテーション開始
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // 顔検出マーカー削除
    for (UIView* view in imageView.subviews) [view removeFromSuperview];
}

// オリエンテーション完了
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        // 縦画面
        imageView.image  = imagePortrait;
        imageView.frame  = CGRectMake(-32, 20, imagePortrait.size.width, imagePortrait.size.height);
    } else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        // 横画面
        imageView.image  = imageLandscape;
        imageView.frame  = CGRectMake(0, 20, imageLandscape.size.width, imageLandscape.size.height);
    }

    // 顔検出マーカー表示
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 顔検出バックグラウンド処理
        NSArray* views = [self detectFaces];
        
        // バックグラウンド処理完了後表示
        dispatch_async(dispatch_get_main_queue(), ^{
            // 顔検出マーカー削除
            for (UIView* view in imageView.subviews) [view removeFromSuperview];

            // 顔検出マーカー登録
            for (UIView* view in views) {
                [imageView addSubview:view];
            }
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
