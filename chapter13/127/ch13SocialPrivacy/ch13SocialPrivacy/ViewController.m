//
//  ViewController.m
//  ch13SocialPrivacy
//
//  Created by HU QIAO on 2014/01/16.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *dataSource;

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

//Twitter
- (IBAction)TwitterAccess:(id)sender {
    
    
    //ACAccountStoreオブジェクトを生成
    ACAccountStore *account = [[ACAccountStore alloc] init];
    
    //ACAccountTypeの取得
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //端末のTwitterアカウントのアクセス権を求まる
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error)
     {
         
         if (granted) {
             // ユーザーがアクセスを許可した場合
             //端末に登録されたTwtitterアカウント（ACAccount）配列を取得
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 
                 //Twitter APIを利用して、Twitterへのアクセスを行う
                 NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:@"My First Twitter post from iOS", @"status",nil];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
                 
                 //SLRequestを使用
                 SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                             requestMethod:SLRequestMethodPOST
                                                                       URL:requestURL
                                                                parameters:message];
                 //アカウントを指定
                 postRequest.account = twitterAccount;
                 
                 //リクエストを発行
                 [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      NSLog(@"Response, %@",[urlResponse description]);
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [[[UIAlertView alloc] initWithTitle:@"確認"
                                                      message:[NSString stringWithFormat:@"Twitter HTTP response: %ld",(long)[urlResponse statusCode]]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil]
                           show];
                          
                          
                      });
                      
                  }];
             }
         } else {
             // ユーザーがアクセスを拒否した場合
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[[UIAlertView alloc] initWithTitle:@"確認"
                                             message:@"このアプリのTwitterアカウントへのアクセスを許可するには、プライバシーから設定する必要があります。"
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil]
                  show];
             });
         }
         
     }];
}

//Facebook
- (IBAction)FacebookAccess:(id)sender {
    
    //ACAccountStoreオブジェクトを生成
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    //ACAccountTypeの取得
    ACAccountType *accountTypeFacebook =   [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{ACFacebookAppIdKey: @"<YOUR FACEBOOK APP ID KEY HERE>",
                                  ACFacebookPermissionsKey: @[@"publish_stream",@"publish_actions"],
                                  ACFacebookAudienceKey: ACFacebookAudienceFriends
                                  };
    
    //端末のFacebookアカウントのアクセス権を求まる
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook
                                          options:options
                                       completion:^(BOOL granted, NSError *error)
     {
         if(granted) {
             // ユーザーがアクセスを許可した場合
             
             //端末に登録されたFacebookアカウント（ACAccount）配列を取得
             NSArray *accounts = [accountStore accountsWithAccountType:accountTypeFacebook];
             
             //アカウントを指定
             ACAccount *facebookAccount = [accounts lastObject];
             
             NSDictionary *parameters = @{@"access_token":facebookAccount.credential.oauthToken,
                                          @"message": @"My first iOS Facebook posting"};
             
             //Facebook APIを利用して、Facebookへのアクセスを行う
             NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
             
             //SLRequestを使用
             SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                         requestMethod:SLRequestMethodPOST
                                                                   URL:requestURL
                                                            parameters:parameters];
                          

             //リクエストを発行
             [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
              {
                  NSLog(@"Response, %@",[urlResponse description]);
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [[[UIAlertView alloc] initWithTitle:@"確認"
                                                  message:[NSString stringWithFormat:@"Facebook HTTP response: %ld",(long)[urlResponse statusCode]]
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil]
                       show];
                  });
              }];
         } else {
             // ユーザーがアクセスを拒否した場合
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[[UIAlertView alloc] initWithTitle:@"確認"
                                             message:@"このアプリのFacebookアカウントへのアクセスを許可するには、プライバシーから設定する必要があります。"
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil]
                  show];
             });
         }
     }];
}


@end
