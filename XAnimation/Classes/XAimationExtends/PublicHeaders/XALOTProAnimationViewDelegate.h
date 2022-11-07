//
//  XALOTProAnimationViewDelegate.h
//  
//
//  Created by xiyuan wang on 2022/3/31.
//

#import <Foundation/Foundation.h>
@class XALOTProAnimationView;

NS_ASSUME_NONNULL_BEGIN

@protocol XALOTProAnimationViewDelegate <NSObject>

- (void)animView:(XALOTProAnimationView *)animView didUpdateProgress:(CGFloat)progress;

- (void)animView:(XALOTProAnimationView *)animView layerEnterForName:(NSString *)layerName;
- (void)animView:(XALOTProAnimationView *)animView layerOutForName:(NSString *)layerName;

@end

NS_ASSUME_NONNULL_END
