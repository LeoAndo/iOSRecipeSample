//
//  MainViewController.m
//  iOSRecipe_17_05
//
//  Created by shimy on 1/13/14.
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cache = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ボタンの設置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(20, 100, 280, 50)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(abandonedMemoryClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

- (void)abandonedMemoryClick
{
    // 1MBのデータを作成
    NSMutableData *data = [[NSMutableData alloc] initWithLength:1*1024*1024];
    [self.cache addObject:data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
