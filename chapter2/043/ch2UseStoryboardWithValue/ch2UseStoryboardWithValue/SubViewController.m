//
//  SubViewController.m
//  ch2UseStoryboardWithValue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SubViewController

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
    self.titleLabel.text = self.receiveString;
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
