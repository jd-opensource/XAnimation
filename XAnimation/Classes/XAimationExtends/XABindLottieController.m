//
//  XABindLottieController.m
//  
//
//  Created by xiyuan wang on 2022/3/30.
//

#import "XABindLottieController.h"
#import "XABindLOTAnimationView.h"
#import <objc/runtime.h>
#import "XALOTProAnimationViewDelegate.h"
#import "XALOTProAnimationViewDatasource.h"

@interface XABindLottieController () <XALOTProAnimationViewDelegate, XALOTProAnimationViewDataSource>

@property (nonatomic, strong) XABindLOTAnimationView * bindLotView;

@end

@implementation XABindLottieController

+ (XABindLottieController *)bindLottieWithContentsOfURL:(nonnull NSURL *)url toHost:(id)host{
    XABindLOTAnimationView *bindLotView = [[XABindLOTAnimationView alloc] initWithContentsOfURL:url];
    return [self bindLottieView:bindLotView toHost:host];
}

+ (XABindLottieController *)bindLottieWithAnimationNamed:(NSString *)animationNamed toHost:(id)host{
    XABindLOTAnimationView *bindLotView = [XABindLOTAnimationView animationNamed:animationNamed];
    return [self bindLottieView:bindLotView toHost:host];
}

+ (XABindLottieController *)bindLottieWithFilePath:(NSString *)filePath toHost:(id)host{
    XABindLOTAnimationView *bindLotView = [XABindLOTAnimationView animationWithFilePath:filePath];
    return [self bindLottieView:bindLotView toHost:host];
}

+ (XABindLottieController *)bindLottieView:(XABindLOTAnimationView *)lotView toHost:(id)host{
    if (lotView && host && ([host isKindOfClass:[UIView class]] || [host isKindOfClass:[CALayer class]]) ) {
        XABindLottieController * controller = [XABindLottieController new];
        controller.bindLotView = lotView;
        UIView *hostView = [host isKindOfClass:[UIView class]] ? host : nil;
        CALayer *hostLayer = [host isKindOfClass:[CALayer class]] ? host : hostView.layer;
        lotView.hostView = hostView;
        lotView.hostLayer = hostLayer;
        [controller setupLottieView];
        return controller;
    }
    return nil;
}

- (void)setupLottieView{
    if (_bindLotView) {
        _bindLotView.frame = CGRectMake(0, 0, 1, 1);
        _bindLotView.hidden = YES;
        if (_bindLotView.hostView) {
            [_bindLotView.hostView addSubview:_bindLotView];
        } else if (_bindLotView.hostLayer) {
            [_bindLotView.hostLayer addSublayer:_bindLotView.layer];
        }
        __weak XABindLottieController *weakController = self;
        [_bindLotView setCompletionBlock:^(BOOL animationFinished) {
            __strong XABindLottieController *controller = weakController;
            if (controller) {
//                controller.bindLotView.hostLayer.transform = CATransform3DIdentity;
            }
        }];
    }
}

- (void)play{
    [_bindLotView play];
}

- (void)playFromProgress:(CGFloat)fromStartProgress
              toProgress:(CGFloat)toEndProgress
          withCompletion:(nullable XABindLottieCompletionBlock)completion{
    [_bindLotView playFromProgress:fromStartProgress toProgress:toEndProgress withCompletion:completion];
}

- (void)pause{
    [_bindLotView pause];
}

- (void)stop{
    [_bindLotView stop];
}

- (CGFloat)currentProgress{
    return [_bindLotView animationProgress];
}

- (void)setDelegate:(id<XALOTBindControllerDelegate>)delegate{
    _delegate = delegate;
    _bindLotView.delegate = self;
}

- (void)setDataSource:(id<XALOTBindControllerDataSource>)dataSource{
    _dataSource = dataSource;
    _bindLotView.dataSource = self;
}

#pragma mark - XALOTProAnimationViewDelegate
- (void)animView:(XALOTProAnimationView *)animView didUpdateProgress:(CGFloat)progress{
    if ([_delegate respondsToSelector:@selector(bindController:didUpdateProgress:)] ) {
        [_delegate bindController:self didUpdateProgress:progress];
    }
}

- (void)animView:(XALOTProAnimationView *)animView layerEnterForName:(NSString *)layerName{
    if ([_delegate respondsToSelector:@selector(bindController:layerEnterForName:)] ) {
        [_delegate bindController:self layerEnterForName:layerName];
    }
}

- (void)animView:(XALOTProAnimationView *)animView layerOutForName:(NSString *)layerName{
    if ([_delegate respondsToSelector:@selector(bindController:layerOutForName:)] ) {
        [_delegate bindController:self layerOutForName:layerName];
    }
}

- (id)host{
    return _bindLotView.hostView ? _bindLotView.hostView : _bindLotView.hostLayer;
}

- (void)setLoopAnimation:(BOOL)loopAnimation{
    _bindLotView.loopAnimation = loopAnimation;
    _loopAnimation = loopAnimation;
}

#pragma mark - XALOTProAnimationViewDataSource


@end
