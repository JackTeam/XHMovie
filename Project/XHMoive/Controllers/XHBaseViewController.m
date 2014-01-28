//
//  XHBaseViewController.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHBaseViewController.h"

@interface XHBaseViewController ()

@end

@implementation XHBaseViewController

#pragma mark - life cycle

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
