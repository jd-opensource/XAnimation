//
//  XABindLottieHomeViewController.m
//
//
//  Created by xiyuan wang on 2022/3/24.
//

#ifdef XABindLottieDebug

#import "XABindLottieHomeViewController.h"
#import "XABindLottieDebugWindow.h"
#import "UIView+XALottie.h"
#import "XABindLottieController.h"
#import "XALottieLocalLib.h"

@interface XABindLottieHomeViewController ()

@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, weak)   UIView *responderView;
@property (nonatomic, strong) UIView *hilightResponderRect;
@property (nonatomic, strong) UIView *responderFinderView;

@property (nonatomic, strong) UISwitch *bindSwitch;
@property (nonatomic, strong) UILabel *mainViewTitle;

@property (nonatomic, assign) CGPoint dot;


@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIButton *useAnim0Btn;
@property (nonatomic, strong) UIButton *useAnim1Btn;

@property (nonatomic, assign) NSInteger uiStatus;


@property (nonatomic, assign) CGPoint latestMinumPos;

@end

@implementation XABindLottieHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.latestMinumPos = [self initMinumWindowFrame].origin;
    [self setupSubviews];
    [self layoutAll];
}


- (void)setupSubviews{
    [self.view addSubview:self.responderFinderView];
    [self.view addSubview:self.mainView];
}

- (CGSize)mainViewSize{
    return CGSizeMake(300, 160);
}

- (CGRect)initMinumWindowFrame {
    return CGRectMake([XABindLottieDebugWindow screenWidth] - [self mainViewSize].width - 20, [XABindLottieDebugWindow screenHeight] - [self mainViewSize].height - 20, [self mainViewSize].width, [self mainViewSize].height);
}

- (void)layoutAll{
    switch (_uiStatus) {
        case 0: //小浮层
            self.responderFinderView.hidden = YES;
            [XABindLottieDebugWindow sharedInstance].frame = CGRectMake(self.latestMinumPos.x, self.latestMinumPos.y, [self mainViewSize].width, [self mainViewSize].height);
            self.mainView.frame = CGRectMake(0, 0, [self mainViewSize].width, [self mainViewSize].height);
            break;
        case 1: //全屏查找绑定元素
            self.responderFinderView.hidden = NO;
            [XABindLottieDebugWindow sharedInstance].frame = CGRectMake(0, 0, [XABindLottieDebugWindow screenWidth], [XABindLottieDebugWindow screenHeight]);
            self.mainView.frame = CGRectMake(self.latestMinumPos.x, self.latestMinumPos.y, [self mainViewSize].width, [self mainViewSize].height);
            break;
        default:
            break;
    }
    [self layoutFinderView];
}

- (void)layoutFinderView{
    if (!_responderFinderView.hidden) {
        CGRect hitRect = CGRectMake(self.dot.x, self.dot.y, 1, 1);
        if (_responderView) {
            hitRect = [self responderLayerFrame];
            self.hilightResponderRect.frame = hitRect;
        } else {
            self.hilightResponderRect.frame = CGRectZero;
        }
        self.leftLine.frame = CGRectMake(0, floor(hitRect.origin.y + hitRect.size.height / 2), hitRect.origin.x, 1);
        self.topLine.frame = CGRectMake(floor(hitRect.origin.x + hitRect.size.width / 2), 0, 1, hitRect.origin.y);
        self.rightLine.frame = CGRectMake(hitRect.origin.x + hitRect.size.width, self.leftLine.frame.origin.y, [XABindLottieDebugWindow screenWidth] - hitRect.origin.x - hitRect.size.width, 1);
        self.bottomLine.frame = CGRectMake(self.topLine.frame.origin.x, hitRect.origin.y + hitRect.size.height, 1, [XABindLottieDebugWindow screenHeight] - hitRect.origin.y - hitRect.size.height);
    }
}


- (UIView *)diguiFindResponderForPt:(CGPoint)pt superLayer:(UIView *)view{
    if (!view) return nil;
    NSArray *subLayers = view.subviews;
    if (subLayers.count > 0) {
        for (NSInteger idx = subLayers.count - 1; idx >= 0; idx--) {
            UIView *subLayer = subLayers[idx];
            UIView *hitLayer = [self diguiFindResponderForPt:pt superLayer:subLayer];
            if (hitLayer) {
                return hitLayer;
            }
        }
    }
    if (view.hidden || view.alpha == 0 || view.frame.size.width == 0 || view.frame.size.height == 0 ||
        (view.frame.size.width == [XABindLottieDebugWindow screenWidth] && view.frame.size.height == [XABindLottieDebugWindow screenHeight]) ) {
        return nil;
    }
    CGRect layerFrameReferScreen = [[XABindLottieDebugWindow sharedInstance].appMainWindow convertRect:view.bounds fromView:view];
    if (pt.x >= layerFrameReferScreen.origin.x
         && pt.x <= layerFrameReferScreen.origin.x +  layerFrameReferScreen.size.width
        &&
        pt.y >= layerFrameReferScreen.origin.y
             && pt.y <= layerFrameReferScreen.origin.y +  layerFrameReferScreen.size.height) {
        return view;
    }
    return nil;
}

- (void)findResponder{
    UIWindow *keyWindow = [XABindLottieDebugWindow sharedInstance].appMainWindow;
    UIView *responder = [self diguiFindResponderForPt:self.dot superLayer:keyWindow];
    self.responderView = responder;
}

- (CGRect)responderLayerFrame{
    if (_responderView) {
        CGRect layerFrameReferScreen = [[XABindLottieDebugWindow sharedInstance].appMainWindow convertRect:_responderView.bounds fromView:_responderView];
        return layerFrameReferScreen;
    }
    return CGRectZero;
}

- (UILabel *)mainViewTitle {
    if (!_mainViewTitle) {
        _mainViewTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _mainViewTitle.text = @"目标选择:";
        _mainViewTitle.font = [UIFont systemFontOfSize:22];
        _mainViewTitle.textColor = [UIColor blueColor];
        [_mainViewTitle sizeToFit];
        _mainViewTitle.frame = CGRectMake(5, 10, _mainViewTitle.bounds.size.width, _mainViewTitle.bounds.size.height);
    }
    return _mainViewTitle;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        _mainView.layer.borderColor = [UIColor blueColor].CGColor;
        _mainView.layer.borderWidth = 1;
        [_mainView addSubview:self.mainViewTitle];
        [_mainView addSubview:self.bindSwitch];
        [_mainView addSubview:self.useAnim0Btn];
        [_mainView addSubview:self.useAnim1Btn];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainViewPan:)];
        [_mainView addGestureRecognizer:pan];
    }
    return _mainView;
}

- (UISwitch *)bindSwitch{
    if (!_bindSwitch) {
        _bindSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        _bindSwitch.on = NO;
        [_bindSwitch addTarget:self action:@selector(bindSwitchChange) forControlEvents:UIControlEventValueChanged];
        _bindSwitch.frame = CGRectMake(
                                       self.mainViewTitle.frame.origin.x +  self.mainViewTitle.frame.size.width + 8, 2, 60, 30);
    }
    return _bindSwitch;
}

- (UIButton *)useAnim0Btn{
    if (!_useAnim0Btn) {
        _useAnim0Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_useAnim0Btn setTitle:@"  执行动画（旋转 + 缩放 + 平移） " forState:UIControlStateNormal];
        _useAnim0Btn.layer.borderColor = [UIColor orangeColor].CGColor;
        _useAnim0Btn.layer.borderWidth = 1;
        _useAnim0Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _useAnim0Btn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        [_useAnim0Btn sizeToFit];
        [_useAnim0Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _useAnim0Btn.frame = CGRectMake(5, self.bindSwitch.frame.origin.y + self.bindSwitch.frame.size.height + 20, _useAnim0Btn.frame.size.width, _useAnim0Btn.frame.size.height);
        _useAnim0Btn.layer.cornerRadius = _useAnim0Btn.frame.size.height / 2;
        [_useAnim0Btn addTarget:self action:@selector(useAnim0Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _useAnim0Btn;
}

- (UIButton *)useAnim1Btn{
    if (!_useAnim1Btn) {
        _useAnim1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_useAnim1Btn setTitle:@"   执行动画（呼吸） " forState:UIControlStateNormal];
        _useAnim1Btn.layer.borderColor = [UIColor orangeColor].CGColor;
        _useAnim1Btn.layer.borderWidth = 1;
        _useAnim1Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _useAnim1Btn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        [_useAnim1Btn sizeToFit];
        [_useAnim1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _useAnim1Btn.frame = CGRectMake(5, self.useAnim0Btn.frame.origin.y + self.useAnim0Btn.frame.size.height + 10, _useAnim1Btn.frame.size.width, _useAnim1Btn.frame.size.height);
        _useAnim1Btn.layer.cornerRadius = _useAnim0Btn.frame.size.height / 2;
        [_useAnim1Btn addTarget:self action:@selector(useAnim1Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _useAnim1Btn;
}


- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = [UIColor redColor];
    }
    return _leftLine;
}

- (UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = [UIColor redColor];
    }
    return _rightLine;
}

- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor redColor];
    }
    return _topLine;
}

- (UIView *)hilightResponderRect{
    if (!_hilightResponderRect) {
        _hilightResponderRect = [[UIView alloc] init];
        _hilightResponderRect.layer.borderWidth = 2;
        _hilightResponderRect.layer.borderColor = [UIColor purpleColor].CGColor;
        _hilightResponderRect.backgroundColor = [UIColor clearColor];
    }
    return _hilightResponderRect;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor redColor];
    }
    return _bottomLine;
}

- (UIView *)responderFinderView{
    if (!_responderFinderView) {
        self.dot = CGPointMake(floor([XABindLottieDebugWindow screenWidth] / 2), floor([XABindLottieDebugWindow screenHeight] / 2));
        _responderFinderView = [[UIView alloc] init];
        _responderFinderView.frame = CGRectMake(0, 0, [XABindLottieDebugWindow screenWidth], [XABindLottieDebugWindow screenHeight]);
        _responderFinderView.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *responderFinderPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(responderFinderPan:)];
        [_responderFinderView addGestureRecognizer:responderFinderPan];
        
        [_responderFinderView addSubview:self.leftLine];
        [_responderFinderView addSubview:self.topLine];
        [_responderFinderView addSubview:self.rightLine];
        [_responderFinderView addSubview:self.bottomLine];
        [_responderFinderView addSubview:self.hilightResponderRect];
    }
    return _responderFinderView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *aTouch = [touches anyObject];
    // startTouchPosition是一个CGPoint类型的属性，用来存储当前touch事件的位置
    CGPoint pt = [aTouch locationInView:[XABindLottieDebugWindow sharedInstance].appMainWindow];
    NSLog(@"pt = (%f, %f)", pt.x, pt.y);
    [self changeDot:pt];
    [super touchesBegan:touches withEvent:event];
}

- (void)responderFinderPan:(UIPanGestureRecognizer *)pan{
    CGPoint pt =  [pan locationInView:[XABindLottieDebugWindow sharedInstance].appMainWindow];
    NSLog(@"pt = (%f, %f)", pt.x, pt.y);
    [self changeDot:pt];
}

- (void)changeDot:(CGPoint)pt{
    self.dot = pt;
    [self findResponder];
    [self layoutFinderView];
}

- (void)bindSwitchChange{
    self.uiStatus = self.bindSwitch.on ? 1 : 0;
    [self layoutAll];
}


- (void)mainViewPan:(UIPanGestureRecognizer *)pan{
    if (self.uiStatus == 0) {
        CGPoint pt = [pan translationInView:[XABindLottieDebugWindow sharedInstance].appMainWindow];
        UIWindow *debugWindow = [XABindLottieDebugWindow sharedInstance];
        debugWindow.center = CGPointMake(debugWindow.center.x + pt.x, debugWindow.center.y + pt.y);
        if (debugWindow.frame.origin.x + debugWindow.frame.size.width > [XABindLottieDebugWindow screenWidth]) {
            debugWindow.center = CGPointMake([XABindLottieDebugWindow screenWidth] - [self mainViewSize].width / 2, debugWindow.center.y);
        } else if (debugWindow.frame.origin.x < 0) {
            debugWindow.center = CGPointMake([self mainViewSize].width / 2, debugWindow.center.y);
        }
        if (debugWindow.frame.origin.y < 0) {
            debugWindow.center = CGPointMake(debugWindow.center.x, ceil( [self mainViewSize].height / 2));
        } else if (debugWindow.frame.origin.y + debugWindow.frame.size.height > [XABindLottieDebugWindow screenHeight]) {
            debugWindow.center = CGPointMake(debugWindow.center.x, [XABindLottieDebugWindow screenHeight] - [self mainViewSize].height / 2);
        }
        [pan setTranslation:CGPointZero inView:[XABindLottieDebugWindow sharedInstance].appMainWindow];
        self.latestMinumPos = debugWindow.frame.origin;
    }
    
}

- (void)useAnim0Action:(id)sender{
    NSString *filePath = [XALottieLocalLib filePathForLocalLibWithName:@"paizi_s_t_r"];
    if (self.responderView && filePath) {
        [self.responderView bindLottieLayerName:@"牌子"];
        [self.responderView bindLottieWithFilePath:filePath];
        [[self.responderView currentBindController] play];
        self.bindSwitch.on = NO;
        [self bindSwitchChange];
    }
}

- (void)useAnim1Action:(id)sender{
    NSString *filePath = [XALottieLocalLib filePathForLocalLibWithName:@"huxi"];
    if (self.responderView && filePath) {
        [self.responderView bindLottieLayerName:@"预合成 1"];
        [self.responderView bindLottieWithFilePath:filePath];
        [[self.responderView currentBindController] play];
        self.bindSwitch.on = NO;
        [self bindSwitchChange];
    }
}

@end

#endif
