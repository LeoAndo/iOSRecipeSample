//
//  ViewController.m
//  ch13PhotoPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkPhotosAuthorizationStatus:(id)sender {
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    // ユーザーにまだアクセスの許可を求めていない場合
    if(status == ALAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"ユーザーにまだアクセスの許可を求めていない"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // iPhoneの設定の「機能制限」で写真へのアクセスを制限している場合
    else if(status == ALAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"iPhoneの設定の「機能制限」で写真へのアクセスを制限している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 写真へのアクセスをユーザーから拒否されている場合
    else if(status == ALAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"写真へのアクセスをユーザーから拒否されている"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 写真へのアクセスをユーザーが許可している場合
    else if(status == ALAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                        message:@"写真へのアクセスをユーザーが許可している"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)showAlbum:(id)sender {
    
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
            // iPhoneの設定の「機能制限」で写真へのアクセスを制限している場合
        case ALAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"iPhoneの設定の「機能制限」で写真へのアクセスを制限している"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
            
            // 写真へのアクセスをユーザーから拒否されている場合
        case ALAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"写真へのアクセスをユーザーから拒否されている"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
            // ユーザーにまだアクセスの許可を求めていない場合
        case ALAuthorizationStatusNotDetermined:
            // 写真へのアクセスをユーザーが許可している場合
        case ALAuthorizationStatusAuthorized:
        {
            [self showImagePickerController];
        }
            break;
        default:
            break;
    }
    
}


//アルバムを表示する
-(void)showImagePickerController
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
    
	// ユーザーにまだアクセスの許可を求めていない場合
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop) {
                // ユーザーがアクセスを許可した場合
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                                message:@"写真へのアクセスをユーザーから許可されている"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
                return;
            }
            *stop = TRUE;
        } failureBlock:^(NSError *error) {
            // ユーザーがアクセス拒否した場合
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー状態"
                                                            message:@"写真へのアクセスをユーザーから拒否されている"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }];
    }
}


#pragma mark - UIImagePicker delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissPicker:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissPicker:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [self dismissPicker:picker];
}

- (void)dismissPicker:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
