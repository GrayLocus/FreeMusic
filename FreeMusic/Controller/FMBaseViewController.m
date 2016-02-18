//
//  BaseViewController.m
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "FMBaseViewController.h"

//@interface FMBaseViewController ()
//
//@end

@implementation FMBaseViewController
@synthesize navigation = _navigation;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {};
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * system = [UIDevice currentDevice].systemVersion;
    float versionNumber = [system floatValue];
    
    CGFloat navBarHeight = 0.0f;
    NSInteger type = 0;
    if (versionNumber <= 6.9) {
        type = 0;
        navBarHeight = 44.0f;
    } else {
        type = 1;
        navBarHeight = 66.0f;
    }
    
    globle = [Globle shareGloble];
    
    self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, navBarHeight)];
    _navigation.viewType = type;
    _navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    _navigation.delegate = self;
    _navigation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigation];

	// Do any additional setup after loading the view.
}

#pragma mark ZZNavigationViewDelegate
-(void)previousToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClickEvent
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
