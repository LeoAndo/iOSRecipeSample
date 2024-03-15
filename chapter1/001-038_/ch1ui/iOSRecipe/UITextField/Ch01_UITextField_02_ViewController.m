//
//  Ch01_UITextField_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/05.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITextField_02_ViewController.h"

@interface Ch01_UITextField_02_ViewController ()

@end

@implementation Ch01_UITextField_02_ViewController

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
    self.textfield1.placeholder=@"ユーザーID";
    
    NSString *str = @"ユーザーID";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"ID"];
    //赤色にセットする
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[[UIColor redColor] colorWithAlphaComponent:1.]
                    range:range1];
    
    self.textfield2.attributedPlaceholder=attrStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
