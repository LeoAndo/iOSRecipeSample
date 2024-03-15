//
//  ViewController.m
//  Facebook
//
//  Created by katsuya on 2014/01/30.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import<FacebookSDK/FacebookSDK.h>

@interface ViewController () <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ログインボタンを生成する
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.frame = CGRectOffset(loginview.frame, 5, 30);
    loginview.delegate = self;
    [self.view addSubview:loginview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button
- (IBAction)handlePostButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.shoeisha.co.jp"];
    
    // Facebookアプリを起動する
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:url
                                                          name:@"投稿テスト"
                                                       caption:@"caption"
                                                   description:@"description"
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"エラー %@", error.description);
                                                           } else {
                                                               NSLog(@"成功");
                                                           }
                                                       }];
    
    // FacebookアプリがインストールされていなければiOSのFacebookへの投稿ダイアログを表示する
    if (!appCall) {
        [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                 initialText:@"投稿テスト"
                                                       image:nil
                                                         url:url
                                                     handler:nil];
    }
}

#pragma mark - FBLoginViewDelegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.postButton.enabled = YES;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.postButton.enabled = NO;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSLog(@"エラー %@", error.description);
}

@end
