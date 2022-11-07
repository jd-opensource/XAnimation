//
//  XABindLottieDebugWindowRootViewController.m
//  
//
//  Created by xiyuan wang on 2022/3/24.
//

#ifdef XABindLottieDebug

#import "XABindLottieDebugWindowRootViewController.h"
#import "XABindLottieHomeViewController.h"

@interface XABindLottieDebugWindowRootViewController () <UIGestureRecognizerDelegate>

@end

@implementation XABindLottieDebugWindowRootViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewControllers = @[[XABindLottieHomeViewController new]];
        self.view.clipsToBounds = NO;
        
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBarHidden = YES;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL enable = YES; // 默认为支持右滑反回
    SEL sel = @selector(gestureRecognizerShouldBegin:);
    if ([self.topViewController respondsToSelector:sel]) {
        enable = [self.topViewController performSelector:sel withObject:gestureRecognizer];
    }
    return enable;

}

@end

#endif
