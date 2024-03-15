//
//  ViewController.m
//  ch6PlayBgm
//
//  Created by shoeisha on 2013/10/13.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import "ViewController.h"

@interface ViewController () <AVAudioPlayerDelegate>
{
    // 再生位置
    IBOutlet UISlider* slider;

    // 再生時間
    IBOutlet UILabel* time;

    // 再生位置監視
    NSTimer* timer;
    
    // BGM
    AVAudioPlayer* player;
}
@end

@implementation ViewController

- (void)updateTimer:(NSTimer*)sender
{
    NSTimeInterval t = player.currentTime;

    int hour = (int)(t / 3600) %  60;
    int min  = (int)(t /   60) %  60;
    int sec  = (int)(t /    1) %  60;
    int cs   = (int)(t / 0.01) % 100;
    time.text = [NSString stringWithFormat:@"%02d:%02d:%02d.%02d", hour, min, sec, cs];
    
    slider.value = player.currentTime / player.duration;
}

- (IBAction)slide:(UISlider*)sender
{
    if (player.playing == NO) {
        player.currentTime = player.duration * sender.value;
    }
}

- (IBAction)play:(UIButton*)sender
{
    // 再生
    [player play];
    
    slider.enabled = NO;
}

- (IBAction)pause:(UIButton*)sender
{
    // 一時停止
    [player pause];
    
    slider.enabled = YES;
}

- (IBAction)stop:(UIButton*)sender
{
    // 停止
    [player stop];
    
    // 頭出し(先頭から0秒)
    player.currentTime = 0;
    [player prepareToPlay];

    slider.enabled = YES;
}

- (IBAction)panning:(UISlider*)sender
{
    if (fabsf(sender.value) < 0.05f) sender.value = 0.f;
    player.pan = sender.value;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 自動停止
    slider.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // ファイル指定
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"WindyCityShort" ofType:@"mp3"]];

    // インスタンス生成
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    player.delegate = self;
    
    // Optional Params
    {
        // 音量設定 0.0 - 1.0
        player.volume = 0.6;
        
        // ループ回数(-1 = 無限ループ)
        player.numberOfLoops = 0;
        
        // 再生速度(1.0 = 等倍)
        player.rate = 1.0;
        player.enableRate = YES;
    }
    
    // 再生準備
    [player prepareToPlay];
    
    // 再生位置監視
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(updateTimer:)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	// BGM停止
    [player stop];
    
    // 監視停止
    [timer invalidate];
}

@end
