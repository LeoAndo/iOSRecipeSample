//
//  Ch01_UITableView_02_TableViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/02/17.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITableView_02_TableViewController.h"

@interface Ch01_UITableView_02_TableViewController ()
{
    //行データを格納する
    NSMutableArray *rowDataArray;
    //追加された行数
    int insertRow;
}
@end

@implementation Ch01_UITableView_02_TableViewController

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"行追加/削除/移動";
    rowDataArray = [[NSMutableArray alloc]init];
    for(int i=1;i<4;i++) {
        [rowDataArray addObject:[NSString stringWithFormat:@"元の行：%d",i]];
    }
    insertRow = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //サンプルとして、１セクションを設定している
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //一つのセクション中の行数を返す。
    return [rowDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //storyboardで指定したIdentifierを指定する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    UILabel *uiLabel;
    
    uiLabel = (UILabel *)[cell viewWithTag:1];
    uiLabel.text = [rowDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if (editing) {
        // 現在編集モード
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                        target:self action:@selector(insertRow:)];
        // 追加ボタンを表示します。
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    } else {
        // 現在通常モード。 追加ボタンを非表示にする
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
}

//追加処理
- (IBAction)insertRow:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowDataArray.count inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath,nil];
    [rowDataArray addObject:[NSString stringWithFormat:@"追加された行：%d",insertRow]];
    // 次に使うとき用にaddCountに1足しています。
    insertRow++;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}


//移動処理
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
   
    if(fromIndexPath.section == toIndexPath.section) {
        // 移動元と移動先は同じセクションです。
        if(rowDataArray && toIndexPath.row < [rowDataArray count]) {
             // 移動対象を保持します。
            id item = [rowDataArray objectAtIndex:fromIndexPath.row ];
            // 配列から一度消します。
            [rowDataArray removeObject:item];
            // 保持しておいた対象を挿入します。
            [rowDataArray insertObject:item atIndex:toIndexPath.row];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    //すべてのデータが移動できるようにしている
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 削除ボタンが押された行のデータを配列から削除します。
        [rowDataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

@end
