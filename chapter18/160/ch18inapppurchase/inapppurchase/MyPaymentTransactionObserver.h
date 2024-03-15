//
//  MyPaymentTransactionObserver.h
//  Chapter03
//
//
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

// 購入完了のノーティフィケーション
#define kPaymentCompletedNotification  @"PaymentCompletedNotification"

// 購入失敗のノーティフィケーション
#define kPaymentErrorNotification @"PaymentErrorNotification"

@interface MyPaymentTransactionObserver : NSObject <SKPaymentTransactionObserver>
+ (id)sharedObserver;
@end
