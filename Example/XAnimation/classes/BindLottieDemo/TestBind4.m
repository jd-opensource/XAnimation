//
//  TestBind4.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/4/11.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBind4.h"
#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/CALayer+XALottie.h>
#import <XAnimation/XABindLottieController.h>

@interface TestBind4 () <XALOTBindControllerDelegate>

@property (nonatomic, strong) UIImageView *paiziV;
@property (nonatomic, strong) UILabel *textLB;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) NSMutableArray *bindViews;

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation TestBind4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.bindViews = [NSMutableArray new];
    [self setupBindViews];
    
}

- (void)setupBindViews{
    
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 0, 0)];
    title.text = @"示例1: 动画过程中切换图片";
    title.textColor = [UIColor blueColor];
    [title sizeToFit];
    [self.view addSubview:title];
    
    _paiziV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paizi"]];
    _paiziV.frame = CGRectMake(0, title.frame.origin.y + title.frame.size.height + 10, 73, 73);
    _paiziV.center = CGPointMake(self.view.frame.size.width / 2, _paiziV.center.y);
    [self.view addSubview:_paiziV];
    [self.bindViews addObject:_paiziV];
    
    
    UILabel *title2= [[UILabel alloc] initWithFrame:CGRectMake(20, self.paiziV.frame.origin.y + self.paiziV.frame.size.height + 80, 0, 0)];
    title2.text = @"示例2: 动画过程中更新文本";
    title2.numberOfLines = 2;
    title2.textColor = [UIColor blueColor];
    [title2 sizeToFit];
    [self.view addSubview:title2];
    
    UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(_paiziV.frame.origin.x, title2.frame.origin.y + title2.frame.size.height + 30, 150, 40)];
    lb.text = @"绑定者";
    lb.font = [UIFont systemFontOfSize:30];
    lb.textColor = [UIColor orangeColor];
    lb.center = CGPointMake(self.view.frame.size.width / 2, lb.center.y);
    lb.layer.borderColor = [UIColor redColor].CGColor;
    lb.layer.borderWidth = 1;
    _textLB = lb;
    [self.view addSubview:lb];
    [self.bindViews addObject:lb];
    
    
    UILabel *title3= [[UILabel alloc] initWithFrame:CGRectMake(20, self.textLB.frame.origin.y + self.textLB.frame.size.height + 80, 0, 0)];
    title3.text = @"示例3: 动画过程中更新 Path";
    title3.numberOfLines = 2;
    title3.textColor = [UIColor blueColor];
    [title3 sizeToFit];
    [self.view addSubview:title3];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.frame = CGRectMake(title3.frame.origin.x, title3.frame.origin.y + title3.frame.size.height + 30, 100, 100);
    circle.position = CGPointMake(self.view.frame.size.width / 2, circle.position.y);
    [self.view.layer addSublayer:circle];
    [circle bindLottieLayerName:@"预合成 1"];
    XABindLottieController *controller = [circle bindLottieWithAnimationNamed:@"呼吸动效"];
    controller.delegate = self;
    [[circle currentBindController] play];
    _circleLayer = circle;
}

- (void)viewDidAppear:(BOOL)animated{
   // @"预合成 1" : @"img_0.png"
    [super viewDidAppear:animated];
    for (UIView *bindView in self.bindViews) {
        [bindView bindLottieLayerName:@"预合成 1"];
        XABindLottieController *controller = [bindView bindLottieWithAnimationNamed:@"呼吸动效"];
        controller.delegate = self;
        [[bindView currentBindController] play];
    }
}

- (void)bindController:(XABindLottieController *)bindController didUpdateProgress:(CGFloat)progress{
    if (bindController.host == self.textLB) {
        self.textLB.text= [NSString stringWithFormat:@"%f", progress];
    } else if (bindController.host == self.paiziV) {
        self.paiziV.image = ((int)(progress * 10)) % 2 == 1 ? [UIImage imageNamed:@"paizi"] : [UIImage imageNamed:@"chinalogo"];
    } else if (bindController.host == _circleLayer) {
        _circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(_circleLayer.bounds), CGRectGetMidY(_circleLayer.bounds)) radius:CGRectGetMidX(_circleLayer.bounds) startAngle: - M_PI*0.5 endAngle: - M_PI*0.5 + M_PI*2.0 * progress clockwise:YES].CGPath;
        _circleLayer.strokeColor = [UIColor redColor].CGColor;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
    }
}

- (void)bindController:(XABindLottieController *)bindController layerEnterForName:(NSString *)layerName{
    
}

- (void)bindController:(XABindLottieController *)bindController layerOutForName:(NSString *)layerName{
    
}

@end
