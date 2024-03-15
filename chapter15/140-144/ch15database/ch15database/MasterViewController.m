//
//  MasterViewController.m
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
{
    NSMutableDictionary *editingDetail;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)reloadTable
{
    // データを取得する
    FMResultSet *results = [_database executeQuery:@"SELECT sid, name, distance, memo FROM stations ORDER BY distance;"];
    NSMutableArray *dic = [NSMutableArray new];
    while([results next]) {
        NSString *name = [results stringForColumnIndex: 1];
        NSString *memo = [results stringForColumnIndex: 3];
        [dic addObject:@{
                         @"sid" : [NSNumber numberWithInt:[results intForColumnIndex: 0]],
                         @"name" : name ? name : @"",
                         @"distance" : [NSNumber numberWithDouble:[results doubleForColumnIndex: 2]],
                         @"memo" : memo ? memo : @"",
                         }];
    }
    _stationsDictionary = dic;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    editingDetail = nil;
    [self reloadTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    // 新しい行を作成する
    NSInteger row = _stationsDictionary.count;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [_stationsDictionary addObject:@{
                                     @"sid" : [NSNull null],
                                     @"name" : @"",
                                     @"distance" : [NSNumber numberWithDouble:0],
                                     @"memo" : @"",
                                     @"_row" : [NSNumber numberWithInteger:indexPath.row],
                                     @"_edited" : [NSNumber numberWithBool:NO],
                                     }];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    // 作成した行を選択する
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    // 詳細画面を表示する
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_stationsDictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // データの削除
        NSDictionary *station = _stationsDictionary[indexPath.row];
        NSNumber *sid = station[@"sid"];
        [_database executeUpdate:@"DELETE FROM stations WHERE sid = ?;", sid];
        [_stationsDictionary removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[self reloadTable];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        // 画面遷移時に値を渡す
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *station = [NSMutableDictionary dictionaryWithDictionary:_stationsDictionary[indexPath.row]];
        station[@"_row"] = [NSNumber numberWithInteger:indexPath.row];
        station[@"_edited"] = [NSNumber numberWithBool:NO];
        [[segue destinationViewController] setDetailItem:station];
        editingDetail = station;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *station = _stationsDictionary[indexPath.row];

    cell.textLabel.text = station[@"name"];
    cell.detailTextLabel.text = [[station[@"distance"] stringValue] stringByAppendingString:@"km"];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (editingDetail && [editingDetail[@"_edited"] boolValue]) {
        if (editingDetail[@"sid"] != [NSNull null]) {
            // データを更新する
            [_database executeUpdate:@"UPDATE stations SET name = ?, distance = ?, memo = ? WHERE sid = ?;", editingDetail[@"name"], editingDetail[@"distance"], editingDetail[@"memo"], editingDetail[@"sid"]];
        } else {
            // データを新規追加する
            [_database executeUpdate:@"INSERT INTO stations(name, distance, memo) VALUES(?, ?, ?);", editingDetail[@"name"], editingDetail[@"distance"], editingDetail[@"memo"]];
        }
        // テーブルを再度読み込む
        [self reloadTable];
    } else {
        if (editingDetail[@"sid"] == [NSNull null]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[editingDetail[@"_row"] integerValue] inSection:0];
            // 使用しなかった新規追加行を削除
            [_stationsDictionary removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}
@end
