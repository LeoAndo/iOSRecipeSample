//
//  Ch01_001_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/11.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_01_ViewController.h"

@interface Ch01_UILabel_01_ViewController ()

@end

@implementation Ch01_UILabel_01_ViewController

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
    
    [self initFontLabel];
    [self initForeColorLabel];
    [self initBgColorLabel];
    [self initShadowLabel];
    [self initStrikethroughLabel];
    [self initUnderlineLabel];
    [self initLetterSpaceLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//フォントをセットする
-(void)initFontLabel {
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"ラベル"];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"Futura-CondensedMedium" size:25.]
                    range:range1];
    [self.label1 setAttributedText:attrStr];
}

//文字の色をセットする
-(void)initForeColorLabel {
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"ラベル"];
    //赤色にセットする
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor redColor] colorWithAlphaComponent:1.]
                    range:range1];
    [self.label2 setAttributedText:attrStr];
}

//文字の背景色をセットする
-(void)initBgColorLabel{
    //▲NSMutableAttributedStringオブジェクト生成
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"ラベル"];
    //黄色にセットする
    [attrStr addAttribute:NSBackgroundColorAttributeName
                    value:[[UIColor yellowColor] colorWithAlphaComponent:1.]
                    range:range1];
    
    [self.label3 setAttributedText:attrStr];
}


//文字の影をセットする
-(void)initShadowLabel {
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];

    NSShadow *shadow = [[NSShadow alloc] init];
    //影の色
    [shadow setShadowColor:[UIColor redColor]];
    //ぼかしの半径
    [shadow setShadowBlurRadius:4.0];
    //影のサイズ
    [shadow setShadowOffset:CGSizeMake(2, 2)];
    [attrStr addAttribute:NSShadowAttributeName
                    value:shadow
                    range:NSMakeRange(0,[attrStr length])];
    [self.label4 setAttributedText:attrStr];
}
//打ち消し線をセットする
-(void)initStrikethroughLabel{
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"IOS"];
    //赤色の標準打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]} range:range1];
    
    NSRange range2 = [str rangeOfString:@"ラベル"];
    //緑色の太線の打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor greenColor]} range:range2];
    
    NSRange range3 = [str rangeOfString:@"サンプル"];
    //青色の二重線の打ち消し線
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor blueColor]} range:range3];
    
    [self.label5 setAttributedText:attrStr];
}

//下線をセットする
-(void)initUnderlineLabel {
    NSString *str = @"IOS ラベル　サンプル";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = [str rangeOfString:@"IOS"];
    //赤色のシングル下線
    [attrStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:[UIColor redColor]} range:range1];
    
    NSRange range2 = [str rangeOfString:@"ラベル"];
    //緑色の太線の下線
    [attrStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),NSUnderlineColorAttributeName:[UIColor greenColor]} range:range2];

    [self.label6 setAttributedText:attrStr];
}
//文字間隔をセットする
-(void)initLetterSpaceLabel{
    NSString *str = @"IOS ラベル　サンプル";
    
    CGFloat customLetterSpacing = 10.0f;
    
    // NSAttributedStringを生成してLetterSpacingをセット
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:customLetterSpacing]
                           range:NSMakeRange(0, attrStr.length)];
    [self.label7 setAttributedText:attrStr];
}

@end
