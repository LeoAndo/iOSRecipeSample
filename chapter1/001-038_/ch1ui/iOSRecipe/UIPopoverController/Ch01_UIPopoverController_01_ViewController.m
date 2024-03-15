//
//  Ch01_ UIPopoverController _01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/12.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPopoverController_01_ViewController.h"
#include "ContentViewController.h"

@interface Ch01_UIPopoverController_01_ViewController ()
{
    UIPopoverController *popover;
}
@end

@implementation Ch01_UIPopoverController_01_ViewController

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

- (IBAction)showPopOver:(id)sender {
    
    //ポップオーバー内に表示する画面を初期化する
    //この画面はViewControllerを継承している
    ContentViewController *contentViewController = [[ContentViewController alloc] init];
    
    //ポップオーバー内に表示する画面を指定して初期化する。
    //後で、メソッド「setContentViewController:animated:」で変更できます。
    popover = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    
    //ポップオーバーのサイズを指定する
    popover.popoverContentSize = CGSizeMake(320., 320.);
    
    //ポップオーバーの背景色を指定する
    popover.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:0.5];
    
    //ポップオーバーを終了しない外部ビューを指定する
    popover.passthroughViews = @[self.textField];
    
    UIButton *tappedButton = (UIButton *)sender;
    //ポープオーバーのアンカー表示方向を指定して表示する
    [popover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
