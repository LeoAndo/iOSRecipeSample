//
//  ViewController.m
//  ch14iCloudKeyValue
//
//  Created by HU QIAO on 2013/12/17.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@end

@implementation ViewController


static NSString *kStringKey = @"MyString";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // defaultStoreメソッドを使ってNSUbiquitousKeyValueStoreオブジェクトを取得
    NSUbiquitousKeyValueStore* cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    // iCloudとシンクさせる
    [cloudStore synchronize];
    
    // データを取得
    NSString *storedString = [cloudStore stringForKey:kStringKey];
    
    if (storedString != nil){
        _valueField.text = storedString;
    }
    
    // iCloudからデータの変更通知を受ける設定
    // 他の端末からiCloudのデータが変更されると
    // NSUbiquitousKeyValueStoreDidChangeExternallyNotificationという通知が送信されます。
    // また、アプリを削除して再インストール時にも通知が発行されて、iCloudからの自動同期が行われます。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(ubiquitousKeyValueStoreDidChange:)
                                                 name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:cloudStore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // 登録済みの通知要求を削除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



// 通知処理
-(void) ubiquitousKeyValueStoreDidChange: (NSNotification *)notification
{
    
    // 通知データ
    NSDictionary *notifyInfo = [notification userInfo];
    
    // 変更されたデータのキー値
    NSArray *keys = [notifyInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];

    //defaultStoreメソッドを使ってNSUbiquitousKeyValueStoreオブジェクトを取得
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    for (NSString *key in keys) {
        //変更が発生したデータを取得
        NSString *value = [cloudStore stringForKey:key];
        NSLog(@"value:%@", value);
    }
    
    //アラートを表示
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"通知"
                          message:@"iCloudのデータが変更されました。"
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil];
    [alert show];
    
    //UITextFieldを更新
    _valueField.text = [cloudStore stringForKey:kStringKey];
}

//iCloudへのデータ保存
- (IBAction)saveKeyValue:(id)sender {
    
    //defaultStore メソッドを使って NSUbiquitousKeyValueStore オブジェクトを取得
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    //NSUbiquitousKeyValueStore オブジェクトへデータを保存
    [cloudStore setString:_valueField.text forKey:kStringKey];
    
    //iCloudとシンクさせる
    [cloudStore synchronize];
}

@end
