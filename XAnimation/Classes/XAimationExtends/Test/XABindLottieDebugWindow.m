//
//  XABindLottieDebugWindow.m
//  
//
//  Created by xiyuan wang on 2022/3/24.
//

#ifdef XABindLottieDebug

#import "XABindLottieDebugWindow.h"
#import "XABindLottieDebugWindowRootViewController.h"

@implementation XABindLottieDebugWindow

+ (XABindLottieDebugWindow *)sharedInstance{
    static XABindLottieDebugWindow *_sharedInstance = nil;
    if (!_sharedInstance) {
        _sharedInstance = [XABindLottieDebugWindow new];
        _sharedInstance.backgroundColor = [UIColor clearColor];
        _sharedInstance.windowLevel = UIWindowLevelAlert;
    }
    return _sharedInstance;
}

+ (void)showDebugWindow{
    [[XABindLottieDebugWindow sharedInstance] setHidden:NO];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [[XABindLottieDebugWindow sharedInstance] makeKeyAndVisible];
    [keyWindow makeKeyAndVisible];
}

+ (void)hiddenDebugWindow{
    [[XABindLottieDebugWindow sharedInstance] setHidden:YES];
}

//+ (void)load{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [XABindLottieDebugWindow sharedInstance].appMainWindow = [UIApplication sharedApplication].keyWindow;
////        [self showDebugWindow];
//    });
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rootViewController = [[XABindLottieDebugWindowRootViewController alloc] init];
    }
    return self;
}

+ (double)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (double)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

@end


#endif
