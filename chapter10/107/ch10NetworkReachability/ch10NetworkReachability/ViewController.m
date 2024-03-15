//
//  ViewController.m
//  ch10NetworkReachability
//
//  Created by shoeisha on 2013/12/08.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

#import "Reachability.h"
// Download sample code from iOS Developer Library
// https://developer.apple.com/library/ios/samplecode/reachability/Introduction/Intro.html

@interface ViewController ()
{
    IBOutlet UILabel* label;
}
@end

@implementation ViewController

- (IBAction)check:(id)sender
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable) {
        label.text = @"NotReachable";
    } else {
        label.text = @"Reachable";
    }
}

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

@end
