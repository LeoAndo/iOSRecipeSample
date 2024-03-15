//
//  Ch01_UISlider_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/26.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UISlider_02_ViewController.h"

@interface Ch01_UISlider_02_ViewController ()

@end

@implementation Ch01_UISlider_02_ViewController

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

    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"green.png"]
                                stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
    
    UIImage *stetchRightTrack = [[UIImage imageNamed:@"red.png"]
                                stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];

    CGFloat width = 100;  // リサイズ後幅のサイズ
    CGFloat height = 10;  // リサイズ後高さのサイズ
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [stetchLeftTrack drawInRect:CGRectMake(0, 0, width, height)];
    stetchLeftTrack = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [stetchRightTrack drawInRect:CGRectMake(0, 0, width, height)];
    stetchRightTrack= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *thumbImage = [[UIImage imageNamed:@"ball.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
    
    [self.slider1 setThumbImage: thumbImage forState:UIControlStateNormal];
    
    [self.slider1 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [self.slider1 setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    self.slider1.minimumValue = 0.0;
    self.slider1.maximumValue = 100.0;
    self.slider1.continuous = YES;
    self.slider1.value = 50.0;
}

-(void)viewDidAppear:(BOOL)bl{
    [super viewDidAppear:bl];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
