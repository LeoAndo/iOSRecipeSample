//
//  MainViewController.m
//  iOSRecipe_17_06
//
//  Created by shimy on 1/13/14.
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "MainViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MainViewController ()

@end

@implementation MainViewController
{
    CFArrayRef people;
}

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

    // 連絡先の取得
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFRelease(addressBook);
    
    // ボタンの設置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(20, 100, 280, 50)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(zombieClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}


- (void) zombieClick
{
    ABRecordRef person = CFArrayGetValueAtIndex(people, 0);
    CFStringRef name = ABRecordCopyCompositeName(person);
    CFRelease(name);
    NSLog(@"%@",name);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
