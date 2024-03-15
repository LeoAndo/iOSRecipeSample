//
//  Ch01_UIActionSheet_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIActionSheet_01_ViewController.h"

@interface Ch01_UIActionSheet_01_ViewController ()

@end

@implementation Ch01_UIActionSheet_01_ViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showActionSheet:(id)sender {
    // Do any additional setup after loading the view from its nib.
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  //タイトルをセットする
                                  initWithTitle:@"UIActionSheetサンプル"
                                  //デリゲートを指定する
                                  delegate:self
                                  //キャンセルボタンのタイトルを指定する
                                  cancelButtonTitle:@"キャンセル"
                                  //赤色の警告ボタンのタイトルを指定する
                                  destructiveButtonTitle:@"削除"
                                  //ほかのボタンを指定する
                                  otherButtonTitles:@"button1",@"button2", nil];
    
    //ビューの中にアクションシートを表示する
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            self.label1.text=@"削除ボタン";
            break;
        case 1:
            self.label1.text=@"button1";
            break;
        case 2:
            self.label1.text=@"button2";
            break;
        case 3:
            self.label1.text=@"キャンセルボタン";
            break;
    }
}
@end
