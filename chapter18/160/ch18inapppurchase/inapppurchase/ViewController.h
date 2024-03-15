//
//  ViewController.h
//  InAppPurchase
//
//  Created by katsuya on 2014/01/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface ViewController : UIViewController <SKProductsRequestDelegate>

@property (strong, nonatomic) NSArray *products;

- (IBAction)handleProductsRequestButton:(id)sender;
- (IBAction)handleBuyButton:(id)sender;

@end
