//
//  Ch01_UITableView_03_TableViewControlle.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/06.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITableView_03_TableViewControlle.h"

@interface Ch01_UITableView_03_TableViewControlle()
{
    
}

@end

@implementation Ch01_UITableView_03_TableViewControlle

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
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [tableHeaderView setBackgroundColor:[UIColor greenColor]];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [tableFooterView setBackgroundColor:[UIColor greenColor]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 320, 25)];
    headerLabel.text = @"Table Header View";
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 25)];
    footerLabel.text=@"Table Footer View";
    [tableHeaderView addSubview:headerLabel];
    [tableFooterView addSubview:footerLabel];
    
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableFooterView = tableFooterView;
    
    //再利用するため、UITableViewHeaderFooterViewを登録する
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HeaderFooter"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //storyboardで指定したIdentifierを指定する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UILabel *uiLabel;
    
    uiLabel = (UILabel *)[cell viewWithTag:1];
    uiLabel.text = [NSString stringWithFormat:@"セクション：%d　行：%d", indexPath.section, indexPath.row];
  
    return cell;
}
//セクションのヘッダーに表示するViewを定義する
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderFooter"];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,50)];
    label.text = [NSString stringWithFormat : @"%@%d", @"Section Header",section];
    label.backgroundColor = [UIColor blueColor];
    label.textColor = UIColor.whiteColor;
    
    UISwitch *uiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 20, 50)];
    
    [header.contentView addSubview:label];
    [header.contentView addSubview:uiswitch];
    return header;
}

//セクションのフッターに表示するViewを定義する
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderFooter"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,50)];
    label.text = [NSString stringWithFormat : @"%@%d", @"Section Footer",section];
    label.backgroundColor = [UIColor redColor];
    label.textColor = UIColor.whiteColor;
    
    UISwitch *uiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 20, 50)];
    
    [footer.contentView addSubview:label];
    [footer.contentView addSubview:uiswitch];
    return footer;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //セクション数を返す
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //セクション中の行数を返す。ここですべてのセクションに同じの行数3を設定している
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
@end
