//
//  TestBind3.m
//  XAnimation_Example
//
//  Created by xiyuan wang on 2022/3/31.
//  Copyright © 2022 wangxiyuan. All rights reserved.
//

#import "TestBind3.h"
#import <XAnimation/LOTAnimationView.h>
#import <XAnimation/UIView+XALottie.h>
#import <XAnimation/XABindLottieController.h>

@interface TestBind3 ()

//@property (nonatomic, strong) UIImageView *paiziV;

@property (nonatomic, strong) NSMutableArray *bindViews;

@property (nonatomic, strong) UIView *sepLine;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UILabel *titleView;

@property (nonatomic, strong) UILabel *descLabel, *label1;


@end

@implementation TestBind3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.bindViews = [NSMutableArray new];
    

    [self setupBindViews];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 330, self.view.frame.size.width, 1)];
    sepLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sepLine];
    self.sepLine = sepLine;
    
    [self setupControls];
}

- (void)setupControls{
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, self.sepLine.frame.origin.y + self.sepLine.frame.size.height + 30, 200, 40)];
    [self.view addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.layer.borderColor = [UIColor blackColor].CGColor;
    pauseBtn.layer.borderWidth = 1;
    pauseBtn.frame = CGRectMake(10, _slider.frame.origin.y + _slider.frame.size.height + 30, 80, 50);
    [pauseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pauseBtn  setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton *resumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resumeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    resumeBtn.layer.borderWidth = 1;
    resumeBtn.frame = CGRectMake(10, pauseBtn.frame.origin.y + pauseBtn.frame.size.height + 30, 80, 50);
    [resumeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resumeBtn  setTitle:@"恢复" forState:UIControlStateNormal];
    [resumeBtn addTarget:self action:@selector(resumeBtnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeBtn];
}

- (void)setupBindViews{
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.width, 80)];
    _descLabel.numberOfLines = 0;
    _descLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_descLabel];
    
    
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(20, _descLabel.frame.origin.y + _descLabel.frame.size.height, 0, 0)];
    title.textColor = [UIColor blueColor];
    self.titleView = title;
    [self.view addSubview:title];
    [self updateProgress:0.0];
    
    UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.origin.y + title.frame.size.height + 60, 0, 0)];
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
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.font = [UIFont systemFontOfSize:30];
    lb1.textColor = [UIColor orangeColor];
    [lb1 sizeToFit];
    lb1.center = CGPointMake(self.view.frame.size.width / 4 * 3, lb.center.y);
    [lb1 bindLottieLayerName:@"风车"];
    _label1 = lb1;
    [self.view addSubview:lb1];
    [self.bindViews addObject:lb1];
}

- (void)updateProgress:(CGFloat)progress{
    self.titleView.text = [@"示例:  2个图层关联" stringByAppendingFormat:@"  进度: %.2f%%", progress * 100];
    
    [self.titleView sizeToFit];
}

//        [bindView bindLottieWithContentsOfURL:[NSURL URLWithString:@"https://storage.360buyimg.com/xview-beta/2022-3-23/749aa980-3ab9-4ddc-86aa-0049c52f9bc1.json"]];

- (void)viewDidAppear:(BOOL)animated{
   // @"预合成 1" : @"img_0.png"
    [super viewDidAppear:animated];
    XABindLottieController *controller = [self.view bindLottieWithAnimationNamed:@"风车动画_range2"];
    [controller play];
    controller.delegate = self;
//    [[self.view currentBindController] play];
}

- (void)sliderAction:(id)sender{
    NSLog(@"%f", _slider.value);
    XABindLottieController *controller = [self.view currentBindController];
    [controller stop];
    [controller playFromProgress:_slider.value toProgress:1 withCompletion:^(BOOL animationFinished) {
        
    }];
}

- (void)pauseBtnAction:(id)sender {
    XABindLottieController *controller = [self.view currentBindController];
    [controller pause];
}

- (void)resumeBtnBtnAction:(id)sender{
    XABindLottieController *controller = [self.view currentBindController];
    [controller play];
}

- (void)bindController:(XABindLottieController *)bindController didUpdateProgress:(CGFloat)progress{
    if (progress > 0.7) {
        _label1.text = @"我变了";
    }
    [self updateProgress:progress];
}

- (void)bindController:(XABindLottieController *)bindController layerEnterForName:(NSString *)layerName{
    self.descLabel.text = [self.descLabel.text ? self.descLabel.text : @"" stringByAppendingFormat:@"%@ 进入。。", layerName];
    NSLog(@"%@ 进入", layerName);
}

- (void)bindController:(XABindLottieController *)bindController layerOutForName:(NSString *)layerName{
    self.descLabel.text = [self.descLabel.text ? self.descLabel.text : @"" stringByAppendingFormat:@"%@ 退出。。", layerName];
    NSLog(@"%@ 退出", layerName);
}

@end
