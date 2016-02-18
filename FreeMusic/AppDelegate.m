//
//  AppDelegate.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "AppDelegate.h"
#import "MCDataEngine.h"
#import "Globle.h"
#import "FMSingerModel.h"
#import "FMSearchViewController.h"
#import "FMLocalViewController.h"
#import "FMVideoViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    [self.window setFrame:[[UIScreen mainScreen] bounds]];
    
    Globle * globe = [Globle shareGloble];
    globe.isPlaying = YES;
    [globe copySqlitePath];
    
    self.searchViewController = [[FMSearchViewController alloc] init];
    self.searchNavigationController = [[UINavigationController alloc] initWithRootViewController:self.searchViewController];
    
    self.videoViewController = [[FMVideoViewController alloc] init];
    self.videoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.videoViewController];
    
    self.localViewController = [[FMLocalViewController alloc] init];
    self.localNavigationController = [[UINavigationController alloc] initWithRootViewController:self.localViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.localNavigationController, self.videoNavigationController, self.searchNavigationController, nil];
    
    self.tabBarController.selectedViewController = self.searchNavigationController;
    [self.window addSubview:self.tabBarController.view];
    [self.window setRootViewController:self.tabBarController];
    
    [self.window makeKeyAndVisible];
    
    self.localNavigationController.tabBarItem.title = @"My Music";
    self.localNavigationController.tabBarItem.image = [UIImage imageNamed:@"mymusic"];
    
    self.searchNavigationController.tabBarItem.title = @"Search";
    self.searchNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbarSearch"];
    
    self.videoNavigationController.tabBarItem.title = @"Tudou Video";
    self.videoNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbarMovie" ];
    
    [self.window setBackgroundColor:[UIColor lightGrayColor]];
    return YES;
}

-(void)addSingerToDB
{
    long long uid = 60467713;//[[array objectAtIndex:index] longLongValue];
    MCDataEngine * engine = [MCDataEngine new];
    [engine getSingerInformationWith:uid WithCompletionHandler:^(NSArray *array) {
//        index+=1;
//        NSLog(@"%ld",(long)index);
//        [self performSelector:@selector(addSingerToDB) withObject:nil afterDelay:0.1];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
    [Globle shareGloble].isApplicationEnterBackground = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:FMRFRadioViewSetSongInformationNotification object:nil userInfo:nil];
}
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSString * status = nil;
	if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause:
                status = @"UIEventSubtypeRemoteControlPause";
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                status = @"UIEventSubtypeRemoteControlPreviousTrack";
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                status = @"UIEventSubtypeRemoteControlNextTrack";
                break;
            case UIEventSubtypeRemoteControlPlay:
                status = @"UIEventSubtypeRemoteControlPlay";
                break;
            default:
                break;
        }
    }
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:status forKey:@"keyStatus"];
    [[NSNotificationCenter defaultCenter] postNotificationName:FMRFRadioViewStatusNotifiation object:nil userInfo:dict];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [Globle shareGloble].isApplicationEnterBackground = NO;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
