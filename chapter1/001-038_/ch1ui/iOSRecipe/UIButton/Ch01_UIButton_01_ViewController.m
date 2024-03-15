//
//  Ch01_UIButton_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/04.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIButton_01_ViewController.h"

@interface Ch01_UIButton_01_ViewController ()

@end

@implementation Ch01_UIButton_01_ViewController

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
    UIImage *img = [UIImage imageNamed:@"green.png"];
    UIImage *img2 = [UIImage imageNamed:@"pink.png"];
    
    UIImage *img3 = [UIImage imageNamed:@"red.png"];
    
    UIImage *img4 = [UIImage imageNamed:@"gray.png"];
    
    
    [self.button1 setImage:img forState:UIControlStateNormal];
    
    [self.button2 setImage:img2 forState:UIControlStateHighlighted];
    [self.button3 setImage:img3 forState:UIControlStateSelected];
    [self.button4 setImage:img4 forState:UIControlStateDisabled];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
