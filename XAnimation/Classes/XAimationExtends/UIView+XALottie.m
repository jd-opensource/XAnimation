//
//  UIView+XALottie.m
//
//
//  Created by xiyuan wang on 2022/3/20.
//

#import "UIView+XALottie.h"
#import "XABindLottieController.h"
#import <objc/runtime.h>
#import "CALayer+XALottie.h"

static const char *kXALotLayerNM = "XALotLayerNM";
static const char *kBindLotController = "XY80861";

@implementation UIView (XALottie)

- (XABindLottieController *)bindLottieWithContentsOfURL:(nonnull NSURL *)url{
    XABindLottieController *controller = [XABindLottieController bindLottieWithContentsOfURL:url toHost:self];
    if (controller){
        objc_setAssociatedObject(self, kBindLotController, controller, OBJC_ASSOCIATION_RETAIN);
        if (self.layer) {
            objc_setAssociatedObject(self.layer, kBindLotController, controller, OBJC_ASSOCIATION_RETAIN);
        }
    }
    return controller;
}

- (XABindLottieController *)bindLottieWithAnimationNamed:(NSString *)animationNamed{
    XABindLottieController *controller = [XABindLottieController bindLottieWithAnimationNamed:animationNamed toHost:self];
    if (controller){
        objc_setAssociatedObject(self, kBindLotController, controller, OBJC_ASSOCIATION_RETAIN);
    }
    return controller;
}

- (XABindLottieController *)bindLottieWithFilePath:(NSString *)filePath{
    XABindLottieController *controller = [XABindLottieController bindLottieWithFilePath:filePath toHost:self];
    if (controller){
        objc_setAssociatedObject(self, kBindLotController, controller, OBJC_ASSOCIATION_RETAIN);
    }
    return controller;
}


- (void)bindLottieLayerName:(NSString *)lotLayerName{
    if (lotLayerName && [lotLayerName isKindOfClass:[NSString class]] ) {
        objc_setAssociatedObject(self, kXALotLayerNM, lotLayerName, OBJC_ASSOCIATION_RETAIN);
        [self.layer bindLottieLayerName:lotLayerName];
    }
}

- (NSString *)bindLottieLayerName{
    NSString *name = objc_getAssociatedObject(self, kXALotLayerNM);
    return name;
}

- (XABindLottieController *)currentBindController{
    XABindLottieController *controller = objc_getAssociatedObject(self, kBindLotController);
    return controller;
}
@end
