//
//  XALOTProAnimationView.m
//  
//
//  Created by xiyuan wang on 2022/3/29.
//

#import "XALOTProAnimationView.h"
#import "XALOTProAnimationViewLayer.h"

@implementation XALOTProAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        XALOTProAnimationViewLayer *layer = (XALOTProAnimationViewLayer *)self.layer;
        if ([layer isKindOfClass:[XALOTProAnimationViewLayer class]]) {
            layer.lotView = self;
        }
    }
    return self;
}

+ (Class)layerClass{
    return [XALOTProAnimationViewLayer class];
}

@end
