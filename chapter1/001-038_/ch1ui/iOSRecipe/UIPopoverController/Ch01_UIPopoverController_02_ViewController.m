//
//  Ch01_UIPopoverController_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPopoverController_02_ViewController.h"

@interface Ch01_UIPopoverController_02_ViewController ()
{
    UIPopoverController * popover;
}
@end

@implementation Ch01_UIPopoverController_02_ViewController

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

- (IBAction)showPopover:(id)sender {
    //ポップオーバー内に表示する画面を初期化する
    //この画面はViewControllerを継承している
    Content2ViewController *contentViewController = [[Content2ViewController alloc] init];
    
    popover.delegate = self;
    
    //ポップオーバー内に表示する画面を指定して初期化する。
    //後で、メソッド「setContentViewController:animated:」で変更できます。
    popover = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    
    //ポップオーバーのサイズを指定する
    popover.popoverContentSize = CGSizeMake(320., 320.);
    
    contentViewController.delegate = self;
    
    UIButton *tappedButton = (UIButton *)sender;
    //ポープオーバーのアンカー表示方向を指定して表示する
    [popover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    popover = nil;
}

-(void)closePopover:(Content2ViewController *)sender{
    if (popover) {
        [popover dismissPopoverAnimated:YES];
        popover = nil;
    }
}

@end
