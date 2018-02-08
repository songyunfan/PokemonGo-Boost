//
//  AppDelegate.m
//  RunInTheBack
//
//  Created by Shuai Lu on 7/10/16.
//  Copyright © 2016 SHUAILU. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    NSInteger count;
}
@property(strong, nonatomic)NSTimer *mTimer;
@property(assign, nonatomic)UIBackgroundTaskIdentifier backIden;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after app  lication launch.
    
    count=0;
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application { 
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_mTimer forMode:NSRunLoopCommonModes];
    [self beginTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"进入前台");
    [self endBack];
}

//计时
-(void)countAction{
    NSLog(@"%li",count++);
}

//申请后台
-(void)beginTask
{
    NSLog(@"begin=============");
    _backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
        NSLog(@"将要挂起=============");
        [self endBack];
    }];
}

//注销后台
-(void)endBack
{
    NSLog(@"end=============");
    [[UIApplication sharedApplication] endBackgroundTask:_backIden];
    _backIden = UIBackgroundTaskInvalid;
}

@end