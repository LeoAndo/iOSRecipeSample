//
//  Ch01_UIAlertView_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/12.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIAlertView_02_ViewController.h"

@interface Ch01_UIAlertView_02_ViewController ()

@end

@implementation Ch01_UIAlertView_02_ViewController

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
}

//UIAlertViewStyleDefault：テキストフィールドが表示されない
- (IBAction)showAlertViewWithDefault:(id)sender {
    // アラートビューを作成
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertViewタイトル"
                          message:@"ボタンを押してください。"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    //UIAlertViewDelegateの実現を指定する
    alert.delegate = self;
    alert.tag = 1;
    // アラートビューを表示
    [alert show];
}

//UIAlertViewStyleSecureTextInput：パスワード入力用テキストフィールドが表示される
- (IBAction)showAlertViewWithUIAlertViewStylePlainTextInput:(id)sender {
    // アラートビューを作成
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertViewタイトル"
                          message:@"ボタンを押してください。"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    //UIAlertViewDelegateの実現を指定する
    alert.delegate = self;
    alert.tag = 2;
    // アラートビューを表示
    [alert show];
}

//UIAlertViewStylePlainTextInput：通常テキスト入力用フィールドが表示される
- (IBAction)showAlertViewWithPlainTextInput:(id)sender {
    // アラートビューを作成
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertViewタイトル"
                          message:@"ボタンを押してください。"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    //UIAlertViewDelegateの実現を指定する
    alert.delegate = self;
    alert.tag = 3;
    // アラートビューを表示
    [alert show];
}

//UIAlertViewStyleLoginAndPasswordInput：ユーザーID入力用フィールドとパスワード入力テキストフィールドが表示される
- (IBAction)showAlertWithLoginAndPasswordInput:(id)sender {
    // アラートビューを作成
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertViewタイトル"
                          message:@"ボタンを押してください。"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    //UIAlertViewDelegateの実現を指定する
    alert.delegate = self;
    alert.tag = 4;
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
            if(1 == alertView.tag) {
                break;
            }
            if(4 == alertView.tag){
                //ログインフィールド
                self.uiLabel.text = [[alertView textFieldAtIndex:0] text];
                //パスワードフィールド
                self.uiLabel2.text = [[alertView textFieldAtIndex:1] text];
            } else {
                self.uiLabel.text = [[alertView textFieldAtIndex:0] text];
            }

            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
