//
//  XABindLOTAnimationView.h
//  
//
//  Created by xiyuan wang on 2022/3/20.
//

#import "XALOTProAnimationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XABindLOTAnimationView : XALOTProAnimationView

@property (nonatomic, weak) UIView *hostView;
@property (nonatomic, weak) CALayer *hostLayer;


@end

NS_ASSUME_NONNULL_END
