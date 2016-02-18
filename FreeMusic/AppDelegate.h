//
//  AppDelegate.h
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMSearchViewController,FMLocalViewController,FMVideoViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger index;
    NSMutableArray * array;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FMSearchViewController *searchViewController;
@property (strong, nonatomic) UINavigationController * searchNavigationController;
@property (strong, nonatomic) FMLocalViewController * localViewController;
@property (strong, nonatomic) UINavigationController * localNavigationController;

@property (strong, nonatomic) FMVideoViewController * videoViewController;
@property (strong, nonatomic) UINavigationController * videoNavigationController;


@property (strong, nonatomic) UITabBarController * tabBarController;

@end
