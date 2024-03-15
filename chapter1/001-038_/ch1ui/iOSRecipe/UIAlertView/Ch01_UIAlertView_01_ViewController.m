//
//  Ch01_UIAlertView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/08.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIAlertView_01_ViewController.h"

@interface Ch01_UIAlertView_01_ViewController ()

@end

@implementation Ch01_UIAlertView_01_ViewController

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
    
    // アラートビューを作成
    // キャンセルボタンを表示しない場合はcancelButtonTitleにnilを指定
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertViewタイトル"
                          message:@"ボタンを押してください。"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Button1", nil];
    
    //初期化後ボタンを追加
    [alert addButtonWithTitle:@"Button2"];
    //UIAlertViewDelegateの実現を指定する
    alert.delegate = self;
    
    // アラートビューを表示
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            //１番目のボタン「Cancel」が押されたときの処理を記述する
            self.uiLabel.text = @"Cancelボタンを選択した";
            break;
        case 1:
            //２番目のボタン「Button1」が押されたときの処理を記述する
            self.uiLabel.text = @"Button1を選択した";
            break;
        case 2:
            //３番目のボタン「Button2」が押されたときの処理を記述する
            self.uiLabel.text = @"Button2を選択した";
            break;
        case 3:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
