//
//  ViewController.m
//  ch13SendMailWithAttachment
//
//  Created by HU QIAO on 2013/11/19.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "ViewController.h"

@interface ViewController ()
< MFMailComposeViewControllerDelegate,
  UINavigationControllerDelegate
>

//送信結果メッセージを表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *feedbackMsg;

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

// メール作成ボタンを押下した時の処理
- (IBAction)sendMailPicker:(id)sender {
    
    // MFMailComposeViewControllerを利用する前にcanSendMail関数を利用して、
    // メールアカウントが設定されているか・メール送信可能かを確認する必要があります。
    
    if ([MFMailComposeViewController canSendMail])
    {
       // 結果がYESだった場合は、メール作成・送信画面の表示処理を行う
       [self displayMailComposer];
    }
    else
    {
        // 結果がNOだった場合は、メールアカウントの設定が必要であることをユーザに通知する
        self.feedbackMsg.hidden = NO;
		self.feedbackMsg.text = @"メールアカウントの設定を行ってください。";
    }

}

// メール作成・送信画面の表示処理を行う
- (void)displayMailComposer
{
    //MFMailComposeViewControllerインスタンスを生成し、宛先や本文などを設定する
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
    // メールタイトルを設定する
	[picker setSubject:@"添付ファイルの送信"];
	
	// 複数の宛先を設定する
	NSArray *toRecipients = [NSArray arrayWithObjects:@"1stRecipient@foo.com", @"2ndRecipient@foo.com", nil];
	[picker setToRecipients:toRecipients];
    
    // CCを設定する
    NSArray *ccRecipients = [NSArray arrayWithObject:@"ccRecipient@foo.com"];
    [picker setCcRecipients:ccRecipients];
	
    // BCCを設定する
	NSArray *bccRecipients = [NSArray arrayWithObject:@"bccRecipient@foo.com"];
    [picker setBccRecipients:bccRecipients];
	
	// メール本文を設定する
	NSString *emailBody = @"CSVファイルを添付しています。";
    
    // body引数でメール本文を指定します。isHTMLがNOの場合はテキストメールとなります。
	[picker setMessageBody:emailBody isHTML:NO];
    
    // NSStringをNSdataに変換
    NSString *csv = @"foo,bar,blah,hello";
    NSData *csvData = [csv dataUsingEncoding:NSUTF8StringEncoding];
    
    // mimeTypeはtext/csv
    [picker addAttachmentData:csvData mimeType:@"text/csv" fileName:@"export.csv"];
    

    // 親ビューコントローラのpresentViewController関数を利用して、モーダルでメール作成・送信画面を表示する
	[self presentViewController:picker animated:YES completion:NULL];
}

//　ユーザーが送信またはキャンセルを選択すると、MFMailComposeViewControllerDelegateの
//　mailComposeController:didFinishWithResult:error:メソッドが呼ばれます
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
	self.feedbackMsg.hidden = NO;
    
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.feedbackMsg.text = @"メールを破棄しました。";
			break;
		case MFMailComposeResultSaved:
			self.feedbackMsg.text = @"メールを保存しました。";
			break;
		case MFMailComposeResultSent:
			self.feedbackMsg.text = @"メールを送信しました。";
			break;
		case MFMailComposeResultFailed:
			self.feedbackMsg.text = @"メール送信に失敗した";
			break;
		default:
			break;
	}
    // モーダルのメール編集・送信画面を閉じる
	[self dismissViewControllerAnimated:YES completion:NULL];
}


@end
