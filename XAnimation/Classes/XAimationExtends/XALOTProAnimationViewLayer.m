//
//  XALOTProAnimationViewLayer.m
//
//
//  Created by xiyuan wang on 2022/4/1.
//

#import "XALOTProAnimationViewLayer.h"

@interface XALOTProAnimationViewLayer ()

@property (nonatomic, strong) NSMutableDictionary *stateMap;

@end

@implementation XALOTProAnimationViewLayer

- (instancetype)init{
    self = [super init];
    if (self) {
        _stateMap = [NSMutableDictionary new];
    }
    return self;
}


- (XALottieLayerState)getStateForLayerID:(NSNumber *)layerID{
    XALottieLayerState state = [[_stateMap objectForKey:layerID] integerValue];
    return state;
}

- (void)setStateForLayerID:(NSNumber *)layerID state:(XALottieLayerState)state{
    [_stateMap setObject:@(state) forKey:layerID];
}


@end
