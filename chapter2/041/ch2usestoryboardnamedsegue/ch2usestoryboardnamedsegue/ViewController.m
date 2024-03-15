//
//  ViewController.m
//  ch2UseStoryboardNamedSegue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeScene;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButton1:(id)sender {
    if (self.changeScene.selectedSegmentIndex==0) {
        [self performSegueWithIdentifier:@"Segue1" sender:self];
    } else {
        [self performSegueWithIdentifier:@"Segue2" sender:self];
    }
}

@end
