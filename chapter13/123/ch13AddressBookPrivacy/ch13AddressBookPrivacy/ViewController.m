//
//  ViewController.m
//  ch13AddressBookPrivacy
//
//  Created by HU QIAO on 2013/11/25.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "ViewController.h"

@interface ViewController () <ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, assign) ABAddressBookRef addressBook;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // アドレスブックを生成
	_addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if(_addressBook) {
        //ABAddressBookUnregisterExternalChangeCallback(_addressBook, handleAddressBookChange, (__bridge void *)(self));
        CFRelease(_addressBook);
    }
}


//プライバシー→「連絡先」の状態ボタンを押下した時の処理
- (IBAction)checkAddressBookAccess:(id)sender {
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    //ユーザーにまだアクセスの許可を求めていない場合
    if(status == kABAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"ユーザーにまだアクセスの許可を求めていない"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //iPhoneの設定の「機能制限」でアドレス帳へのアクセスを制限している場合
    else if(status == kABAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"iPhoneの設定の「機能制限」でアドレス帳へのアクセスを制限している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //アドレス帳へのアクセスをユーザーから拒否されている場合
    else if(status == kABAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"アドレス帳へのアクセスをユーザーから拒否されている"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //アドレス帳へのアクセスをユーザーが許可している場合
    else if(status == kABAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"アドレス帳へのアクセスをユーザーが許可している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

//連絡先表示ボタンを押下した時の処理
- (IBAction)showAddressBook:(id)sender {
    switch (ABAddressBookGetAuthorizationStatus())
    {
            //アドレス帳へのアクセスをユーザーが許可している場合
        case  kABAuthorizationStatusAuthorized:
            [self showPeoplePickerController];
            break;
            
            //ユーザーにまだアクセスの許可を求めていない場合
        case  kABAuthorizationStatusNotDetermined :
        {
            //ユーザーに対して、アドレス帳にアクセスする許可を求めます。
            ViewController * __weak weakSelf = self;
            ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                                     {
                                                         if (granted)
                                                         {
                                                             // ユーザーがアドレス帳へのアクセスを許可した場合、grantedにtrueが入る。
                                                             //メインスレッドを止めないためにdispatch_asyncを使って処理をバックグラウンドで行う
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [weakSelf showPeoplePickerController];
                                                             });
                                                         } else {
                                                             // ユーザーが「許可しない」をタップした場合は、grantedにfalseが入る。
                                                             // アラートを表示する
                                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                                                                             message:@"アドレス帳へのアクセスをユーザーから拒否されていました。"
                                                                                                            delegate:nil
                                                                                                   cancelButtonTitle:@"OK"
                                                                                                   otherButtonTitles:nil];
                                                             [alert show];
                                                         }
                                                     });
        }
            break;
            
            //アドレス帳へのアクセスをユーザーから拒否されている場合
        case  kABAuthorizationStatusDenied:
            //iPhoneの設定の「機能制限」でアドレス帳へのアクセスを制限している場合
        case  kABAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                            message:@"アドレス帳へのアクセスを許可してください。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}


//アドレス帳を表示する
-(void)showPeoplePickerController
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// 電話番号、Email、誕生日を表示
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// pickerを表示
    [self presentViewController:picker animated:YES completion:nil];
}


//アドレス帳から個人を選択した時に呼び出される。
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    //返り値で YES を返すと個人の詳細表示画面を表示します。
	return YES;
}

// アドレス帳から個人の特定のプロパティを選択した時に呼び出される。
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //返り値で NO を返すと選択したプロパティにあったアクション（電話、メール送信など）を実行しない。
	return NO;
}

// Cancelされた時に呼び出される。
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}


@end
