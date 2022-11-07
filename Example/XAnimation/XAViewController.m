//
//  XAViewController.m
//  XAnimation
//
//  Created by wangxiyuan on 09/14/2022.
//  Copyright (c) 2022 wangxiyuan. All rights reserved.
//

#import "XAViewController.h"
#import "TestBindLottieRootViewController.h"

@interface XAViewController ()

@end

@implementation XAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TestBindLottieRootViewController *navRoot = [[TestBindLottieRootViewController alloc] init];
    [self pushViewController:navRoot animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
