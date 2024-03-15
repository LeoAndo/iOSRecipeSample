//
//  ViewController.m
//  ch14UserDefaults
//
//  Created by HU QIAO on 2014/01/19.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // NSUserDefaultsインスタンスの取得
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 設定値の取得
    NSString *frontName = [defaults objectForKey:@"firstname"];
    NSString *lastName = [defaults objectForKey:@"lastname"];
    long age = [defaults integerForKey:@"age"];
    NSString *ageString = [NSString stringWithFormat:@"%li",age];
    
    // UIを更新
    _firstNameTextField.text = frontName;
    _lastNameTextField.text = lastName;
    _ageTextField.text = ageString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    // キーボードを非表示に
    [_firstNameTextField resignFirstResponder];
    [_lastNameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    
    // 入力値を取得
    NSString *firstName = [_firstNameTextField text];
    NSString *lastName = [_lastNameTextField text];
    long age = [[_ageTextField text] integerValue];
    
    // NSUserDefaultsインスタンスの取得
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 入力値をNSUserDefaultsインスタンスにセット
    [defaults setObject:firstName forKey:@"firstname"];
    [defaults setObject:lastName forKey:@"lastname"];
    [defaults setInteger:age forKey:@"age"];
    
    // シンクロナイズ
    BOOL successful = [defaults synchronize];

    if (successful) {
        NSLog(@"%@", @"設定の保存に成功しました。");
    }

}

@end
