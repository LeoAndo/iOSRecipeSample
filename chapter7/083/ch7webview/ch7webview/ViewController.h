//
//  ViewController.h
//  ch7webview
//
//  Created by SHOEISHA on 2013/11/17.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButtonItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)actionButtonDidPush:(id)sender;

@end
