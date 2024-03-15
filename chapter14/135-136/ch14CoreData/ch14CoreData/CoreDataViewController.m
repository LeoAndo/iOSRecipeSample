//
//  CoreDataViewController.m
//  ch14CoreData
//
//  Created by HU QIAO on 2014/01/27.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "CoreDataViewController.h"

@interface CoreDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation CoreDataViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//データの作成
- (IBAction)Save:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // contextはNSManagedObjectContextのインスタンス
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSEntityDescriptionのinsertNewObjectForEntityForName:を利用して、NSManagedObjectのインスタンスを取得
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"
                                               inManagedObjectContext:context];
    
    // NSManagedObjectに各属性値を設定
    [newContact setValue: _name.text forKey:@"name"];
    [newContact setValue: _address.text forKey:@"address"];
    NSError *error;
    
    // managedObjectContextオブジェクトのsaveメソッドでデータを保存
    [context save:&error];
    
    _name.text = @"";
    _address.text = @"";
    _message.text = @"データを保存しました。";
    
}

//データの検索
- (IBAction)Search:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // contextはNSManagedObjectContextクラスのインスタンス
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSFetchRequestは検索条件などを保持するオブジェクト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    // 検索対象のエンティティを指定
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts"
                                                  inManagedObjectContext:context];
    [request setEntity:entityDesc];
    
    // 検索条件を指定
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",  _name.text];
    [request setPredicate:pred];
    
    // 検索を実行
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    // 検索結果を表示
    NSManagedObject *matches = nil;
    if ([objects count] == 0) {
        _message.text = @"検索結果がありませんでした。";
    } else {
        matches = objects[0];
        _address.text = [matches valueForKey:@"address"];
        _message.text = [NSString stringWithFormat:
                         @"%lu件のデータがありました。", (unsigned long)[objects count]];
    }
    
}

//データの削除
- (IBAction)delete:(id)sender {

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // contextはNSManagedObjectContextクラスのインスタンス
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // NSFetchRequestは検索条件などを保持するオブジェクト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 検索対象のエンティティを指定
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts"
                                                  inManagedObjectContext:context];
    [request setEntity:entityDesc];
    
    // 検索条件を指定
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",  _name.text];
    [request setPredicate:pred];
    
    // 検索を実行
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    
    if ([objects count] == 0) {
        _message.text = @"検索結果がありませんでした。";
    } else {
        // 削除メソッドを呼び出しす
        for (NSManagedObject *object in objects) {
            [context deleteObject:object];
        }
        // saveメソッドで更新状態を確定
        if (![context save:&error]) {
            _message.text = @"データ削除に失敗しました。";
        } else {
            _message.text = [NSString stringWithFormat:
                             @"%lu件のデータを削除しました。", (unsigned long)[objects count]];
        }
    }
    
}


@end
