//
//  ViewController.m
//  ch6PlayVideo
//
//  Created by shoeisha on 2013/10/10.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"

@interface ViewController ()
{
    MPMoviePlayerController* player;
    IBOutlet UIView* subview;
}
@end

@implementation ViewController

- (IBAction)play:(id)sender
{
    // 再生
    [player play];

    NSLog(@"%f / %f", player.playableDuration, player.duration);
}

- (IBAction)pause:(id)sender
{
    // 一時停止
    [player pause];
}

- (IBAction)stop:(id)sender
{
    // 停止
    [player stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // メディア指定
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_iPod" ofType:@"m4v"]];

    // インスタンス生成
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // 再生設定項目
    player.movieSourceType          = MPMovieSourceTypeFile;
    player.view.frame               = subview.bounds;
    player.shouldAutoplay           = NO;
    player.view.autoresizingMask    = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

     // ビュー登録
    [subview addSubview:player.view];
    
    // 再生準備
    [player prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (player != nil) {
        [player stop];
        [player.view removeFromSuperview];
    }
}

@end
