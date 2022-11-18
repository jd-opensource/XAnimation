//
//  XABindLottieMiddleWare.m
//  
//
//  Created by xiyuan wang on 2022/3/20.
//

#import "XABindLottieMiddleWare.h"
//#import "XABindLOTAnimationViewLayer.h"
#import "XALOTProAnimationViewLayer.h"
#import "XABindLOTAnimationView.h"
#import "CALayer+XALottie.h"

#define pointRotatedAroundAnchorPoint(point,anchorPoint,angle) CGPointMake((point.x-anchorPoint.x)*cos(angle) - (point.y-anchorPoint.y)*sin(angle) + anchorPoint.x, (point.x-anchorPoint.x)*sin(angle) + (point.y-anchorPoint.y)*cos(angle)+anchorPoint.y)

@implementation XABindLottieMiddleWare

+ (XALOTProAnimationViewLayer *)proLotViewLayerForLotLayer:(LOTLayerContainer *)lotLayer{
    CALayer *rootLayer = lotLayer;
    while (rootLayer) {
        if ([rootLayer isKindOfClass:[XALOTProAnimationViewLayer class]] ) {
            break;
        }
        rootLayer = rootLayer.superlayer;
    }
    if ([rootLayer isKindOfClass:[XALOTProAnimationViewLayer class]]) {
        return  (XALOTProAnimationViewLayer *)rootLayer;
    }
    return nil;
}

+ (CALayer *)findHostLayerForLotLayer:(LOTLayerContainer *)lotLayer{
    XALOTProAnimationViewLayer *proLotViewLayer = [self proLotViewLayerForLotLayer:lotLayer];
    if ([proLotViewLayer.lotView isKindOfClass:[XABindLOTAnimationView class]] ) {
        XABindLOTAnimationView *lotV = (XABindLOTAnimationView *)proLotViewLayer.lotView;
        return lotV.hostLayer;
    }
    return nil;
}

+ (CALayer *)findBindLayerInHost:(CALayer *)hostLayer forLotLayer:(LOTLayerContainer *)lotLayer{
    if (hostLayer && lotLayer) {
        if ([lotLayer.layerName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) return nil;
            NSArray *levelArr = @[hostLayer];
            NSMutableArray *newLevelArr = nil;
            while (levelArr.count > 0) {
                newLevelArr = [NSMutableArray array];
                for (CALayer *layer in levelArr) {
                    if ([[layer bindLottieLayerName] isEqualToString:lotLayer.layerName] ) {
                        return layer;
                    }
                    if (layer.sublayers) {
                        [newLevelArr addObjectsFromArray:layer.sublayers];
                    }
                }
                levelArr = newLevelArr;
            }
    }
    return nil;
}

+ (void)didUpdateLayer:(LOTLayerContainer *)layer frame:(NSNumber *)frame opacity:(CGFloat)opacity transform3DInfo:(NSDictionary *)transform3DInfo {
    XALOTProAnimationViewLayer *lotViewLayer = [self proLotViewLayerForLotLayer:layer];
    if (lotViewLayer) {
        if (lotViewLayer.lotView.delegate) {
            if ([lotViewLayer.lotView.delegate respondsToSelector:@selector(animView:didUpdateProgress:)] ) {
                [lotViewLayer.lotView.delegate animView:lotViewLayer.lotView didUpdateProgress:lotViewLayer.lotView.animationProgress];
            }
            for (LOTLayer *layerM in lotViewLayer.lotView.sceneModel.layerGroup.layers) {
//                NSLog(@"layerName=%@, frame=%f, in=%f, out=%f", layerM.layerName, frame.doubleValue, layerM.inFrame.doubleValue, layerM.outFrame.doubleValue);
                if (frame.doubleValue < layerM.inFrame.doubleValue) {
                    [lotViewLayer setStateForLayerID:layerM.layerID state:XALottieLayerStateUnStart];
                }else if (frame.doubleValue >= layerM.inFrame.doubleValue && frame.doubleValue < fmin(layerM.outFrame.doubleValue, lotViewLayer.lotView.sceneModel.endFrame.doubleValue)) {
                    XALottieLayerState oldState = [lotViewLayer getStateForLayerID:layerM.layerID];
                    if (oldState == XALottieLayerStateUnStart ||
                        oldState == XALottieLayerStateDone) {
                        [lotViewLayer setStateForLayerID:layerM.layerID state:XALottieLayerStateStart];
                        if ([lotViewLayer.lotView.delegate respondsToSelector:@selector(animView:layerEnterForName:)] ){
                            [lotViewLayer.lotView.delegate animView:lotViewLayer.lotView layerEnterForName:layerM.layerName];
                        }
                    } else {
                        [lotViewLayer setStateForLayerID:layerM.layerID state:XALottieLayerStatePlaying];
                    }
                } else if (frame.doubleValue >= fmin(layerM.outFrame.doubleValue, lotViewLayer.lotView.sceneModel.endFrame.doubleValue)){
                    XALottieLayerState oldState = [lotViewLayer getStateForLayerID:layerM.layerID];
                    if (oldState != XALottieLayerStateDone) {
                        [lotViewLayer setStateForLayerID:layerM.layerID state:XALottieLayerStateDone];
                        if ([lotViewLayer.lotView.delegate respondsToSelector:@selector(animView:layerOutForName:)] ){
                            [lotViewLayer.lotView.delegate animView:lotViewLayer.lotView layerOutForName:layerM.layerName];
                        }
                    }
                }
            }
        }
        if ([lotViewLayer.lotView isKindOfClass:[XABindLOTAnimationView class]]) {
            CALayer *bindLayer = [self findBindLayerInHost:[self findHostLayerForLotLayer:layer] forLotLayer:layer];
            if (bindLayer) {
                bindLayer.opacity = opacity;
                if (transform3DInfo) {
                    CGPoint anchorPt = [[transform3DInfo objectForKey:@"anchorPt"] CGPointValue];
                    CGFloat rotation = [[transform3DInfo objectForKey:@"rotation"] doubleValue];
                    CGFloat scaleWidth = [[transform3DInfo objectForKey:@"scaleWidth"] doubleValue];
                    CGFloat scaleHeight = [[transform3DInfo objectForKey:@"scaleHeight"] doubleValue];
                    CGFloat tranlateX = [[transform3DInfo objectForKey:@"tranlateX"] doubleValue];
                    CGFloat tranlateY = [[transform3DInfo objectForKey:@"tranlateY"] doubleValue];
                    
                    CGPoint anchorMoveChangeFromLotToBind = CGPointMake(0, 0);
                    
                    CGFloat layerWidth = 0;
                    CGFloat layerHeight = 0;
                    if (layer.wrapperLayer.bounds.size.width > 0 || layer.wrapperLayer.bounds.size.height > 0) {
                        layerWidth = layer.wrapperLayer.bounds.size.width;
                        layerHeight = layer.wrapperLayer.bounds.size.height;
                    } else {
                        layerHeight = layer.viewportBounds.size.width;
                        layerHeight = layer.viewportBounds.size.height;
                    }
                    
                    // need buchang
                    CGPoint lotAnchor =  CGPointMake(layerWidth > 0
                                                     ? anchorPt.x  / layerWidth : 0,
                                                     layerHeight > 0 ? anchorPt.y / layerHeight : 0);
                   if (bindLayer.anchorPoint.x != lotAnchor.x
                       ||
                       bindLayer.anchorPoint.y != lotAnchor.y) {
                       CGPoint leftTopPos = CGPointMake(bindLayer.position.x - bindLayer.bounds.size.width * bindLayer.anchorPoint.x, bindLayer.position.y - bindLayer.bounds.size.height * bindLayer.anchorPoint.y);
                       CGPoint lotAnchorPos = CGPointMake(leftTopPos.x + bindLayer.bounds.size.width * lotAnchor.x, leftTopPos.y + bindLayer.bounds.size.height * lotAnchor.y);
                       CGPoint bindAnchorPos = CGPointMake(leftTopPos.x + bindLayer.bounds.size.width * bindLayer.anchorPoint.x, leftTopPos.y + bindLayer.bounds.size.height * bindLayer.anchorPoint.y);
                       
                       CGPoint lotLeftTopPos_S = CGPointMake(lotAnchorPos.x - (lotAnchorPos.x - leftTopPos.x) * scaleWidth, lotAnchorPos.y - (lotAnchorPos.y - leftTopPos.y) * scaleHeight);
                       CGPoint lotLeftTopPos_S_R = pointRotatedAroundAnchorPoint(lotLeftTopPos_S, lotAnchorPos, rotation);
                       
                       CGPoint bindLeftTopPos_S = CGPointMake(bindAnchorPos.x - (bindAnchorPos.x - leftTopPos.x) * scaleWidth, bindAnchorPos.y - (bindAnchorPos.y - leftTopPos.y) * scaleHeight);
                       CGPoint bindLeftTopPos_S_R = pointRotatedAroundAnchorPoint(bindLeftTopPos_S, bindAnchorPos, rotation);
                       anchorMoveChangeFromLotToBind = CGPointMake(bindLeftTopPos_S_R.x - lotLeftTopPos_S_R.x, bindLeftTopPos_S_R.y - lotLeftTopPos_S_R.y);
                   }
                    //end buchang
                    
                    CATransform3D translateXform = CATransform3DTranslate(CATransform3DIdentity, tranlateX - anchorMoveChangeFromLotToBind.x, tranlateY  - anchorMoveChangeFromLotToBind.y, 0);
                    CATransform3D scaleXform = CATransform3DScale(translateXform, scaleWidth, scaleHeight, 1);
                    CATransform3D rotateXform = CATransform3DRotate(scaleXform, rotation, 0, 0, 1);
//                    CATransform3D anchorXform = CATransform3DTranslate(rotateXform, - anchorMoveChangeFromLotToBind.x, - anchorMoveChangeFromLotToBind.y, 0);
                    bindLayer.transform = rotateXform;
                }
            }
        }
    }
}


/*
+ (void)didUpdateLayer:(LOTLayerContainer *)layer opacity:(float)opacity transform3D:(CATransform3D)transform3D{
//    if ([layer.layerName isEqualToString:@"牌子"]) {
//        NSLog(@"");
//    }
    CALayer *bindLayer = [self findbindLayerForLotLayer:layer];
    if (bindLayer) {
        bindLayer.anchorPoint = layer.anchorPoint;
        bindLayer.opacity = opacity;
        bindLayer.transform = transform3D;
    }
}*/
@end
