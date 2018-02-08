//
//  ViewController.m
//  RunInTheBack
//
//  Created by Shuai Lu on 7/10/16.
//  Copyright © 2016 SHUAILU. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property(strong, nonatomic)AVAudioPlayer *mPlayer;

@property(assign, nonatomic)CGFloat mCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self playMusic];
    _mCount = 0;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)countTime{
    _mCount+=10;
    NSLog(@"%f",_mCount);
    
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] < 60.) {//当剩余时间小于60时，开如播放音乐，并用这个假前台状态再次申请后台
        NSLog(@"播放%@",[NSThread currentThread]);
        [self playMusic];
        //申请后台
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"我要挂起了");
        }];
    }
}

-(void)playMusic{
    //1.音频文件的url路径，实际开发中，用无声音乐
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"la_campanella.mp3" withExtension:Nil];
    
    //2.创建播放器（注意：一个AVAudioPlayer只能播放一个url）
    _mPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    
    //3.缓冲
    [_mPlayer prepareToPlay];
    
    //4.播放
    [_mPlayer play];
}

@end
