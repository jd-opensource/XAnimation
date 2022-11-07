//
//  XABindLOTAnimationView.m
//  
//
//  Created by xiyuan wang on 2022/3/20.
//

#import "XABindLOTAnimationView.h"
#import <objc/runtime.h>
#import "XABindLOTAnimationViewLayer.h"

@implementation XABindLOTAnimationView

- (void)setHostView:(UIView *)hostView{
    _hostView = hostView;
    self.hostLayer = hostView.layer;
}

- (UIWindow *)window{
    if (_hostView) {
        return [super window];
    }
    if (_hostLayer) {
        CALayer *windowLayer = _hostLayer;
        while (windowLayer) {
            if ([windowLayer.delegate isKindOfClass:[UIWindow class]] ) {
                return windowLayer.delegate;
            }
            windowLayer = windowLayer.superlayer;
        }
    }
    return  nil;
}

+ (Class)layerClass{
    return [XABindLOTAnimationViewLayer class];
}

@end
