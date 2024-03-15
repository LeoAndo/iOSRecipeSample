//
//  Ch01_UITextField_03_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/05.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITextField_03_ViewController.h"

@interface Ch01_UITextField_03_ViewController ()

@end

@implementation Ch01_UITextField_03_ViewController

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
    
    self.textfield1.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 入力済みのテキストを取得
    NSMutableString *str = [textField.text mutableCopy];
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];

    BOOL ret = YES;
    ret =[self isNumber:str];

    return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",@"test");
}

//数字入力制限チェク
- (BOOL)isNumber:(NSString *)value {
    
    // 空文字の場合はNO
    if ( (value == nil) || ([@"" isEqualToString:value]) ) {
        return NO;
    }
    
    int l = [value length];
    
    BOOL b = NO;
    for (int i = 0; i < l; i++) {
        NSString *str = [[value substringFromIndex:i] substringToIndex:1];
        const char *c = [str cStringUsingEncoding:NSASCIIStringEncoding];
        if ( c == NULL ) {
            b = NO;
            break;
        }
        if ((c[0] >= 0x30) && (c[0] <= 0x39)) {
            b = YES;
        } else {
            b = NO;
            break;
        }
    }
    
    if (b) {
        return YES;  // 数値文字列である
    } else {
        return NO;
    }
}

@end
