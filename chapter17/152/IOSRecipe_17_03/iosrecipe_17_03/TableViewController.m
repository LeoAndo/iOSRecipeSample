//
//  TableViewController.m
//  iOSRecipe_17_03
//
//  Created by shimy on 1/8/14.
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "TableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface TableViewController ()

@end

@implementation TableViewController
{
    CFArrayRef people;
}

struct Structure {
    int count;
};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CFArrayGetCount(people);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // 名前の表示
    ABRecordRef person = CFArrayGetValueAtIndex(people, indexPath.row);
    CFStringRef name = ABRecordCopyCompositeName(person); // releaseされていない
    cell.textLabel.text = (__bridge NSString *)name;
    
    // 数字の表示
    int mod; // 初期化されていない
    BOOL flg = YES; // 参照されていない
    switch (indexPath.row % 3)
    {
        case 0:
            mod = 1;
            flg = NO;
            break;
        case 1:
            mod = 2;
            struct Structure structure;
            structure.count = mod;
            [self convert: &structure ];
            break;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",mod ];

    return cell;
}

- (int)convert:(struct Structure*)structure
{
    // NULLの場合が考慮されていない
    if (structure == NULL)
    {
    }
    return structure->count;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
