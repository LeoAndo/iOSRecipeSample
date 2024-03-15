//
//  MainViewController.m
//  iOSRecipe_17_04
//
//  Created by shimy on 1/12/14.
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "MainViewController.h"
#import "Leak.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    // 1.循環参照
    Leak *leak1 = [[Leak alloc] init];
    leak1.leak = leak1;

    // 2.CFRetain
    Leak *leak2 = [[Leak alloc] init];
    CFRetain((__bridge CFTypeRef)leak2);

    // 3.Bridge Retain
    Leak *leak3 = [[Leak alloc] init];
    void *obj = (__bridge_retained void *)leak3;

    // 4.MemSet
    Leak *leak4 = [[Leak alloc] init];
    memset(&leak4, 0, sizeof(id));
    
    // 5.MsgSend
    Leak *leak5 = [[Leak alloc] init];
    objc_msgSend(leak5, NSSelectorFromString(@"retain"));
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
