//
//  TestBind0.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/3/24.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBind0.h"
#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>

@interface TestBind0 ()

@property (nonatomic, strong) LOTAnimationView *origin;
@property (nonatomic, strong) UIImageView *paiziV;

@property (nonatomic, strong) NSMutableArray *bindViews;

@property (nonatomic, strong) UIView *sepLine;

@end

@implementation TestBind0

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
    
    LOTAnimationView *view = [LOTAnimationView animationNamed:@"牌子动画（旋转+位移+缩放）"];
//    LOTAnimationView *view = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://storage.360buyimg.com/xview-beta/2022-3-23/749aa980-3ab9-4ddc-86aa-0049c52f9bc1.json"]];
    view.frame = CGRectMake(120, 100, 153, 127);
    view.center = CGPointMake(view.center.x, lb.center.y);
//    view.loopAnimationCount = 0;
    [self.view addSubview:view];
    self.origin = view;
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, _origin.frame.origin.y +_origin.frame.size.height + 10, self.view.frame.size.width, 1)];
    sepLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sepLine];
    self.sepLine = sepLine;
    
    [self setupBindViews];
    
    UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 1, self.view.frame.size.height)];
    vline.backgroundColor = [UIColor redColor];
    [self.view addSubview:vline];
    
    UIView *vline2 = [[UIView alloc] initWithFrame:CGRectMake(120 + 38, 0, 1, self.view.frame.size.height)];
    vline2.backgroundColor = [UIColor redColor];
    [self.view addSubview:vline2];
    
    UIView *vline3 = [[UIView alloc] initWithFrame:CGRectMake(121, 0, 1, self.view.frame.size.height)];
    vline3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:vline3];
    
    UIView *vline4 = [[UIView alloc] initWithFrame:CGRectMake(0, 265, self.view.frame.size.width, 1)];
    vline4.backgroundColor = [UIColor blueColor];
    [self.view addSubview:vline4];
}

- (void)setupBindViews{
    
    UILabel *title= [[UILabel alloc] init];
    title.text = @"示例1: 将LottieJson中图层名为“牌子”的动效绑定到下面的 UIImageView";
    title.numberOfLines = 0;
    title.textColor = [UIColor blueColor];
    CGSize titleSize = [title sizeThatFits:CGSizeMake(280, 100)];
    title.frame = CGRectMake(20, self.sepLine.frame.origin.y + self.sepLine.frame.size.height + 10, titleSize.width, titleSize.height);
    [self.view addSubview:title];
    
    _paiziV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paizi"]];
    _paiziV.frame = CGRectMake(0, title.frame.origin.y + title.frame.size.height + 10, 73, 73);
    _paiziV.center = CGPointMake(self.view.frame.size.width / 2 - 2, _paiziV.center.y);
    
    //resetAnchor
    CGPoint img1OldAnchorPt = _paiziV.layer.anchorPoint;
    CGPoint img1NewAnchorPt = CGPointMake(0.2, 0.7);
    CGFloat xMoveFix = (img1NewAnchorPt.x - img1OldAnchorPt.x) * CGRectGetWidth(_paiziV.bounds);
    CGFloat yMoveFix = (img1NewAnchorPt.y - img1OldAnchorPt.y) * CGRectGetHeight(_paiziV.bounds);
    _paiziV.layer.anchorPoint = img1NewAnchorPt;
    _paiziV.layer.position = CGPointMake(_paiziV.layer.position.x + xMoveFix, _paiziV.layer.position.y + yMoveFix);
    
    [self.view addSubview:_paiziV];
    [self.bindViews addObject:_paiziV];
    
    
    
    UILabel *title2= [[UILabel alloc] initWithFrame:CGRectMake(20, self.paiziV.frame.origin.y + self.paiziV.frame.size.height + 80, 0, 0)];
    title2.text = @"示例2: 同上，绑定到一个UILabel";
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
    [super viewDidAppear:animated];
    for (UIView *bindView in self.bindViews) {
        [bindView bindLottieLayerName:@"牌子"];
        [bindView bindLottieWithAnimationNamed:@"牌子动画（旋转+位移+缩放）"];
        [[bindView currentBindController] play];
    }
    
    
    [self.origin play];
}


@end
