//
//  ViewController.m
//  ch11AVAudioSession
//
//  Created by shoeisha on 2013/12/30.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"

@interface ViewController () /* <AVAudioSessionDelegate> iOS6以降Deprecated */
{
    // BGM
    AVAudioPlayer* player;
}
@end

@implementation ViewController

- (IBAction)beginInterruption
{
    NSLog(@"beginInterruption");
    [player pause];
}

- (IBAction)endInterruption
{
    NSLog(@"endInterruption");
    
    // 3秒後に鳴らす
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        [player play];
        NSLog(@"play!");
    });
}

- (void)sessionDidInterrupt:(NSNotification*)notification
{
    // 割り込み情報
    NSNumber* interruptionType   = [[notification userInfo] objectForKey:AVAudioSessionInterruptionTypeKey];
    NSNumber* interruptionOption = [[notification userInfo] objectForKey:AVAudioSessionInterruptionOptionKey];
    
    switch (interruptionType.unsignedIntegerValue) {
        // 着信音などの割り込み発生
        case AVAudioSessionInterruptionTypeBegan:
            NSLog(@"AVAudioSessionInterruptionTypeBegan");
            [self beginInterruption];
            break;

        // 着信音などの割り込み終了
        case AVAudioSessionInterruptionTypeEnded:
            NSLog(@"AVAudioSessionInterruptionTypeEnded");
            switch (interruptionOption.unsignedIntegerValue) {
                case AVAudioSessionInterruptionOptionShouldResume:
                    NSLog(@"AVAudioSessionInterruptionOptionShouldResume");
                    [self endInterruption];
                    break;
                default:
                    break;
            }
            break;

        default:
            NSLog(@"Interruption other");
            break;
    }
}

- (void)sessionMediaServicesWereLost
{
    NSLog(@"sessionMediaServicesWereLost");
}

// RemoteControlDelegate
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSLog(@"receive remote control events");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // オーディオセッション設定
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setMode:AVAudioSessionModeDefault error:nil];
    [session setActive:YES error:nil];
    
    // リモートコントロールイベント開始
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // 通知センター登録
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(sessionDidInterrupt:)
                   name:AVAudioSessionInterruptionNotification
                 object:session];
    /*
    [center addObserver:self
               selector:@selector(sessionMediaServicesWereLost)
                   name:AVAudioSessionMediaServicesWereLostNotification
                 object:session];
    [center addObserver:self selector:@selector(sessionRouteDidChange) name:AVAudioSessionRouteChangeNotification object:nil];
     */
    
    // ファイルを指定してBGMを鳴らす
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"WindyCityShort" ofType:@"mp3"]];
    
    // インスタンス生成
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    // 音量設定 0.0 - 1.0
    player.volume = 0.4;
    
    // ループ回数(-1 = 無限ループ)
    player.numberOfLoops = -1;
    
    // 再生
    [player play];
   
    
    // 曲情報表示
    MPNowPlayingInfoCenter* infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    infoCenter.nowPlayingInfo = @{
                                  MPMediaItemPropertyArtist:@"アーティスト名",
                                  MPMediaItemPropertyTitle:@"タイトル名",
                                  MPMediaItemPropertyAlbumTitle:@"アルバム名",
                                  };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 通知センター解除
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    //[center removeObserver:self name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
    
    // リモートコントロールイベント解除
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

@end
