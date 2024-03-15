//
//  Ch01_UITableView_04_TableViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/06.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITableView_04_TableViewController.h"

@interface Ch01_UITableView_04_TableViewController ()

@end

@implementation Ch01_UITableView_04_TableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //storyboardで指定したIdentifierを指定する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UILabel *uiLabel;
    UISwitch *uiSwitch;
    
    uiLabel = (UILabel *)[cell viewWithTag:1];
    uiLabel.text = [NSString stringWithFormat:@"セクション：%d　行：%d", indexPath.section, indexPath.row];
    
    uiSwitch = (UISwitch *)[cell viewWithTag:2];
    [uiSwitch setOn:true];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //セクション数を返す
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //セクション中の行数を返す。ここですべてのセクションに同じの行数3を設定している
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //各セクションのヘッダーを指定する
    return [NSString stringWithFormat : @"%@%d", @"セクション",section];
}


@end
