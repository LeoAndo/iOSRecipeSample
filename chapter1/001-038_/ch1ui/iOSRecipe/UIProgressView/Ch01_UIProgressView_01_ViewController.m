//
//  Ch01_004_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/24.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UIProgressView_01_ViewController.h"

@interface Ch01_UIProgressView_01_ViewController ()

@end

@implementation Ch01_UIProgressView_01_ViewController

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
    
    //Style:Default progerss:0.8
    self.progressview1.progressViewStyle = UIProgressViewStyleDefault;
    self.progressview1.progress = 0.8f;
    
    //Style:Bar progerss:0.2
    self.progressview2.progressViewStyle = UIProgressViewStyleBar;
    self.progressview2.progress = 0.2f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateProgress:(id)sender {
    self.progressview3.progress = 0.0f;
    for(int i =0;i<10;i++) {
		[self performSelectorInBackground:@selector(addProgress:) withObject:[NSNumber numberWithFloat:0.1f]];
		[NSThread sleepForTimeInterval:0.1f];
	}
}

- (void)addProgress:(NSNumber*) count{
    self.progressview3.progress+=[count floatValue];
}



@end
