//
//  Ch01_002_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/15.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UILabel_02_ViewController.h"

@interface Ch01_UILabel_02_ViewController ()

@end

@implementation Ch01_UILabel_02_ViewController

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
    [self.label1 setText:@"一生懸命IOSを勉強する"];
    [self.label2 setText:@"一生懸命IOSを勉強する"];
    [self.label3 setText:@"一生懸命IOSを勉強する"];
    
    //先頭を...で省略
    self.label1.lineBreakMode = NSLineBreakByTruncatingHead;
    //末尾を...で省略
    self.label2.lineBreakMode = NSLineBreakByTruncatingTail;
    //真ん中を...で省略
    self.label3.lineBreakMode = NSLineBreakByTruncatingMiddle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
