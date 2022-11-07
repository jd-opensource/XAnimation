//
//  TestBind1.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/3/24.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBind1.h"

#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>


@interface TestBind1 ()

@property (nonatomic, strong) LOTAnimationView *origin;
@property (nonatomic, strong) UIImageView *paiziV;

@property (nonatomic, strong) NSMutableArray *bindViews;

@property (nonatomic, strong) UIView *sepLine;

@end

@implementation TestBind1

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
    
    LOTAnimationView *view = [LOTAnimationView animationNamed:@"呼吸动效"];
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
    title.text = @"示例1: 动画绑定到一个UIImageView";
    title.textColor = [UIColor blueColor];
    [title sizeToFit];
    [self.view addSubview:title];
    
    _paiziV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paizi"]];
    _paiziV.frame = CGRectMake(0, title.frame.origin.y + title.frame.size.height + 10, 73, 73);
    _paiziV.center = CGPointMake(self.view.frame.size.width / 2, _paiziV.center.y);
    [self.view addSubview:_paiziV];
    [self.bindViews addObject:_paiziV];
    
    
    UILabel *title2= [[UILabel alloc] initWithFrame:CGRectMake(20, self.paiziV.frame.origin.y + self.paiziV.frame.size.height + 80, 0, 0)];
    title2.text = @"示例2: 动画绑定到一个UILabel";
    title2.numberOfLines = 2;
    title2.textColor = [UIColor blueColor];
    [title2 sizeToFit];
    [self.view addSubview:title2];
    
    UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(_paiziV.frame.origin.x, title2.frame.origin.y + title2.frame.size.height + 30, 0, 0)];
    lb.text = @"绑定者";
    lb.font = [UIFont systemFontOfSize:30];
    lb.textColor = [UIColor orangeColor];
    [lb sizeToFit];
    lb.center = CGPointMake(self.view.frame.size.width / 2, lb.center.y);
    [self.view addSubview:lb];
    [self.bindViews addObject:lb];
}

//        [bindView bindLottieWithContentsOfURL:[NSURL URLWithString:@"https://storage.360buyimg.com/xview-beta/2022-3-23/749aa980-3ab9-4ddc-86aa-0049c52f9bc1.json"]];

- (void)viewDidAppear:(BOOL)animated{
   // @"预合成 1" : @"img_0.png"
    [super viewDidAppear:animated];
    for (UIView *bindView in self.bindViews) {
        [bindView bindLottieLayerName:@"预合成 1"];
        [bindView bindLottieWithAnimationNamed:@"呼吸动效"];
        [[bindView currentBindController] play];
    }
    [self.origin play];
}

@end
