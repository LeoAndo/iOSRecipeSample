//
//  Sub2ViewController.m
//  ch2UseStoryboardNamedSegue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "Sub2ViewController.h"

@interface Sub2ViewController ()

@end

@implementation Sub2ViewController

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
