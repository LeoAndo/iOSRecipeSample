//
//  ViewController.m
//  ch6PlaySe
//
//  Created by shoeisha on 2013/10/10.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray* SoundID;
}
@end

@implementation ViewController

-(IBAction)play:(UIButton*)sender
{
    // 効果音を再生する
    AudioServicesPlaySystemSound((SystemSoundID)[[SoundID objectAtIndex:sender.tag] unsignedIntValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.

    // 再生リソース
    NSArray* kinds = [NSArray arrayWithObjects:@"mute",         // 外部音声ファイル（無音）
                      [NSNumber numberWithUnsignedInt:1000],    // システムSE : 1000-, kSystemSoundID_Vibrate
                      @"hihat",                                 // 外部音声ファイル
                      nil];
    
    // 要素数分のメモリ確保
    SoundID = [NSMutableArray arrayWithCapacity:kinds.count];

    // 再生リソース登録
    for (int i = 0; i < kinds.count; i++) {
        SystemSoundID sid;

        // リストの要素が NSNumber ならシステムSE番号、それ以外は外部ファイル名（*.caf）として扱う
        id kind = [kinds objectAtIndex:i];
        if ([kind isKindOfClass:[NSNumber class]]) {
            sid = (SystemSoundID)[kind unsignedIntValue];
        } else {
            NSURL* path = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:kind ofType:@"caf"]];
            // 効果音を登録する
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)path, &sid);
        }
        
        [SoundID addObject:[NSNumber numberWithUnsignedInt:sid]];
    }

    // 無音を予め再生しておくことで、初回再生時のラグを解消する
    AudioServicesPlaySystemSound((SystemSoundID)[[SoundID objectAtIndex:0] unsignedIntegerValue]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 再生リソース破棄
    for (NSNumber* n in SoundID) {
        SystemSoundID sid = [n unsignedIntValue];
        // システムSEより大きければ破棄
        if (sid > kSystemSoundID_Vibrate) AudioServicesDisposeSystemSoundID(sid);
    }
}

@end
