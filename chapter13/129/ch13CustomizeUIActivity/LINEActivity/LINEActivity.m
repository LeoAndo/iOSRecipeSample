//
//  LINEActivity.m
//
//  Created by HU QIAO on 2013/12/07.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "LINEActivity.h"

//UIActivityのメソッドをオーバーライドする
@implementation LINEActivity

//種類を表す文字列
- (NSString *)activityType {
    return @"jp.naver.LINEActivity";
}

//アイコン
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"LINEActivityIcon.png"];
}

//タイトル
- (NSString *)activityTitle
{
    return @"LINE";
}

//実際にActivityを実行することができるかどうかを返すメソッド。
//このメソッドでNOを返した場合、メニューは表示されない。
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

//メニューを選択されたときに呼ばれるメソッド。ここで実際の共有処理を行う。
- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([self openLINEWithItem:activityItem])
            break;
    }
}

//渡されたactivityItemsを利用して、LINEアプリを起動。
- (BOOL)openLINEWithItem:(id)item
{
    //URLスキームを使用して、LINEがインストールされるかどうかを判断
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]) {
        //openURLでAppStoreを開く
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/line/id443904275?ls=1&mt=8"]];
        return NO;
    }
    
    //投稿処理（LINEを起動）
    NSString *LINEURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        LINEURLString = [NSString stringWithFormat:@"line://msg/text/%@", item];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        LINEURLString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    NSURL *LINEURL = [NSURL URLWithString:LINEURLString];
    [[UIApplication sharedApplication] openURL:LINEURL];
    return YES;
}

@end
