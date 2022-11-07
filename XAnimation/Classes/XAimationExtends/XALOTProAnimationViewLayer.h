//
//  XALOTProAnimationViewLayer.h
//  
//
//  Created by xiyuan wang on 2022/4/1.
//

#import <QuartzCore/QuartzCore.h>
@class XALOTProAnimationView;

typedef enum : NSUInteger {
    XALottieLayerStateUnStart = 0,
    XALottieLayerStateStart = 1,
    XALottieLayerStatePlaying = 2,
    XALottieLayerStateDone = 3,
} XALottieLayerState;

NS_ASSUME_NONNULL_BEGIN

@interface XALOTProAnimationViewLayer : CALayer

@property (nonatomic, weak) XALOTProAnimationView *lotView;

- (XALottieLayerState)getStateForLayerID:(NSNumber *)layerID;
- (void)setStateForLayerID:(NSNumber *)layerID state:(XALottieLayerState)state;
- (void)cleanAllStates;

@end

NS_ASSUME_NONNULL_END
