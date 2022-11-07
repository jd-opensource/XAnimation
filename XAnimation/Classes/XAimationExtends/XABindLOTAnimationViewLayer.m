//
//  XABindLOTAnimationViewLayer.m
//  
//
//  Created by xiyuan wang on 2022/3/20.
//

#import "XABindLOTAnimationViewLayer.h"
#import "XABindLOTAnimationView.h"
#import "LOTCompositionContainer.h"

@interface XABindLOTAnimationViewLayer ()
@property (nonatomic, weak) UIWindow *layerWindow;

@end


@implementation XABindLOTAnimationViewLayer

- (id<CAAction>)actionForKey:(NSString *)event {
    XABindLOTAnimationView *animV = self.delegate;
    if ([animV isKindOfClass:[XABindLOTAnimationView class]] ) {
        if ([event isEqualToString:kCAOnOrderIn]) {
            if (self.superlayer == nil) {
                [self _callCompletionIfNecessary:NO];
            } else {
                UIWindow *window = nil;
                CALayer *windowLayer = self.superlayer;
                while (windowLayer) {
                    if ([windowLayer.delegate isKindOfClass:[UIWindow class]] ) {
                        window = windowLayer.delegate;
                        break;
                    }
                    windowLayer = windowLayer.superlayer;
                }
                if (
                    (window && !_layerWindow) ||
                    (!window && _layerWindow)
                    ) {
                        [self _handleWindowChanges:window != nil];
                        if (window){
                            LOTCompositionContainer *compContainer = [animV valueForKeyPath:@"compContainer"];
                            if ([compContainer isKindOfClass:[LOTCompositionContainer class]] ) {
                                compContainer.rasterizationScale = window.screen.scale;
                            } 
                        }
                }
                self.layerWindow = window;
            }
        } else if ([event isEqualToString:kCAOnOrderOut]) {
            if (self.superlayer == nil) {
                [self _callCompletionIfNecessary:NO];
            }
        }
    }

  return [super actionForKey:event];
}

- (void)_handleWindowChanges:(BOOL)param{
    XABindLOTAnimationView *animV = self.delegate;
    if (![animV isKindOfClass:[XABindLOTAnimationView class]] ) return;
    if ([animV respondsToSelector:@selector(_handleWindowChanges:)] ) {
        Class class = NSClassFromString(@"LOTAnimationView");
        SEL sel = NSSelectorFromString(@"_handleWindowChanges:");
        NSMethodSignature *signature = [class instanceMethodSignatureForSelector:sel];

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setArgument:&param atIndex:2];
        invocation.selector = sel;
        invocation.target = animV;
        [invocation invoke];
    }
}

- (void)_callCompletionIfNecessary:(BOOL)param{
    XABindLOTAnimationView *animV = self.delegate;
    if (![animV isKindOfClass:[XABindLOTAnimationView class]] ) return;
    if ([animV respondsToSelector:@selector(_callCompletionIfNecessary:)] ) {
        Class class = NSClassFromString(@"LOTAnimationView");
        SEL sel = NSSelectorFromString(@"_callCompletionIfNecessary:");
        NSMethodSignature *signature = [class instanceMethodSignatureForSelector:sel];

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setArgument:&param atIndex:2];
        invocation.selector = sel;
        invocation.target = animV;
        [invocation invoke];
    }
    
}

@end
