//
//  DetailViewController.m
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameField.text = _detailItem[@"name"];
        self.distanceField.text = [_detailItem[@"distance"] stringValue];
        self.memoField.text = _detailItem[@"memo"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (![self.nameField.text isEqualToString:_detailItem[@"name"]] ||
        ![self.distanceField.text isEqualToString:[_detailItem[@"distance"] stringValue]] ||
        ![self.memoField.text isEqualToString:_detailItem[@"memo"]]) {
        _detailItem[@"name"] = self.nameField.text;
        _detailItem[@"distance"] = [NSNumber numberWithDouble:[self.distanceField.text doubleValue]];
        _detailItem[@"memo"] = self.memoField.text;
        _detailItem[@"_edited"] = [NSNumber numberWithBool:YES];
    }
}
@end
