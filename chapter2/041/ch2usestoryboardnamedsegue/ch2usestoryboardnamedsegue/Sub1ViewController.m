//
//  Sub1ViewController.m
//  ch2UseStoryboardNamedSegue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "Sub1ViewController.h"

@interface Sub1ViewController ()

@end

@implementation Sub1ViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
