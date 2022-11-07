//
//  XABindLottieMiddleWare.h
//  
//
//  Created by xiyuan wang on 2022/3/20.
//

#import <Foundation/Foundation.h>
#import "LOTLayerContainer.h"

NS_ASSUME_NONNULL_BEGIN

@interface XABindLottieMiddleWare : NSObject

//+ (void)didUpdateLayer:(LOTLayerContainer *)layer opacity:(float)opacity transform3D:(CATransform3D)transform3D;

+ (void)didUpdateLayer:(LOTLayerContainer *)layer frame:(NSNumber *)frame opacity:(CGFloat)opacity transform3DInfo:(NSDictionary *)transform3DInfo ;

@end

NS_ASSUME_NONNULL_END
