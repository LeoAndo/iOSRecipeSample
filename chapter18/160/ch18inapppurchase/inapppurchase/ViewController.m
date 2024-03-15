//
//  ViewController.m
//  InAppPurchase
//
//  Created by katsuya on 2014/01/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "MyPaymentTransactionObserver.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // 購入処理が完了した時の通知を受け取るように登録
    [notificationCenter addObserver:self
                           selector:@selector(paymentCompletedNotification:)
                               name:kPaymentCompletedNotification
                             object:nil];
    
    // 購入処理が失敗した時の通知を受け取るように登録
    [notificationCenter addObserver:self
                           selector:@selector(paymentErrorNotification:)
                               name:kPaymentErrorNotification
                             object:nil];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startProductRequest
{
    // iTunes Connectで登録したプロダクトのIDに書き換えて下さい
    NSSet *productIds = [NSSet setWithObjects:@"co.jp.se.chapter18.productid", nil];
    
    SKProductsRequest *productRequest;
    productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    productRequest.delegate = self;
    [productRequest start];
}

- (void)buy
{
    // 購入処理の開始前に、端末の設定がコンテンツを購入することができるようになっているか確認する
    if ([SKPaymentQueue canMakePayments] == NO) {
        NSString *message = @"機能制限でApp内での購入が不可になっています。";
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"エラー"
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 購入処理を開始する
    SKPayment *payment = [SKPayment paymentWithProduct:[self.products objectAtIndex:0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for (NSString *invalidProductIdentifier in response.invalidProductIdentifiers) {
        // invalidProductIdentifiersがあればログに出力する
        NSLog(@"%s invalidProductIdentifiers : %@", __PRETTY_FUNCTION__, invalidProductIdentifier);
    }
    
    // プロダクト情報を後から参照できるようにメンバ変数に保存しておく
    self.products = response.products;
    
    // 取得したプロダクト情報を順番にUItextVIewに表示する（今回は1つだけ）
    for (SKProduct *product in response.products) {
        NSString *text = [NSString stringWithFormat:@"Title %@\nDescription %@\nPrice %@\n",
                          product.localizedTitle,
                          product.localizedDescription,
                          product.price];
        self.textView.text = text;
    }
    
    // 購入ボタンを有効にする
    [self.buyButton setEnabled:YES];
}

#pragma mark - SKRequestDelegate
- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)paymentCompletedNotification:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // 実際はここで機能を有効にしたり、コンテンツを表示したいする
    SKPaymentTransaction *transaction = [notification object];
    NSString *message = [NSString stringWithFormat:@"%@ が購入されました", transaction.payment.productIdentifier];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"購入処理完了"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

- (void)paymentErrorNotification:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // ここでエラーを表示する
    SKPaymentTransaction *transaction = [notification object];
    NSString *message = [NSString stringWithFormat:@"エラーコード %ld", transaction.error.code];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"購入処理失敗"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
}

#pragma mark - handle method
- (IBAction)handleProductsRequestButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self startProductRequest];
}

- (IBAction)handleBuyButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self buy];
}
@end
