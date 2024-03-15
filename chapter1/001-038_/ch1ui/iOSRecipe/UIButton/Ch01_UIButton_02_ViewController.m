//
//  Ch01_UIButton_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/04.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIButton_02_ViewController.h"

@interface Ch01_UIButton_02_ViewController ()

@end

@implementation Ch01_UIButton_02_ViewController

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
    [self setRichButton];
    [self roundButton:self.button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//正常状態のボタンをリッチなタイトルをセットする
-(void)setRichButton {
    NSString *str = @"IOS ボタン　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"ボタン"];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"Futura-CondensedMedium" size:25.]
                    range:range1];
    
    NSRange range2 = [str rangeOfString:@"IOS"];
    //赤色の標準打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]} range:range2];
    
    NSRange range3 = [str rangeOfString:@"ボタン"];
    //緑色の太線の打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor greenColor]} range:range3];
    
    NSRange range4 = [str rangeOfString:@"サンプル"];
    //青色の二重線の打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor blueColor]} range:range4];
    
    [self.button1 setAttributedTitle:attrStr forState:UIControlStateNormal];
}

//角丸/黒の半透明背景ボタンにセットする
- (void)roundButton:(UIButton*)button{
    CALayer *buttonLayer = button.layer;
    [buttonLayer setMasksToBounds:YES];
    [buttonLayer setCornerRadius:7.5f];
    [buttonLayer setBorderWidth:1.0f];
    [buttonLayer setBorderColor:[[UIColor blackColor] CGColor]];
    [buttonLayer setBackgroundColor:[[UIColor colorWithRed:0.0/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5f] CGColor]];
}

@end
