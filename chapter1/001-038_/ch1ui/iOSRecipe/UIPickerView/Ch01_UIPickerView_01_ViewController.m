//
//  Ch01_UIPickerView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPickerView_01_ViewController.h"
#import "PickerViewController.h"
#import "Ch01_AppDelegate.h"

@interface Ch01_UIPickerView_01_ViewController ()
{
    PickerViewController *piclerViewController;
}
@end

@implementation Ch01_UIPickerView_01_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPickerView:(id)sender {
    piclerViewController = [[PickerViewController alloc] init];
    
    piclerViewController.delegate = self;
    
    // PickerViewをサブビューとして表示する
    UIView *pickerView = piclerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // アニメーション開始時のPickerViewの位置を計算
    UIWindow* mainWindow = (((Ch01_AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height*1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // アニメーションを使ってPickerViewを表示する
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    pickerView.center = middleCenter;
    [UIView commitAnimations];
}

-(void)closePickerView:(PickerViewController *)sender{
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *pickerView = sender.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}

@end
