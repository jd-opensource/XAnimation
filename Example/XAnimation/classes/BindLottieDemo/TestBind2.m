//
//  TestBind2.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/3/25.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBind2.h"
#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>

@interface TestBind2 ()

@property (nonatomic, strong) LOTAnimationView *origin;
@property (nonatomic, strong) UIImageView *paiziV;

@property (nonatomic, strong) NSMutableArray *bindViews;

@property (nonatomic, strong) UIView *sepLine;

@end

@implementation TestBind2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.bindViews = [NSMutableArray new];
    
    UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 0, 0)];
    lb.text = @"原始 lottie:";
    lb.textColor = [UIColor blackColor];
    [lb sizeToFit];
    [self.view addSubview:lb];
    
    
    LOTAnimationView *view = [LOTAnimationView animationNamed:@"fengche_paizi"];
//    LOTAnimationView *view = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://storage.360buyimg.com/xview-beta/2022-3-23/749aa980-3ab9-4ddc-86aa-0049c52f9bc1.json"]];
    view.frame = CGRectMake(lb.frame.origin.x + lb.frame.size.width + 10, 100, 153, 127);
    view.center = CGPointMake(view.center.x, lb.center.y);
//    view.loopAnimationCount = 0;
    [self.view addSubview:view];
    self.origin = view;
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, _origin.frame.origin.y +_origin.frame.size.height + 10, self.view.frame.size.width, 1)];
    sepLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sepLine];
    self.sepLine = sepLine;
    
    [self setupBindViews];
    
}

- (void)setupBindViews{
    
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(20, self.sepLine.frame.origin.y + self.sepLine.frame.size.height + 30, 0, 0)];
    title.text = @"示例: 分别绑定到俩个视图";
    title.textColor = [UIColor blueColor];
    [title sizeToFit];
    [self.view addSubview:title];
    
    UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(_paiziV.frame.origin.x, title.frame.origin.y + title.frame.size.height + 60, 0, 0)];
    lb.text = @"棋子动画";
    lb.font = [UIFont systemFontOfSize:30];
    lb.textColor = [UIColor redColor];
    [lb sizeToFit];
    lb.center = CGPointMake(self.view.frame.size.width / 4, lb.center.y);
    [lb bindLottieLayerName:@"牌子"];
    [self.view addSubview:lb];
    [self.bindViews addObject:lb];
    
    UILabel *lb1= [[UILabel alloc] initWithFrame:CGRectZero];
    lb1.text = @"风车动画";
    lb1.font = [UIFont systemFontOfSize:30];
    lb1.textColor = [UIColor orangeColor];
    [lb1 sizeToFit];
    lb1.center = CGPointMake(self.view.frame.size.width / 4 * 3, lb.center.y);
    [lb1 bindLottieLayerName:@"风车"];
    [self.view addSubview:lb1];
    [self.bindViews addObject:lb1];
}

//        [bindView bindLottieWithContentsOfURL:[NSURL URLWithString:@"https://storage.360buyimg.com/xview-beta/2022-3-23/749aa980-3ab9-4ddc-86aa-0049c52f9bc1.json"]];

- (void)viewDidAppear:(BOOL)animated{
   // @"预合成 1" : @"img_0.png"
    [super viewDidAppear:animated];
    [self.view bindLottieWithAnimationNamed:@"fengche_paizi"];
    [[self.view currentBindController] play];
    [self.origin play];
}

@end
